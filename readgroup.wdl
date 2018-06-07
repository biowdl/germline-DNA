import "QC/QC.wdl" as QC
import "aligning/align-bwamem.wdl" as wdlMapping
import "tasks/biopet.wdl" as biopet

workflow readgroup {
    Array[File] sampleConfigs
    String readgroupId
    String libraryId
    String sampleId
    String outputDir
    Int numberChunks

    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            readgroup = readgroupId,
            tsvOutputPath = outputDir + "/" + readgroupId + ".config.tsv",
            keyFilePath = outputDir + "/" + readgroupId + ".config.keys"
    }

    Object configValues = if (defined(config.tsvOutput) && size(config.tsvOutput) > 0)
        then read_map(config.tsvOutput)
        else { "": "" }

    scatter (chunk in range(numberChunks)){
        String chunksR1 = "${outputDir}/chunk_${chunk}/${chunk}_1.fq.gz"
        String chunksR2 = "${outputDir}/chunk_${chunk}/${chunk}_2.fq.gz"
    }

    call biopet.FastqSplitter as fastqsplitterR1 {
        input:
            inputFastq = configValues.R1,
            outputPaths = chunksR1
    }

    call biopet.FastqSplitter as fastqsplitterR2 {
        input:
            inputFastq = configValues.R2,
            outputPaths = chunksR2
    }

    scatter (pair in zip(fastqsplitterR1.chunks, fastqsplitterR2.chunks)) {
        call QC.QC as qc {
            input:
                outputDir = sub(pair.left, basename(pair.left), ""),
                read1 = pair.left,
                read2 = pair.right
        }

        call wdlMapping.AlignBwaMem as mapping {
            input:
                inputR1 = qc.read1afterQC,
                inputR2 = qc.read2afterQC,
                outputDir = sub(pair.left, basename(pair.left), ""),
                sample = sampleId,
                library = libraryId,
                readgroup = readgroupId
        }
    }

    output {
        File inputR1 = configValues.R1
        File inputR2 = configValues.R2
        Array[File] bamFile = mapping.bamFile
        Array[File] bamIndexFile = mapping.bamIndexFile
    }
}
