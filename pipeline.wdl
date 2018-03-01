import "sample.wdl" as sample
import "sampleConfig.wdl" as sampleConfig

workflow pipeline {
    Array[File] sampleConfigs
    String outputDir

    call sampleConfig.DownloadSampleConfig as downloadSampleConfig

    call sampleConfig.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigs,
            jar = downloadSampleConfig.jar
    }

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