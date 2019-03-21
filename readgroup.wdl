version 1.0

import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/bwa.wdl" as bwa
import "QC/QC.wdl" as qc
import "QC/QualityReport.wdl" as qualityReport

workflow Readgroup {
    input {
        Readgroup readgroup
        Library library
        Sample sample
        String readgroupDir
        Int numberChunks = 1
        BwaIndex bwaIndex
    }

    # FIXME: workaround for namepace issue in cromwell
    String sampleId = sample.id
    String libraryId = library.id
    String readgroupId = readgroup.id

    scatter (chunk in range(numberChunks)){
        String chunksR1 = "${readgroupDir}/chunk_${chunk}/${chunk}_1.fq.gz"
        String chunksR2 = "${readgroupDir}/chunk_${chunk}/${chunk}_2.fq.gz"
    }

    call biopet.FastqSplitter as fastqsplitterR1 {
        input:
            inputFastq = readgroup.reads.R1,
            outputPaths = chunksR1
    }


    if (defined(readgroup.reads.R2)){
        call biopet.FastqSplitter as fastqsplitterR2 {
            input:
                inputFastq = select_first([readgroup.reads.R2]),
                outputPaths = chunksR2
        }
    }

    scatter (x in range(length(chunksR1))) {
        FastqPair chunks = if defined(fastqsplitterR2.chunks)
            then {"R1": fastqsplitterR1.chunks[x],
                "R2": select_first([fastqsplitterR2.chunks])[x]}
            else {"R1": fastqsplitterR1.chunks[x]}
    }

    scatter (chunk in chunks) {

        String chunkDir = sub(chunk.R1, basename(chunk.R1), "")
        call qc.QC as qc {
            input:
                outputDir = chunkDir,
                read1 = chunk.R1,
                read2 = chunk.R2
        }

        call bwa.Mem as bwaMem {
            input:
                bwaIndex = bwaIndex,
                read1 = qc.qcRead1,
                read2 = qc.qcRead2,
                outputPath = chunkDir + "/" + basename(chunk.R1) + ".bam",
                readgroup = readgroupId,
                bwaIndex = bwaIndex
        }
    }

    output {
        FastqPair inputR1 = readgroup.reads
        Array[IndexedBamFile] bamFile = bwaMem.bamFile
    }
}
