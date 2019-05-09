version 1.0

import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/bwa.wdl" as bwa
import "QC/QC.wdl" as qc

workflow Readgroup {
    input {
        Readgroup readgroup
        Library library
        Sample sample
        String readgroupDir
        Int numberChunks = 1
        BwaIndex bwaIndex
        Map[String, String] dockerTags
        String? platform = "illumina"
    }

    # FIXME: workaround for namepace issue in cromwell
    String sampleId = sample.id
    String libraryId = library.id
    String readgroupId = readgroup.id

    # Check MD5sums
    FastqPair reads = readgroup.reads

    # Copy raw data to output direcotry
    #FIXME remove this if cromwell cleans up its execution dir
    call common.Copy as copyR1 {
        input:
            inputFile = reads.R1,
            outputPath = readgroupDir + "/" + basename(reads.R1)
    }

    if (defined(reads.R2)) {
        call common.Copy as copyR2 {
            input:
                inputFile = select_first([reads.R2]),
                outputPath = readgroupDir + "/" + basename(select_first([reads.R2]))
        }
    }

    if (defined(reads.R1_md5)) {
        call common.CheckFileMD5 as md5CheckR1 {
            input:
                file = copyR1.outputFile,
                md5 = select_first([reads.R1_md5])
        }
    }

    if (defined(reads.R2_md5) && defined(reads.R2)) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([copyR2.outputFile]),
                md5 = select_first([reads.R2_md5])
        }
    }

    # Define chunks
    scatter (chunk in range(numberChunks)){
        String chunksR1 = "${readgroupDir}/chunk_${chunk}/${chunk}_1.fq.gz"
        String chunksR2 = "${readgroupDir}/chunk_${chunk}/${chunk}_2.fq.gz"
    }

    call biopet.FastqSplitter as fastqsplitterR1 {
        input:
            inputFastq = copyR1.outputFile,
            outputPaths = chunksR1,
            dockerTag = dockerTags["biopet-fastqsplitter"]
    }


    if (defined(readgroup.reads.R2)){
        call biopet.FastqSplitter as fastqsplitterR2 {
            input:
                inputFastq = select_first([copyR2.outputFile]),
                outputPaths = chunksR2,
                dockerTag = dockerTags["biopet-fastqsplitter"]
        }
    }

    scatter (x in range(length(chunksR1))) {
        FastqPair chunks = if defined(fastqsplitterR2.chunks)
            then {"R1": fastqsplitterR1.chunks[x],
                "R2": select_first([fastqsplitterR2.chunks])[x]}
            else {"R1": fastqsplitterR1.chunks[x]}
    }

    # QC and Mapping
    scatter (chunk in chunks) {
        String chunkDir = sub(chunk.R1, basename(chunk.R1), "")
        call qc.QC as qc {
            input:
                outputDir = chunkDir,
                read1 = chunk.R1,
                read2 = chunk.R2,
                dockerTags = dockerTags
        }

        call bwa.Mem as bwaMem {
            input:
                bwaIndex = bwaIndex,
                read1 = qc.qcRead1,
                read2 = qc.qcRead2,
                outputPath = chunkDir + "/" + basename(chunk.R1) + ".bam",
                readgroup = "@RG\\tID:~{sampleId}-~{libraryId}-~{readgroupId}\\tLB:~{libraryId}\\tSM:~{sampleId}\\tPL:~{platform}",
                bwaIndex = bwaIndex,
                dockerTag = dockerTags["bwa+picard"]
        }
    }

    output {
        FastqPair inputR1 = readgroup.reads
        Array[IndexedBamFile] bamFile = bwaMem.bamFile
    }
}
