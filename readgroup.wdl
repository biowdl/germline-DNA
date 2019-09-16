version 1.0

import "structs.wdl" as structs
import "tasks/fastqsplitter.wdl" as fastqsplitter
import "tasks/common.wdl" as common
import "tasks/bwa.wdl" as bwa
import "QC/QC.wdl" as qc

workflow Readgroup {
    input {
        Readgroup readgroup
        Library library
        Sample sample
        String readgroupDir
        BwaIndex bwaIndex
        Map[String, String] dockerImages
        String? platform = "illumina"
    }

    # FIXME: workaround for namepace issue in cromwell
    String sampleId = sample.id
    String libraryId = library.id
    String readgroupId = readgroup.id

    FastqPair reads = readgroup.reads

    call qc.QC as qc {
        input:
            outputDir = readgroupDir,
            read1 = reads.R1,
            read2 = reads.R2,
            dockerImages = dockerImages
    }

    call bwa.Mem as bwaMem {
        input:
            bwaIndex = bwaIndex,
            read1 = qc.qcRead1,
            read2 = qc.qcRead2,
            outputPath = readgroupDir + "/" + basename(reads.R1) + ".bam",
            readgroup = "@RG\\tID:~{sampleId}-~{libraryId}-~{readgroupId}\\tLB:~{libraryId}\\tSM:~{sampleId}\\tPL:~{platform}",
            bwaIndex = bwaIndex,
            dockerImage = dockerImages["bwa+picard"]
    }

    IndexedBamFile bwaBamFile = object {
        file: bwaMem.outputBam,
        index: bwaMem.outputBamIndex
    }

    output {
        FastqPair inputR1 = readgroup.reads
        IndexedBamFile bamFile = bwaBamFile
        Array[File] qcReports = qc.reports
    }
}
