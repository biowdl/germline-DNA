version 1.0

import "aligning/align-bwamem.wdl" as wdlMapping
import "structs.wdl" as structs
import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "QC/QC.wdl" as qc
import "QC/QualityReport.wdl" as qualityReport

workflow Readgroup {
    input {
        Readgroup readgroup
        Library library
        Sample sample
        String readgroupDir
        Int numberChunks = 1
        GermlineDNAinputs germlineDNAinputs
    }

    if (defined(readgroup.R1_md5)) {
        call common.CheckFileMD5 as md5CheckR1 {
            input:
                file = readgroup.R1,
                MD5sum = select_first([readgroup.R1_md5])
        }
    }

    if (defined(readgroup.R2_md5)) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([readgroup.R2]),
                MD5sum = select_first([readgroup.R2_md5])
        }
    }

    scatter (chunk in range(numberChunks)){
        String chunksR1 = "${readgroupDir}/chunk_${chunk}/${chunk}_1.fq.gz"
        String chunksR2 = "${readgroupDir}/chunk_${chunk}/${chunk}_2.fq.gz"
    }

    call biopet.FastqSplitter as fastqsplitterR1 {
        input:
            inputFastq = readgroup.R1,
            outputPaths = chunksR1
    }


    if (defined(readgroup.R2)){
        call biopet.FastqSplitter as fastqsplitterR2 {
            input:
                inputFastq = select_first([readgroup.R2]),
                outputPaths = chunksR2
        }
    }

    scatter (x in range(length(chunksR1))){
        FastqPair chunks = if defined(fastqsplitterR2.chunks)
            then {"R1": fastqsplitterR1.chunks[x],
                "R2": select_first([fastqsplitterR2.chunks])[x]}
            else {"R1": fastqsplitterR1.chunks[x]}
    }

    scatter (chunk in zip(chunksR1, chunks)) {

        call qc.QC as qc {
            input:
                outputDir = sub(chunk.left, basename(chunk.left), ""),
                read1 = chunk.right.R1,
                read2 = chunk.right.R2,
                sample = sample.id,
                library = library.id,
                readgroup = readgroup.id
        }

        call wdlMapping.AlignBwaMem as mapping {
            input:
                inputR1 = qc.read1afterQC,
                inputR2 = qc.read2afterQC,
                outputDir = sub(chunk.left, basename(chunk.left), ""),
                sample = sample.id,
                library = library.id,
                readgroup = readgroup.id,
                bwaIndex = germlineDNAinputs.bwaIndex
        }
    }

    output {
        File inputR1 = readgroup.R1
        File? inputR2 = readgroup.R2
        Array[File] bamFile = mapping.bamFile
        Array[File] bamIndexFile = mapping.bamIndexFile
    }
}
