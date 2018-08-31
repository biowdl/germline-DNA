version 1.0

import "BamMetrics/bammetrics.wdl" as bammetrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "readgroup.wdl" as readgroup
import "structs.wdl" as structs
import "tasks/biopet.wdl" as biopet
import "tasks/picard.wdl" as picard
import "tasks/samtools.wdl" as samtools

workflow Library {
    input {
        Sample sample
        Library library
        String libraryDir
        GermlineDNAinputs germlineDNAinputs
    }

    scatter (rg in library.readgroups) {
        call readgroup.Readgroup as readgroup {
            input:
                readgroupDir = libraryDir + "/rg_" + rg.id,
                readgroup = rg,
                libraryId = library.id,
                sampleId = sample.id,
                germlineDNAinputs = germlineDNAinputs
        }
    }

    call picard.MarkDuplicates as markdup {
        input:
            input_bams = flatten(readgroup.bamFile),
            output_bam_path = libraryDir + "/" + sample.id + "-" + library.id + ".markdup.bam",
            metrics_path = libraryDir + "/" + sample.id + "-" + library.id + ".markdup.metrics"
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bamFile = markdup.output_bam,
            bamIndex = markdup.output_bam_index,
            outputBamPath = libraryDir + "/" + sample.id + "-" + library.id + ".markdup.bqsr.bam",
            refFasta = germlineDNAinputs.reference.fasta,
            refDict = germlineDNAinputs.reference.dict,
            refFastaIndex = germlineDNAinputs.reference.fai,
            dbsnpVCF = germlineDNAinputs.dbSNP.file,
            dbsnpVCFindex = germlineDNAinputs.dbSNP.index
    }

    call bammetrics.BamMetrics as BamMetrics {
        input:
            bamFile = markdup.output_bam,
            bamIndex = markdup.output_bam_index,
            outputDir = libraryDir + "/metrics",
            refFasta = germlineDNAinputs.reference.fasta,
            refDict = germlineDNAinputs.reference.dict,
            refFastaIndex = germlineDNAinputs.reference.fai
    }

    output {
        File bamFile = markdup.output_bam
        File bamIndexFile = markdup.output_bam_index
        File bqsrBamFile = bqsr.outputBamFile
        File bqsrBamIndexFile = bqsr.outputBamIndex
    }
}
