import "readgroup.wdl" as readgroup
import "sampleConfig.wdl" as sampleConfig

workflow library {
    Array[File] sampleConfigs
    String sampleId
    String libraryId
    File sampleConfigJar
    String outputDir

    call sampleConfig.SampleConfig as readgroups {
        input:
            jar = sampleConfigJar,
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            tsvOutputPath = "samples/" + sampleId + "/libs/" + libraryId + "/" + libraryId + ".config.tsv"
    }

    scatter (rg in readgroups.keys) {
        if (rg != "") {
            call readgroup.readgroup {
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
}
