version 1.0

import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "gatk-variantcalling/gatk-variantcalling.wdl" as gatkVariantWorkflow
import "gatk-variantcalling/gender-aware-variantcalling.wdl" as gatkGAVariantWorkflow
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
                reference = reference,
                bwaIndex = bwaIndex,
                dbSNP = dbSNP,
                dockerImages = dockerImages
        }
        IndexedBamFile bamFiles = sample.bqsrBamFile
        Pair[IndexedBamFile, String] bamfilesAndGenders = (bamFiles, select_first([samp.gender, "unknown"]))
    }

    if (genderAware) {
        call gatkGAVariantWorkflow.GenderAwareVariantCalling as gaVariantCalling {
            input:
                bamFilesAndGenders = bamfilesAndGenders,
                referenceFasta = reference.fasta,
                referenceFastaFai = reference.fai,
                referenceFastaDict = reference.dict,
                dbsnpVCF = dbSNP.file,
                dbsnpVCFIndex = dbSNP.index,
                outputDir = genotypingDir,
                vcfBasename = "multisample",
                dockerImages = dockerImages,
        }
    }

    # TODO: Replace when else is allowed.
    if (!genderAware) {
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
    }
    File outputVcf = select_first([gaVariantCalling.outputVcf, variantcalling.outputVcf])
    File outputVcfIndex = select_first([gaVariantCalling.outputVcfIndex, variantcalling.outputVcfIndex])


    if (runMultiQC) {
        call multiqc.MultiQC as multiqcTask {
            input:
                # Multiqc will only run if these files are created.
                dependencies = [outputVcfIndex],
                outDir = outputDir + "/multiqc",
                analysisDirectory = outputDir,
                dockerImage = dockerImages["multiqc"]
        }
    }

    output {
        File multiSampleVcf = outputVcf
        File multisampleVcfIndex = outputVcfIndex
        Array[IndexedBamFile] sampleBams = bamFiles
        Array[IndexedBamFile] markdupBams = sample.markdupBamFile
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