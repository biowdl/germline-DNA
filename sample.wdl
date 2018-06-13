import "library.wdl" as libraryWorkflow
import "tasks/biopet.wdl" as biopet
import "bam-to-gvcf/gvcf.wdl" as gvcf

workflow sample {
    Array[File] sampleConfigs
    String sampleId
    String outputDir
    File refFasta
    File refDict
    File refFastaIndex

    call biopet.SampleConfig as librariesConfigs {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            jsonOutputPath = outputDir + "/" + sampleId + ".config.json",
            tsvOutputPath = outputDir + "/" + sampleId + ".config.tsv",
            keyFilePath = outputDir + "/" + sampleId + ".config.keys"
    }

    scatter (lb in read_lines(librariesConfigs.keysFile)) {
        if (lb != "") {
            call libraryWorkflow.library as library {
                input:
                    outputDir = outputDir + "/lib_" + lb,
                    sampleConfigs = select_all([librariesConfigs.jsonOutput]),
                    libraryId = lb,
                    sampleId = sampleId,
                    refFasta = refFasta,
                    refDict = refDict,
                    refFastaIndex = refFastaIndex
            }
        }
    }

    call gvcf.Gvcf as createGvcf {
        input:
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            bamFiles = select_all(library.bqsrBamFile),
            bamIndexes = select_all(library.bqsrBamIndexFile),
            gvcfPath = outputDir + "/" + sampleId + ".g.vcf.gz"
    }

    output {
        File gvcf = createGvcf.outputGVCF
        File gvcfIndex = createGvcf.outputGVCFindex
        Array[String] libraries = read_lines(librariesConfigs.keysFile)
    }
}