version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
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

    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = dbSNP,
            reference = reference
    }

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerTagsFile {
        input:
            yaml = dockerTagsFile,
            outputJson = outputDir + "/dockerTags.json"
    }
    Map[String, String] dockerTags = read_json(ConvertDockerTagsFile.json)

    call common.YamlToJson as ConvertSampleConfig {
        input:
            yaml = sampleConfigFile,
            outputJson = outputDir + "/samples.json"
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
                dockerTags = dockerTags
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