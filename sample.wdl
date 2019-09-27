version 1.0


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
        Boolean performGermlineVariantcalling
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
                dockerImages = dockerImages
        }
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
        Array[File] metricsFiles = flatten(library.metricsFiles)
    }
}
