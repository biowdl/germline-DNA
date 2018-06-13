import "sample.wdl" as sampleWorkflow
import "tasks/biopet.wdl" as biopet
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping

workflow pipeline {
    Array[File] sampleConfigFiles
    String outputDir
    File refFasta
    File refDict
    File refFastaIndex

    #  Reading the samples from the sample config files
    call biopet.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigFiles,
            keyFilePath = outputDir + "/config.keys"
    }

    # Running sample subworkflow
    scatter (sm in read_lines(samplesConfigs.keysFile)) {
        call sampleWorkflow.sample as sample {
            input:
                outputDir = outputDir + "/samples/" + sm,
                sampleConfigs = sampleConfigFiles,
                sampleId = sm,
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex
        }
    }

    call jointgenotyping.JointGenotyping {
        input:
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            outputDir = outputDir,
            gvcfFiles = sample.gvcf,
            gvcfIndexes = sample.gvcfIndex,
            vcfBasename = "multisample"
    }

    output {
        Array[String] samples = read_lines(samplesConfigs.keysFile)
    }
}