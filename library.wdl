import "readgroup.wdl" as readgroup
import "tasks/biopet.wdl" as biopet
import "tasks/picard.wdl" as picard
import "tasks/samtools.wdl" as samtools
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess

workflow library {
    Array[File] sampleConfigs
    String sampleId
    String libraryId
    String outputDir
    File refFasta
    File refDict
    File refFastaIndex
    File dbsnpVCF
    File dbsnpVCFindex

    call biopet.SampleConfig as readgroupConfigs {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            tsvOutputPath = outputDir + "/" + libraryId + ".config.tsv",
            keyFilePath = outputDir + "/" + libraryId + ".config.keys"
    }

    scatter (rg in read_lines(readgroupConfigs.keysFile)) {
        if (rg != "") {
            call readgroup.readgroup as readgroup {
                input:
                    outputDir = outputDir + "/rg_" + rg,
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
            outputPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.flagstat"
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bamFile = markdup.output_bam,
            bamIndex = markdup.output_bam_index,
            outputBamPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bqsr.bam",
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            dbsnpVCF = dbsnpVCF,
            dbsnpVCFindex = dbsnpVCFindex
    }

    call samtools.Flagstat as flagstatPreprocess {
        input:
            inputBam = bqsr.outputBamFile,
            outputPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bqsr.flagstat"
    }

    output {
        Array[String] readgroups = read_lines(readgroupConfigs.keysFile)
        File bamFile = markdup.output_bam
        File bamIndexFile = markdup.output_bam_index
        File bqsrBamFile = bqsr.outputBamFile
        File bqsrBamIndexFile = bqsr.outputBamIndex
    }
}
