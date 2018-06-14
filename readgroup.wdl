import "QC/AdapterClipping.wdl" as adapterClipping
import "QC/QualityReport.wdl" as qualityReport
import "aligning/align-bwamem.wdl" as wdlMapping
import "tasks/biopet.wdl" as biopet

workflow readgroup {
    Array[File] sampleConfigs
    String readgroupId
    String libraryId
    String sampleId
    String outputDir
    Int? numberChunks

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

    scatter (chunk in range(select_first([numberChunks, 1]))){
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

    call qualityReport.QualityReport as qualityReportR1 {
        input:
            read = configValues.R1,
            outputDir = outputDir + "/raw/R1",
            extractAdapters = true
    }

    call qualityReport.QualityReport as qualityReportR2 {
        input:
            read = configValues.R2,
            outputDir = outputDir + "/raw/R2",
            extractAdapters = true
    }

    scatter (pair in zip(chunksR1, zip(fastqsplitterR1.chunks, fastqsplitterR2.chunks))) {

        call adapterClipping.AdapterClipping as qc {
            input:
                outputDir = sub(pair.left, basename(pair.left), ""),
                read1 = pair.right.left,
                read2 = pair.right.right,
                adapterListRead1 = qualityReportR1.adapters,
                adapterListRead2 = qualityReportR2.adapters
        }

        call wdlMapping.AlignBwaMem as mapping {
            input:
                inputR1 = qc.read1afterClipping,
                inputR2 = qc.read2afterClipping,
                outputDir = sub(pair.left, basename(pair.left), ""),
                sample = sampleId,
                library = libraryId,
                readgroup = readgroupId
        }
    }

    call qualityReport.QualityReport as postQualityReportR1 {
        input:
            read = configValues.R1,
            outputDir = outputDir + "/QC/R1",
            extractAdapters = true
    }

    call qualityReport.QualityReport as postQualityReportR2 {
        input:
            read = configValues.R2,
            outputDir = outputDir + "/QC/R2",
            extractAdapters = true
    }


    output {
        File inputR1 = configValues.R1
        File inputR2 = configValues.R2
        Array[File] bamFile = mapping.bamFile
        Array[File] bamIndexFile = mapping.bamIndexFile
    }
}
