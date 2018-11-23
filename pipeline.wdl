version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/multiqc.wdl" as multiqc


workflow pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
        Reference reference
        BwaIndex bwaIndex
        IndexedVcfFile dbSNP
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = dbSNP,
            reference = reference
    }

    call sampleconfig.SampleConfigCromwellArrays as configFile {
        input:
            inputFiles = sampleConfigFiles,
            outputPath = outputDir + "/samples.json"
    }

     Root config = read_json(configFile.outputFile)

    # Running sample subworkflow
    scatter (sm in config.samples) {
        call sampleWorkflow.Sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm.id,
                sample = sm,
                reference = reference,
                bwaIndex = bwaIndex,
                dbSNP = dbSNP
        }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = reference,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcf,
            vcfBasename = "multisample",
            dbsnpVCF = dbSNP,
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcf = genotyping.vcfFile,
            reference = reference,
            outputDir = genotypingDir + "/stats"
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