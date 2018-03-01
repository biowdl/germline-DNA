import "sampleConfig.wdl" as sampleConfig
import "QC-wdl/QC.wdl" as QC

workflow readgroup {
    Array[File] sampleConfigs
    String readgroupId
    String libraryId
    String sampleId
    File sampleConfigJar
    String outputDir

    call sampleConfig.SampleConfig as config {
        input:
            jar = sampleConfigJar,
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            readgroup = readgroupId,
            tsvOutputPath = "samples/" + sampleId + "/libs/" + libraryId + "/readgroups/" + readgroupId + "/" + readgroupId + ".config.tsv"
    }

    call QC.QC as qc {
        input:
            outputDir = outputDir + "/qc",
            read1 = config.values.R1,
            read2 = config.values.R2
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
