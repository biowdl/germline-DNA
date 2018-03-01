import "sampleConfig.wdl" as sampleConfig
import "QC-wdl/QC.wdl" as QC
import "wdl-mapping/wdl-mapping.wdl" as wdlMapping

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

    call wdlMapping.Mapping as mapping {
        input:
            inputR1 = config.values.R1,
            inputR2 = config.values.R2,
            outputDir = outputDir + "/mapping",
            sample = sampleId,
            library = libraryId,
            readgroup = readgroupId
    }

    output {
        File inputR1 = config.values.R1
        File inputR2 = config.values.R2
        File bamFile = mapping.bamFile
    }
}
