import "library.wdl" as library
import "sampleConfig.wdl" as sampleConfig

workflow sample {
    Array[File] sampleConfigs
    String sampleId
    File sampleConfigJar
    String outputDir

    call sampleConfig.SampleConfig as librariesConfigs {
        input:
            jar = sampleConfigJar,
            inputFiles = sampleConfigs,
            sample = sampleId,
            jsonOutputPath = sampleId + ".config.json",
            tsvOutputPath = sampleId + ".config.tsv"
    }

    scatter (lb in librariesConfigs.keys) {
        if (lb != "") {
            call library.library {
                input:
                    outputDir = outputDir + "/lib_" + lb,
                    sampleConfigJar = sampleConfigJar,
                    sampleConfigs = select_all(librariesConfigs.jsonOutput),
                    libraryId = lb,
                    sampleId = sampleId
            }
        }
    }

    output {
        Array[String] libraries = librariesConfigs.keys
    }
}