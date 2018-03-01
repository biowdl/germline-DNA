import "readgroup.wdl" as readgroup
import "sampleConfig.wdl" as sampleConfig
import "wdl-tasks/samtools.wdl" as samtools

workflow library {
    Array[File] sampleConfigs
    String sampleId
    String libraryId
    File sampleConfigJar
    String outputDir

    call sampleConfig.SampleConfig as readgroupConfigs {
        input:
            jar = sampleConfigJar,
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            tsvOutputPath = "samples/" + sampleId + "/libs/" + libraryId + "/" + libraryId + ".config.tsv"
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
            bamFiles = select_all(readgroup.bamFile),
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

    output {
        Array[String] readgroups = readgroupConfigs.keys
        File bamFile = markdup.outputBam
        File bamIndexFile = samtoolsIndex.indexFile
    }
}
