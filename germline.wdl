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
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        BwaIndex bwaIndex
        File dockerImagesFile
        File dbsnpVCF
        File dbsnpVCFIndex
        File? regions
        File? XNonParRegions
        File? YNonParRegions
        # Only run multiQC if the user specified an outputDir
        Boolean runMultiQC = if (outputDir == ".") then false else true
    }
    Boolean genderAware = defined(XNonParRegions) && defined(YNonParRegions)

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
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                bwaIndex = bwaIndex,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFIndex = dbsnpVCFIndex,
                dockerImages = dockerImages
        }
        BamAndGender bamfilesAndGenders = object {file: sample.recalibratedBam,
                                                  index: sample.recalibratedBamIndex,
                                                  gender: samp.gender}
    }

    call gatkVariantWorkflow.GatkVariantCalling as variantcalling {
        input:
            bamFilesAndGenders = bamfilesAndGenders,
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            dbsnpVCF = dbsnpVCF,
            dbsnpVCFIndex = dbsnpVCFIndex,
            XNonParRegions = XNonParRegions,
            YNonParRegions = YNonParRegions,
            regions = regions,
            outputDir = genotypingDir,
            vcfBasename = "multisample",
            dockerImages = dockerImages,
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
        Array[File] recalibratedBams = sample.recalibratedBam
        Array[File] recalibratedBamIndexes = sample.recalibratedBamIndex
        Array[File] markdupBams = sample.markdupBam
        Array[File] markudpBamIndexex = sample.markdupBamIndex
        Array[File] bamMetricsFiles = flatten(sample.metricsFiles)
    }

    parameter_meta {
        sampleConfigFile: {description: "The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.",
                           category: "required"}
        outputDir: {description: "The directory the output should be written to.", category: "common"}
        reference: {description: "The reference files: a fasta, its index and the associated sequence dictionary.", category: "required"}
        bwaIndex: {description: "The BWA index files.", category: "required"}
        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.",
                           category: "advanced"}
        dbSNP: {description: "A dbSNP VCF file and its index.", category: "required"}
        regions: {description: "A bed file describing the regions to call variants for.", category: "common"}
        runMultiQC: {description: "Whether or not MultiQC should be run.", category: "advanced"}
    }
}