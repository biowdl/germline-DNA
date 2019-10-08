version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc
import "tasks/biowdl.wdl" as biowdl

workflow pipeline {
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

    call biowdl.InputConverter as ConvertSampleConfig {
        input:
            samplesheet = sampleConfigFile,
            old = true
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

    if (performGermlineVariantcalling) {
        call jointgenotyping.JointGenotyping as genotyping {
            input:
                reference = reference,
                outputDir = genotypingDir,
                gvcfFiles = select_all(sample.gvcf),
                vcfBasename = "multisample",
                dbsnpVCF = dbSNP,
                dockerImages = dockerImages,
                regions = regions
        }

        # In order to pass just the index to multiQC we need to unpack it first.
        File genotypingIndex = genotyping.vcfFile.index
    }

    if (runMultiQC) {
        call multiqc.MultiQC as multiqcTask {
            input:
                # Multiqc will only run if these files are created.
                dependencies = select_all(
                    flatten([
                        [genotypingIndex],
                        somaticVariantcalling.somaticSeqSnvVcfIndex
                    ])),
                outDir = outputDir + "/multiqc",
                analysisDirectory = outputDir,
                dockerImage = dockerImages["multiqc"]
        }
    }

    output {
        Array[IndexedBamFile] libraryMarkdupBamFiles = flatten(sample.libraryMarkdupBamFiles)
        Array[IndexedBamFile] libraryBqsrBamFiles = flatten(sample.libraryBqsrBamFiles)
        IndexedVcfFile? multiSampleVcf = genotyping.vcfFile
        Array[IndexedBamFile] sampleBams = bamFiles
        Array[File] bamMetricsFiles = flatten(sample.metricsFiles)

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