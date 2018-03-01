import "sampleConfig.wdl" as sampleConfig

workflow readgroup {
    Array[File] sampleConfigs
    String readgroupId
    String libraryId
    String sampleId

    call sampleConfig.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            readgroup = readgroupId,
            tsvOutputPath = "samples/" + sampleId + "/libs/" + libraryId + "/readgroups/" + readgroupId + "/" + readgroupId + ".config.tsv"
    }


    call bla {
        input:
            R1 = config.values.R1,
            R2 = config.values.R2

    }

    output {
        File inputR1 = config.values.R1
        File inputR2 = config.values.R2
    }

}

task bla {
    File R1
    File R2
    command {
        echo ${R1} ${R2}
    }
}
