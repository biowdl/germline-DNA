version 1.0

import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "gatk-variantcalling/gatk-variantcalling.wdl" as gatkVariantWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biowdl.wdl" as biowdl
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc

workflow Germline {
    input {
        File sampleConfigFile
        String outputDir = "."
        Reference reference
        BwaIndex bwaIndex
        File dockerImagesFile
        IndexedVcfFile dbSNP
        File? regions
        # Only run multiQC if the user specified an outputDir
        Boolean runMultiQC = if (outputDir == ".") then false else true
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerImagesFile {
        input:
            yaml = dockerImagesFile
    }
    Map[String, String] dockerImages = read_json(ConvertDockerImagesFile.json)

    call biowdl.InputConverter as ConvertSampleConfig {
        input:
            samplesheet = sampleConfigFile,
            dockerImage = dockerImages["biowdl-input-converter"]
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)


    # Running sample subworkflow
    scatter (samp in sampleConfig.samples) {
        call sampleWorkflow.Sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + samp.id,
                sample = samp,
                reference = reference,
                bwaIndex = bwaIndex,
                dbSNP = dbSNP,
                dockerImages = dockerImages
        }
        IndexedBamFile bamFiles = sample.bqsrBamFile
    }

    call gatkVariantWorkflow.GatkVariantCalling as variantcalling {
        input:
            bamFiles = bamFiles,
            referenceFasta = reference.fasta,
            referenceFastaFai = reference.fai,
            referenceFastaDict = reference.dict,
            dbsnpVCF = dbSNP.file,
            dbsnpVCFIndex = dbSNP.index,
            outputDir = genotypingDir,
            vcfBasename = "multisample",
            dockerImages = dockerImages,
            regions = regions
    }

    if (runMultiQC) {
        call multiqc.MultiQC as multiqcTask {
            input:
                # Multiqc will only run if these files are created.
                dependencies = [variantcalling.outputVcfIndex],
                outDir = outputDir + "/multiqc",
                analysisDirectory = outputDir,
                dockerImage = dockerImages["multiqc"]
        }
    }

    output {
        File multiSampleVcf = variantcalling.outputVcf
        File multisampleVcfIndex = variantcalling.outputVcfIndex
        Array[IndexedBamFile] sampleBams = bamFiles
        Array[IndexedBamFile] markdupBams = sample.markdupBamFile
        Array[File] bamMetricsFiles = flatten(sample.metricsFiles)
    }
}