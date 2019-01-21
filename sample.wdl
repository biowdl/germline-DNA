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
        Reference reference
        BwaIndex bwaIndex
        IndexedVcfFile dbSNP

        File? regions
    }

    scatter (lb in sample.libraries) {
        call libraryWorkflow.Library as library {
            input:
                libraryDir = sampleDir + "/lib_" + lb.id,
                library = lb,
                sample = sample,
                reference = reference,
                bwaIndex = bwaIndex,
                dbSNP = dbSNP,
                regions = regions
        }
    }

    call gvcf.Gvcf as createGvcf {
        input:
            reference = reference,
            bamFiles = library.bqsrBamFile,
            gvcfPath = sampleDir + "/" + sample.id + ".g.vcf.gz",
            dbsnpVCF = dbSNP,
            regions = regions
    }

    output {
        IndexedVcfFile gvcf = createGvcf.outputGVcf
    }
}
