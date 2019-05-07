version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "library.wdl" as libraryWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/samtools.wdl" as samtools

workflow Sample {
    input {
        Sample sample
        String sampleDir
        Reference reference
        BwaIndex bwaIndex
        IndexedVcfFile dbSNP
        Map[String, String] dockerTags
        File? regions
        # Fixme: Remove as soon as cromwell can overwrite subworkflows
        Array[String]+? adapters = ["AGATCGGAAGAG"]

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
                regions = regions,
                adapters = adapters,
                dockerTags = dockerTags
        }
    }

    call gvcf.Gvcf as createGvcf {
        input:
            reference = reference,
            bamFiles = library.bqsrBamFile,
            gvcfPath = sampleDir + "/" + sample.id + ".g.vcf.gz",
            dbsnpVCF = dbSNP,
            regions = regions,
            dockerTags = dockerTags
    }

    scatter (bam in library.bqsrBamFile) {
        File bqsrBamFile = bam.file

    }

    call samtools.Merge as merge {
        input:
            bamFiles = bqsrBamFile,
            outputBamPath = sampleDir + "/" + sample.id + ".bam"
    }

    call samtools.Index as index {
        input:
            bamFile = merge.outputBam,
            bamIndexPath = sampleDir + "/" + sample.id + ".bai"
    }

    output {
        IndexedBamFile bam = index.outputBam
        IndexedVcfFile gvcf = createGvcf.outputGVcf
    }
}
