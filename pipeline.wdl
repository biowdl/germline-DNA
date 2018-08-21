version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet.wdl" as biopet

workflow Pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
        GermlineDNAinputs germlineDNAinputs
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    call biopet.ValidateVcf as validateVcf {
        input:
            vcfFile = germlineDNAinputs.dbSNP,
            vcfIndex = germlineDNAinputs.dbSNPindex,
            refFasta = germlineDNAinputs.reference.fasta,
            refFastaIndex = germlineDNAinputs.reference.fai,
            refDict = germlineDNAinputs.reference.dict
    }

    call biopet.SampleConfigCromwellArrays as configFile {
        input:
            inputFiles = sampleConfigFiles,
            outputPath = outputDir + "samples.json"
    }

     Root config = read_json(configFile.outputFile)

    # Running sample subworkflow
    scatter (sm in config.samples) {
        call sampleWorkflow.Sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm.id,
                sample = sm,
                germlineDNAinputs = germlineDNAinputs
                #refFasta = germlineDNAinputs.reference.fasta,
                #refDict = germlineDNAinputs.reference.dict,
                #refFastaIndex = germlineDNAinputs.reference.fai,
                #dbsnpVCF = germlineDNAinputs.dbSNP,
                #dbsnpVCFindex = germlineDNAinputs.dbSNPindex,
                #indexFiles = germlineDNAinputs.bwaIndex.indexFiles,
                #bwaFasta = germlineDNAinputs.bwaIndex.fastaFile
        }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            refFasta = germlineDNAinputs.reference.fasta,
            refDict = germlineDNAinputs.reference.dict,
            refFastaIndex = germlineDNAinputs.reference.fai,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcf,
            gvcfIndexes = sample.gvcfIndex,
            vcfBasename = "multisample",
            dbsnpVCF = germlineDNAinputs.dbSNP,
            dbsnpVCFindex = germlineDNAinputs.dbSNPindex
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcfFile = genotyping.vcfFile,
            vcfIndex = genotyping.vcfFileIndex,
            refFasta = germlineDNAinputs.reference.fasta,
            refFastaIndex = germlineDNAinputs.reference.fai,
            refDict = germlineDNAinputs.reference.dict,
            outputDir = genotypingDir + "/stats"
    }

    output {
    }
}