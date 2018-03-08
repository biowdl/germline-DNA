import "sample.wdl" as sample
import "wdl-tasks/biopet.wdl" as biopet

workflow pipeline {
    Array[File] sampleConfigs
    String outputDir
    File ref_fasta
    File ref_dict
    File ref_fasta_index

    # Downloading jar for sample parsing if 'pipeline.downloadSampleConfig.inputJar' is not set
    call biopet.DownloadSampleConfig as downloadSampleConfig

    #  Reading the samples from the sample config files
    call biopet.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigs,
            tool_jar = downloadSampleConfig.jar
    }

    # Running sample subworkflow
    scatter (sm in samplesConfigs.keys) {
        call sample.sample {
            input:
                outputDir = outputDir + "/samples/" + sm,
                sampleConfigJar = downloadSampleConfig.jar,
                sampleConfigs = sampleConfigs,
                sampleId = sm,
                ref_fasta = ref_fasta,
                ref_dict = ref_dict,
                ref_fasta_index = ref_fasta_index
        }
    }

    output {
        Array[String] samples = samplesConfigs.keys
    }
}