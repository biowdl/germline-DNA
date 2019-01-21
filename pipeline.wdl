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
        IndexedVcfFile dbSNP

        File? regions
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = dbSNP,
            reference = reference
    }

    call common.YamlToJson {
        input:
            yaml = sampleConfigFile
    }
    SampleConfig sampleConfig = read_json(YamlToJson.json)

    # Adding with `+` does not seem to work. But it works with flatten.
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
                regions = regions
        }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = reference,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcf,
            vcfBasename = "multisample",
            dbsnpVCF = dbSNP,
            regions = regions
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcf = genotyping.vcfFile,
            reference = reference,
            outputDir = genotypingDir + "/stats",
            intervals = regions
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            # Multiqc will only run if these files are created.
            dependencies = [genotyping.vcfFile.file],
            outDir = outputDir + "/multiqc",
            analysisDirectory = outputDir
    }

    output {
    }
}