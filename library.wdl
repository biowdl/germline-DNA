import "readgroup.wdl" as readgroup
import "wdl-tasks/biopet.wdl" as biopet
import "wdl-tasks/samtools.wdl" as samtools
import "wdl-bqsr/bqsr.wdl" as bqsr

workflow library {
    Array[File] sampleConfigs
    String sampleId
    String libraryId
    File sampleConfigJar
    String outputDir
    File ref_fasta
    File ref_dict
    File ref_fasta_index

    call biopet.SampleConfig as readgroupConfigs {
        input:
            tool_jar = sampleConfigJar,
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            tsvOutputPath = libraryId + ".config.tsv"
    }

    scatter (rg in readgroupConfigs.keys) {
        if (rg != "") {
            call readgroup.readgroup as readgroup {
                input:
                    outputDir = outputDir + "/rg_" + rg,
                    sampleConfigJar = sampleConfigJar,
                    sampleConfigs = sampleConfigs,
                    readgroupId = rg,
                    libraryId = libraryId,
                    sampleId = sampleId
            }
        }
    }

    call samtools.Merge as bamMerge {
        input:
            bamFiles = flatten(select_all(readgroup.bamFile)),
            outputBamPath = outputDir + "/" + sampleId + "-" + libraryId + ".bam"
    }

    call samtools.Markdup as markdup {
        input:
            inputBam = bamMerge.outputBam,
            outputBamPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bam"
    }

    call samtools.Index as samtoolsIndex {
        input:
            bamFilePath = markdup.outputBam
    }

    #TODO: replace by bammetrics sub workflow
    call samtools.Flagstat as flagstat {
        input:
            inputBam = markdup.outputBam,
            outputPath = outputDir + "/" + sampleId + "-" + libraryId + ".flagstat"
    }

    call bqsr.BaseRecalibration as bqsr {
        input:
            bamFile = markdup.outputBam,
            bamIndex = samtoolsIndex.indexFile,
            outputBamPath = sub(markdup.outputBam, ".bam$", ".bqsr.bam"),
            ref_fasta = ref_fasta,
            ref_dict = ref_dict,
            ref_fasta_index = ref_fasta_index
    }

    output {
        Array[String] readgroups = readgroupConfigs.keys
        File bamFile = markdup.outputBam
        File bamIndexFile = samtoolsIndex.indexFile
        File bqsrBamFile = bqsr.outputBamFile
        File bqsrBamIndexFile = bqsr.outputBamIndex
    }
}
