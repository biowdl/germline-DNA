version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "library.wdl" as libraryWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common

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
                sample = sample,
                germlineDNAinputs = germlineDNAinputs
        }
    }

    call gvcf.Gvcf as createGvcf {
        input:
            reference = germlineDNAinputs.reference,
            bamFiles = library.bqsrBamFile,
            gvcfPath = sampleDir + "/" + sample.id + ".g.vcf.gz",
            dbsnpVCF = germlineDNAinputs.dbSNP,
    }

    output {
        IndexedVcfFile gvcf = createGvcf.outputGVcf
    }
}
