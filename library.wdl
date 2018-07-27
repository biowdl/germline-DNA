version 1.0

import "BamMetrics/bammetrics.wdl" as bammetrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "readgroup.wdl" as readgroup
import "tasks/biopet.wdl" as biopet
import "tasks/picard.wdl" as picard
import "tasks/samplesheet.wdl" as samplesheet
import "tasks/samtools.wdl" as samtools

workflow library {
    input {
        String sampleId
        Library library
        String outputDir
        File refFasta
        File refDict
        File refFastaIndex
        File dbsnpVCF
        File dbsnpVCFindex
        Array[File] indexFiles
        File refFasta
    }

    scatter (rg in library.readgroups) {
        call readgroup.readgroup as readgroup {
            input:
                outputDir = outputDir + "/rg_" + rg.id,
                readgroup = rg,
                libraryId = library.id,
                sampleId = sampleId,
                indexFiles = indexFiles,
                refFasta = refFasta
        }
    }

    call picard.MarkDuplicates as markdup {
        input:
            input_bams = flatten(readgroup.bamFile),
            output_bam_path = outputDir + "/" + sampleId + "-" + library.id + ".markdup.bam",
            metrics_path = outputDir + "/" + sampleId + "-" + library.id + ".markdup.metrics"
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bamFile = markdup.output_bam,
            bamIndex = markdup.output_bam_index,
            outputBamPath = outputDir + "/" + sampleId + "-" + library.id + ".markdup.bqsr.bam",
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            dbsnpVCF = dbsnpVCF,
            dbsnpVCFindex = dbsnpVCFindex
    }

    call bammetrics.BamMetrics as BamMetrics {
        input:
            bamFile = markdup.output_bam,
            bamIndex = markdup.output_bam_index,
            outputDir = outputDir + "/metrics",
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex
    }

    output {
        File bamFile = markdup.output_bam
        File bamIndexFile = markdup.output_bam_index
        File bqsrBamFile = bqsr.outputBamFile
        File bqsrBamIndexFile = bqsr.outputBamIndex
    }
}
