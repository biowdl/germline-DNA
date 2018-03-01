import "sample.wdl" as sample
import "sampleConfig.wdl" as sampleConfig

workflow pipeline {
    Array[File] sampleConfigs
    String outputDir

    # Downloading jar for sample parsing if 'pipeline.downloadSampleConfig.inputJar' is not set
    call sampleConfig.DownloadSampleConfig as downloadSampleConfig

    #  Reading the samples from the sample config files
    call sampleConfig.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigs,
            jar = downloadSampleConfig.jar
    }

    # Running sample subworkflow
    scatter (sm in samplesConfigs.keys) {
        call sample.sample {
            input:
                outputDir = outputDir + "/samples/" + sm,
                sampleConfigJar = downloadSampleConfig.jar,
                sampleConfigs = sampleConfigs,
                sampleId = sm
        }
    }

    output {
        Array[String] samples = samplesConfigs.keys
    }
}