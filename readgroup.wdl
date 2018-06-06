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

    call biopet.FastqSplitter as fastqsplitterR1 {
        input:
            inputFastq = configValues.R1,
            outputPath = outputDir,
            numberChunks = numberChunks
    }

    call biopet.FastqSplitter as fastqsplitterR2 {
        input:
            inputFastq = configValues.R2,
            outputPath = outputDir,
            numberChunks = numberChunks
    }

    scatter (pair in zip(fastqsplitterR1.chunkDirs, fastqsplitterR2.chunkDirs)) {
        call QC.QC as qc {
            input:
                outputDir = pair.left,
                read1 = pair.left + fastqsplitterR1.filename,
                read2 = pair.right + fastqsplitterR2.filename
        }

        call wdlMapping.AlignBwaMem as mapping {
            input:
                inputR1 = qc.read1afterQC,
                inputR2 = qc.read2afterQC,
                outputDir = pair.left,
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
