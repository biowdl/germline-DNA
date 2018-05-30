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
            ref_fasta = refFasta,
            ref_dict = refDict,
            ref_fasta_index = refFastaIndex,
            bamFiles = select_all(library.bqsrBamFile),
            bamIndexes = select_all(library.bqsrBamIndexFile),
            gvcf_basename = outputDir + "/" + sampleId + ".g"
    }

    output {
        File gvcf = createGvcf.output_gvcf
        File gvcf_index = createGvcf.output_gvcf_index
        Array[String] libraries = read_lines(librariesConfigs.keysFile)
    }
}