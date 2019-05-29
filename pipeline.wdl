version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc


workflow pipeline {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
        String outputDir
        Reference reference
        BwaIndex bwaIndex
        File dockerTagsFile
        IndexedVcfFile dbSNP
        File? regions
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerTagsFile {
        input:
            yaml = dockerTagsFile
    }
    Map[String, String] dockerTags = read_json(ConvertDockerTagsFile.json)

    call common.YamlToJson as ConvertSampleConfig {
        input:
            yaml = sampleConfigFile
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])


    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = dbSNP,
            reference = reference,
            dockerTag = dockerTags["biopet-validatevcf"]
    }

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
                dockerTags = dockerTags
        }

        String sampleIds = sm.id
        IndexedBamFile bamFiles = sample.bam
    }

    scatter (sm in allSamples) {
        if (defined(sm.control)) {
            call GetSamplePositionInArray as contolPosition  {
                input:
                    sampleIds = sampleIds,
                    sample = select_first([sm.control])
            }

            call GetSamplePositionInArray as casePosition  {
                input:
                    sampleIds = sampleIds,
                    sample = sm.id
            }

            call somaticVariantcallingWorkflow.SomaticVariantcalling as somaticVariantcalling {
                input:
                    outputDir = outputDir + "/samples/" + sm.id + "/somatic-variantcalling/",
                    reference = reference,
                    tumorSample = sm.id,
                    tumorBam = bamFiles[casePosition.position],
                    controlSample = sampleIds[contolPosition.position],
                    controlBam = bamFiles[contolPosition.position],
                    regions = regions,
                    dockerTags = dockerTags
            }
        }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = reference,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcf,
            vcfBasename = "multisample",
            dbsnpVCF = dbSNP,
            dockerTags = dockerTags,
            regions = regions
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcf = genotyping.vcfFile,
            reference = reference,
            outputDir = genotypingDir + "/stats",
            dockerTag = dockerTags["biopet-vcfstats"],
            intervals = regions
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            # Multiqc will only run if these files are created.
            dependencies = [genotyping.vcfFile.file],
            outDir = outputDir + "/multiqc",
            analysisDirectory = outputDir,
            dockerTag = dockerTags["multiqc"]
    }

    output {
    }
}

task GetSamplePositionInArray {
    input {
        Array[String] sampleIds
        String sample

        String dockerTag = "3.7-slim"
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
        docker: "python:" + dockerTag
        # 4 gigs of memory to be able to build the docker image in singularity
        memory: 4
    }
}