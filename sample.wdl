import "library.wdl" as library
import "sampleConfig.wdl" as sampleConfig

workflow sample {
    Array[File] sampleConfigs
    String sampleId

    call sampleConfig.SampleConfig as librariesConfigs {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            jsonOutputPath = "samples/" + sampleId + "/" + sampleId + ".config.json",
            tsvOutputPath = "samples/" + sampleId + "/" + sampleId + ".config.tsv"
    }

    scatter (lb in librariesConfigs.keys) {
        if (lb != "") {
            call library.library {
                input:
                    sampleConfigs = sampleConfigs,
                    libraryId = lb,
                    sampleId = sampleId
            }
        }
    }

    output {
        Array[String] libraries = librariesConfigs.keys
    }
}