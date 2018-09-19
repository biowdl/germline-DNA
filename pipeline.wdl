version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig

workflow pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
        GermlineDNAinputs germlineDNAinputs
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = germlineDNAinputs.dbSNP,
            reference = germlineDNAinputs.reference
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
                germlineDNAinputs = germlineDNAinputs
        }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = germlineDNAinputs.reference,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcf,
            vcfBasename = "multisample",
            dbsnpVCF = germlineDNAinputs.dbSNP,
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcf = genotyping.vcfFile,
            reference = germlineDNAinputs.reference,
            outputDir = genotypingDir + "/stats"
    }

    output {
    }
}