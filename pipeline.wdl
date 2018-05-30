import "sample.wdl" as sampleWorkflow
import "tasks/biopet.wdl" as biopet
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping

workflow pipeline {
    Array[File] sampleConfigs
    String outputDir
    File refFasta
    File refDict
    File refFastaIndex

    #  Reading the samples from the sample config files
    call biopet.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigs,
            keyFilePath = outputDir + "/config.keys"
    }

    # Running sample subworkflow
    scatter (sm in read_lines(samplesConfigs.keysFile)) {
        call sampleWorkflow.sample as sample {
            input:
                outputDir = outputDir + "/samples/" + sm,
                sampleConfigs = sampleConfigs,
                sampleId = sm,
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex
        }
    }

    call jointgenotyping.JointGenotyping {
        input:
            ref_fasta = refFasta,
            ref_dict = refDict,
            ref_fasta_index = refFastaIndex,
            outputDir = outputDir,
            gvcfFiles = sample.gvcf,
            gvcfIndexes = sample.gvcf_index,
            vcf_basename = "multisample"
    }

    output {
        Array[String] samples = read_lines(samplesConfigs.keysFile)
    }
}