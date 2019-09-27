version 1.0

import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc


workflow Somatic {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
        String outputDir = "."
        Reference reference
        BwaIndex bwaIndex
        File dockerImagesFile
        IndexedVcfFile dbSNP
        File? regions
        Boolean performGermlineVariantcalling = true
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

    call common.YamlToJson as ConvertSampleConfig {
        input:
            yaml = sampleConfigFile
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])

    # Running sample subworkflow
    scatter (sm in allSamples) {
        call sampleWorkflow.Sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm.id,
                sample = sm,
                reference = reference,
                bwaIndex = bwaIndex,
                dbSNP = dbSNP,
                regions = regions,
                dockerImages = dockerImages,
                performGermlineVariantcalling = performGermlineVariantcalling
        }

        String sampleIds = sm.id
        IndexedBamFile bamFiles = sample.bam
    }

    scatter (sm in allSamples) {
        if (defined(sm.control)) {
            call GetSamplePositionInArray as controlPostition  {
                input:
                    sampleIds = sampleIds,
                    sample = select_first([sm.control])
            }

            call GetSamplePositionInArray as casePosition  {
                input:
                    sampleIds = sampleIds,
                    sample = sm.id,
                    dockerImage = dockerImages["python"]
            }

            call somaticVariantcallingWorkflow.SomaticVariantcalling as somaticVariantcalling {
                input:
                    outputDir = outputDir + "/samples/" + sm.id + "/somatic-variantcalling/",
                    referenceFasta = reference.fasta,
                    referenceFastaFai = reference.fai,
                    referenceFastaDict = reference.dict,
                    tumorSample = sm.id,
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
        Array[IndexedBamFile] libraryMarkdupBamFiles = flatten(sample.libraryMarkdupBamFiles)
        Array[IndexedBamFile] libraryBqsrBamFiles = flatten(sample.libraryBqsrBamFiles)
        Array[IndexedBamFile] sampleBams = bamFiles
        Array[File] bamMetricsFiles = flatten(sample.metricsFiles)
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
        memory: 4
    }
}