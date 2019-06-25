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
            referenceFasta = reference.fasta,
            referenceFastaFai = reference.fai,
            referenceFastaDict = reference.dict,
            bamFiles = library.bqsrBamFile,
            outputDir = sampleDir,
            gvcfName = sample.id + ".g.vcf.gz",
            dbsnpVCF = dbSNP.file,
            dbsnpVCFIndex = dbSNP.index,
            regions = regions,
            dockerImages = dockerImages
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
        IndexedVcfFile gvcf = object {file: createGvcf.outputGVcf, index: createGvcf.outputGVcf.index }
        Array[File] metricsFiles = flatten(library.metricsFiles)
    }
}
