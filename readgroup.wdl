version 1.0

import "aligning/align-bwamem.wdl" as wdlMapping
import "samplesheet.wdl" as samplesheet
import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "QC/AdapterClipping.wdl" as adapterClipping
import "QC/QualityReport.wdl" as qualityReport

workflow readgroup {
    input {
        Readgroup readgroup
        String libraryId
        String sampleId
        String outputDir
        Int numberChunks = 1
        Array[File] indexFiles
        File bwaFasta
    }

    call common.CheckFileMD5 as md5CheckR1 {
        input:
            file = readgroup.R1,
            MD5sum = readgroup.R1_md5
    }

    if (defined(readgroup.R2)){
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([readgroup.R2]),
                MD5sum = select_first([readgroup.R2_md5])
        }
    }

    scatter (chunk in range(numberChunks)){
        String chunksR1 = "${outputDir}/chunk_${chunk}/${chunk}_1.fq.gz"
        String chunksR2 = "${outputDir}/chunk_${chunk}/${chunk}_2.fq.gz"
    }

    call biopet.FastqSplitter as fastqsplitterR1 {
        input:
            inputFastq = readgroup.R1,
            outputPaths = chunksR1
    }

    call qualityReport.QualityReport as qualityReportR1 {
        input:
            read = readgroup.R1,
            outputDir = outputDir + "/raw/R1",
            extractAdapters = true
    }

    if (defined(readgroup.R2)){
        call biopet.FastqSplitter as fastqsplitterR2 {
            input:
                inputFastq = select_first([readgroup.R2]),
                outputPaths = chunksR2
        }

        call qualityReport.QualityReport as qualityReportR2 {
            input:
                read = select_first([readgroup.R2]),
                outputDir = outputDir + "/raw/R2",
                extractAdapters = true
        }
    }

    scatter (x in range(length(chunksR1))){
        Chunk chunks = if defined(fastqsplitterR2.chunks)
            then {"R1": fastqsplitterR1.chunks[x],
                "R2": select_first([fastqsplitterR2.chunks])[x]}
            else {"R1": fastqsplitterR1.chunks[x]}
    }

    scatter (chunk in zip(chunksR1, chunks)) {

        call adapterClipping.AdapterClipping as qc {
            input:
                outputDir = sub(chunk.left, basename(chunk.left), ""),
                read1 = chunk.right.R1,
                read2 = chunk.right.R2,
                adapterListRead1 = qualityReportR1.adapters,
                adapterListRead2 = qualityReportR2.adapters
        }

        call wdlMapping.AlignBwaMem as mapping {
            input:
                inputR1 = qc.read1afterClipping,
                inputR2 = qc.read2afterClipping,
                outputDir = sub(chunk.left, basename(chunk.left), ""),
                sample = sampleId,
                library = libraryId,
                readgroup = readgroup.id,
                indexFiles = indexFiles,
                refFasta = bwaFasta
        }
    }

#TODO: getting total file
#    call qualityReport.QualityReport as postQualityReportR1 {
#        input:
#            read = configValues.R1,
#            outputDir = outputDir + "/QC/R1",
#            extractAdapters = true
#    }
#
#    call qualityReport.QualityReport as postQualityReportR2 {
#        input:
#            read = configValues.R2,
#            outputDir = outputDir + "/QC/R2",
#            extractAdapters = true
#    }

    output {
        File inputR1 = readgroup.R1
        File? inputR2 = readgroup.R2
        Array[File] bamFile = mapping.bamFile
        Array[File] bamIndexFile = mapping.bamIndexFile
    }
}

struct Chunk {
    File R1
    File? R2
}