version 1.0

import "BamMetrics/bammetrics.wdl" as bammetrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "readgroup.wdl" as readgroup
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/picard.wdl" as picard
import "tasks/samtools.wdl" as samtools

workflow Library {
    input {
        Sample sample
        Library library
        String libraryDir
        Reference reference
        #BwaIndex bwaIndex
        IndexedVcfFile dbSNP
    }

    scatter (rg in library.readgroups) {
        call readgroup.Readgroup as readgroup {
            input:
                readgroupDir = libraryDir + "/rg_" + rg.id,
                readgroup = rg,
                library = library,
                sample = sample,
                germlineDNAinputs = germlineDNAinputs
        }
    }

    scatter (bam in flatten(readgroup.bamFile)) {
        File bamFiles = bam.file
        File indexFiles = bam.index
    }

    call picard.MarkDuplicates as markdup {
        input:
            inputBams = bamFiles,
            inputBamIndexes = indexFiles,
            outputBamPath = libraryDir + "/" + sample.id + "-" + library.id + ".markdup.bam",
            metricsPath = libraryDir + "/" + sample.id + "-" + library.id + ".markdup.metrics"
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bamFile = markdup.outputBam,
            basePath = libraryDir + "/" + sample.id + "-" + library.id + ".markdup",
            outputRecalibratedBam = true,
            reference = reference,
            dbsnpVCF = dbSNP
    }

    call bammetrics.BamMetrics as BamMetrics {
        input:
            bam = markdup.outputBam,
            outputDir = libraryDir + "/metrics",
            reference = reference
    }

    output {
        IndexedBamFile bamFile = markdup.outputBam
        IndexedBamFile bqsrBamFile = select_first([bqsr.outputBamFile])
    }
}
