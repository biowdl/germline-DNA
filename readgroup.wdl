import "sampleConfig.wdl" as sampleConfig
import "QC-wdl/QC.wdl" as QC
import "wdl-mapping/wdl-mapping.wdl" as wdlMapping
import "wdl-tasks/fastqsplitter.wdl" as fastqsplitter

workflow readgroup {
    Array[File] sampleConfigs
    String readgroupId
    String libraryId
    String sampleId
    File sampleConfigJar
    String outputDir
    Int numberChunks = 1

    call sampleConfig.SampleConfig as config {
        input:
            jar = sampleConfigJar,
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            readgroup = readgroupId,
            tsvOutputPath = "samples/" + sampleId + "/libs/" + libraryId + "/readgroups/" + readgroupId + "/" + readgroupId + ".config.tsv"
    }

    call fastqsplitter.FastqSplitter as fastqsplitterR1 {
        input:
            inputFastq = config.values.R1,
            outputPath = outputDir,
            numberChunks = numberChunks
    }

    call fastqsplitter.FastqSplitter as fastqsplitterR2 {
        input:
            inputFastq = config.values.R2,
            outputPath = outputDir,
            numberChunks = numberChunks
    }

    scatter (pair in zip(fastqsplitterR1.outputFastqFiles, fastqsplitterR1.outputFastqFiles)) {
        call QC.QC as qc {
            input:
                outputDir = outputDir + "/qc",
                read1 = pair.left,
                read2 = pair.right
        }

        call wdlMapping.Mapping as mapping {
            input:
                inputR1 = qc.read1afterQC,
                inputR2 = qc.read2afterQC,
                outputDir = outputDir,
                sample = sampleId,
                library = libraryId,
                readgroup = readgroupId
        }
    }

    output {
        File inputR1 = config.values.R1
        File inputR2 = config.values.R2
        Array[File] bamFile = mapping.bamFile
        Array[File] bamIndexFile = mapping.bamIndexFile
    }
}
