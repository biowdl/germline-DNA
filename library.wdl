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
        BwaIndex bwaIndex
        IndexedVcfFile dbSNP
        Map[String, String] dockerTags

        File? regions
    }

    scatter (rg in library.readgroups) {
        call readgroup.Readgroup as readgroup {
            input:
                readgroupDir = libraryDir + "/rg_" + rg.id,
                readgroup = rg,
                library = library,
                sample = sample,
                bwaIndex = bwaIndex,
                dockerTags = dockerTags
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
            metricsPath = libraryDir + "/" + sample.id + "-" + library.id + ".markdup.metrics",
            dockerTag = dockerTags["picard"]
    }

    IndexedBamFile markdupBamFile = object {
            file: markdup.outputBam,
            index: markdup.outputBamIndex,
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bamFile = markdupBamFile,
            basePath = libraryDir + "/" + sample.id + "-" + library.id + ".markdup",
            outputRecalibratedBam = true,
            reference = reference,
            dbsnpVCF = dbSNP,
            regions = regions,
            dockerTags = dockerTags
    }

    call bammetrics.BamMetrics as BamMetrics {
        input:
            bam = markdupBamFile ,
            outputDir = libraryDir + "/metrics",
            reference = reference,
            dockerTags = dockerTags
    }

    output {
        IndexedBamFile bamFile = markdupBamFile
        IndexedBamFile bqsrBamFile = select_first([bqsr.outputBamFile])
        Array[File] metricsFiles = flatten([[BamMetrics.flagstats], BamMetrics.picardMetricsFiles, readgroup.qcReports])
    }
}
