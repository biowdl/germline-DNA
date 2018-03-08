import "readgroup.wdl" as readgroup
import "wdl-tasks/biopet.wdl" as biopet
import "wdl-tasks/picard.wdl" as picard
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

    call picard.MarkDuplicates as markdup {
        input:
            input_bams = flatten(select_all(readgroup.bamFile)),
            output_bam_path = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bam",
            metrics_path = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.metrics"
    }

    #TODO: replace by bammetrics sub workflow
    call samtools.Flagstat as flagstat {
        input:
            inputBam = markdup.output_bam,
            outputPath = outputDir + "/" + sampleId + "-" + libraryId + ".flagstat"
    }

    call bqsr.BaseRecalibration as bqsr {
        input:
            bamFile = markdup.output_bam,
            bamIndex = markdup.output_bam_index,
            outputBamPath = sub(markdup.output_bam, ".bam$", ".bqsr.bam"),
            ref_fasta = ref_fasta,
            ref_dict = ref_dict,
            ref_fasta_index = ref_fasta_index
    }

    output {
        Array[String] readgroups = readgroupConfigs.keys
        File bamFile = markdup.output_bam
        File bamIndexFile = markdup.output_bam_index
        File bqsrBamFile = bqsr.outputBamFile
        File bqsrBamIndexFile = bqsr.outputBamIndex
    }
}
