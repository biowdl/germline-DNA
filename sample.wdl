version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "library.wdl" as libraryWorkflow
import "structs.wdl" as structs
import "tasks/biopet.wdl" as biopet

workflow Sample {
    input {
        Sample sample
        String sampleDir
        GermlineDNAinputs germlineDNAinputs
    }

    scatter (lb in sample.libraries) {
        call libraryWorkflow.Library as library {
            input:
                libraryDir = sampleDir + "/lib_" + lb.id,
                library = lb,
                sampleId = sample.id,
                germlineDNAinputs = germlineDNAinputs
        }
    }

    call gvcf.Gvcf as createGvcf {
        input:
            refFasta = germlineDNAinputs.reference.fasta,
            refDict = germlineDNAinputs.reference.dict,
            refFastaIndex = germlineDNAinputs.reference.fai,
            bamFiles = library.bqsrBamFile,
            bamIndexes = library.bqsrBamIndexFile,
            gvcfPath = sampleDir + "/" + sample.id + ".g.vcf.gz",
            dbsnpVCF = germlineDNAinputs.dbSNP.file,
            dbsnpVCFindex = germlineDNAinputs.dbSNP.index
    }

    output {
        File gvcf = createGvcf.outputGVCF
        File gvcfIndex = createGvcf.outputGVCFindex
    }
}