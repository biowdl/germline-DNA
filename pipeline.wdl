version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "samplesheet.wdl" as samplesheet
import "tasks/biopet.wdl" as biopet

workflow pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
        File refFasta
        File refDict
        File refFastaIndex
        File dbsnpVCF
        File dbsnpVCFindex
        Array[File] indexFiles
        File bwaFasta
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    call biopet.ValidateVcf as validateVcf {
        input:
            vcfFile = dbsnpVCF,
            vcfIndex = dbsnpVCFindex,
            refFasta = refFasta,
            refFastaIndex = refFastaIndex,
            refDict = refDict
    }

    # Parse sample configs
    scatter (sampleConfigFile in sampleConfigFiles) {
        call samplesheet.SampleConfigFileToStruct as config {
            input:
                sampleConfigFile = sampleConfigFile
        }
    }

    Array[Sample] samples = flatten(config.samples)

    # Running sample subworkflow
    scatter (sm in samples) {
        call sampleWorkflow.sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm.id,
                sample = sm,
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFindex = dbsnpVCFindex,
                indexFiles = indexFiles,
                bwaFasta = bwaFasta
        }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcf,
            gvcfIndexes = sample.gvcfIndex,
            vcfBasename = "multisample",
            dbsnpVCF = dbsnpVCF,
            dbsnpVCFindex = dbsnpVCFindex
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcfFile = genotyping.vcfFile,
            vcfIndex = genotyping.vcfFileIndex,
            refFasta = refFasta,
            refFastaIndex = refFastaIndex,
            refDict = refDict,
            outputDir = genotypingDir + "/stats"
    }

    output {
    }
}