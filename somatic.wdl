version 1.0

import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biowdl.wdl" as biowdl
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc

workflow Somatic {
    input {
        File sampleConfigFile
        String outputDir = "."
        Reference reference
        BwaIndex bwaIndex
        File dockerImagesFile
        IndexedVcfFile dbSNP
        File? regions
        # Only run multiQC if the user specified an outputDir
        Boolean runMultiQC = if (outputDir == ".") then false else true
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerImagesFile {
        input:
            yaml = dockerImagesFile
    }
    Map[String, String] dockerImages = read_json(ConvertDockerImagesFile.json)

    call biowdl.InputConverter as ConvertSampleConfig {
        input:
            samplesheet = sampleConfigFile,
            dockerImage = dockerImages["biowdl-input-converter"]
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)

    # Running sample subworkflow
    scatter (sample in sampleConfig.samples) {
        call sampleWorkflow.Sample as sampleWf {
            input:
                sampleDir = outputDir + "/samples/" + sample.id,
                sample = sample,
                reference = reference,
                bwaIndex = bwaIndex,
                dbSNP = dbSNP,
                dockerImages = dockerImages
        }

        String sampleIds = sample.id
        IndexedBamFile bamFiles = sampleWf.bqsrBamFile
    }

    scatter (sample in sampleConfig.samples) {
        if (defined(sample.control)) {
            call GetSamplePositionInArray as controlPostition  {
                input:
                    sampleIds = sampleIds,
                    sample = select_first([sample.control])
            }

            call GetSamplePositionInArray as casePosition  {
                input:
                    sampleIds = sampleIds,
                    sample = sample.id,
                    dockerImage = dockerImages["python"]
            }

            call somaticVariantcallingWorkflow.SomaticVariantcalling as somaticVariantcalling {
                input:
                    outputDir = outputDir + "/samples/" + sample.id + "/somatic-variantcalling/",
                    referenceFasta = reference.fasta,
                    referenceFastaFai = reference.fai,
                    referenceFastaDict = reference.dict,
                    tumorSample = sample.id,
                    tumorBam = bamFiles[casePosition.position].file,
                    tumorBamIndex = bamFiles[casePosition.position].index,
                    controlSample = sampleIds[controlPostition.position],
                    controlBam = bamFiles[controlPostition.position].file,
                    controlBamIndex = bamFiles[controlPostition.position].index,
                    regions = regions,
                    dockerImages = dockerImages
            }
        }
    }

    if (runMultiQC) {
        call multiqc.MultiQC as multiqcTask {
            input:
                # Multiqc will only run if these files are created.
                dependencies = select_all(somaticVariantcalling.somaticSeqSnvVcfIndex),
                outDir = outputDir + "/multiqc",
                analysisDirectory = outputDir,
                dockerImage = dockerImages["multiqc"]
        }
    }

    output {
        Array[IndexedBamFile] sampleBams = bamFiles
        Array[IndexedBamFile] markdupBams = sampleWf.markdupBamFile
        Array[File] bamMetricsFiles = flatten(sampleWf.metricsFiles)
        Array[File?] somaticSeqSnvVcf = somaticVariantcalling.somaticSeqSnvVcf
        Array[File?] somaticSeqSnvVcfIndex = somaticVariantcalling.somaticSeqSnvVcfIndex
        Array[File?] somaticSeqIndelVcf = somaticVariantcalling.somaticSeqIndelVcf
        Array[File?] somaticSeqIndelVcfIndex = somaticVariantcalling.somaticSeqIndelVcfIndex
        Array[File?] mutect2Vcf = somaticVariantcalling.mutect2Vcf
        Array[File?] mutect2VcfIndex = somaticVariantcalling.mutect2VcfIndex
        Array[File?] vardictVcf = somaticVariantcalling.vardictVcf
        Array[File?] vardictVcfIndex = somaticVariantcalling.vardictVcfIndex
        Array[File?] strelkaSnvsVcf = somaticVariantcalling.strelkaSnvsVcf
        Array[File?] strelkaSnvsVcfIndex = somaticVariantcalling.strelkaSnvsVcfIndex
        Array[File?] strelkaIndelsVcf = somaticVariantcalling.strelkaIndelsVcf
        Array[File?] strelkaIndelsVcfIndex = somaticVariantcalling.strelkaIndelsVcfIndex
        Array[File?] strelkaCombinedVcf = somaticVariantcalling.strelkaCombinedVcf
        Array[File?] strelkaCombinedVcfIndex = somaticVariantcalling.strelkaCombinedVcfIndex
        Array[File?] mantaVcf = somaticVariantcalling.mantaVcf
        Array[File?] mantaVcfIndex = somaticVariantcalling.mantaVcfIndex
        Array[File?] combinedVcf = somaticVariantcalling.combinedVcf
        Array[File?] combinedVcfIndex = somaticVariantcalling.combinedVcfIndex
        Array[File?] ensembleIndelsClassifier = somaticVariantcalling.ensembleIndelsClassifier
        Array[File?] ensembleSNVClassifier = somaticVariantcalling.ensembleSNVClassifier
    }
}

task GetSamplePositionInArray {
    input {
        Array[String] sampleIds
        String sample

        String dockerImage = "python:3.7-slim"
    }

    command <<<
        python <<CODE
        for i, sample in enumerate(['~{sep="','" sampleIds}']):
            if sample == '~{sample}':
                print(i)
                exit()
        CODE
    >>>

    output {
        Int position = read_int(stdout())
    }

    runtime {
        docker: dockerImage
        # 4 gigs of memory to be able to build the docker image in singularity
        memory: "4G"
    }
}