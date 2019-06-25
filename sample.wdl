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
        Map[String, String] dockerImages
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
                regions = regions,
                dockerImages = dockerImages
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
            outputBamPath = sampleDir + "/" + sample.id + ".bam",
            dockerImage = dockerImages["samtools"]
    }

    output {
        Array[IndexedBamFile] libraryMarkdupBamFiles = library.bamFile
        Array[IndexedBamFile] libraryBqsrBamFiles = library.bqsrBamFile
        IndexedBamFile bam = object {
          file: merge.outputBam,
          index: merge.outputBamIndex
        }
        IndexedVcfFile gvcf = createGvcf.outputGVcf
        Array[File] metricsFiles = flatten(library.metricsFiles)
    }
}
