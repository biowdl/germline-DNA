version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biowdl.wdl" as biowdl
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc

workflow Germline {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
        String outputDir = "."
        Reference reference
        BwaIndex bwaIndex
        File dockerImagesFile
        IndexedVcfFile dbSNP
        File? regions
        Boolean performGermlineVariantcalling = true
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
            old = true
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])


    # Running sample subworkflow
    scatter (sm in allSamples) {
        call sampleWorkflow.Sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm.id,
                sample = sm,
                reference = reference,
                bwaIndex = bwaIndex,
                dbSNP = dbSNP,
                dockerImages = dockerImages,
                performGermlineVariantcalling = performGermlineVariantcalling
        }

        call gvcf.Gvcf as createGvcf {
            input:
                referenceFasta = reference.fasta,
                referenceFastaFai = reference.fai,
                referenceFastaDict = reference.dict,
                bamFiles = sample.libraryBqsrBamFiles,
                outputDir = outputDir + "/samples/" + sm.id,
                gvcfName = sm.id + ".g.vcf.gz",
                dbsnpVCF = dbSNP.file,
                dbsnpVCFIndex = dbSNP.index,
                regions = regions,
                dockerImages = dockerImages
        }

        IndexedBamFile bamFiles = sample.bam
        IndexedVcfFile outputGvcf = object {file: createGvcf.outputGVcf,
            index: createGvcf.outputGVcfIndex }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = reference,
            outputDir = genotypingDir,
            gvcfFiles = outputGvcf,
            vcfBasename = "multisample",
            dbsnpVCF = dbSNP,
            dockerImages = dockerImages,
            regions = regions
    }

    # In order to pass just the index to multiQC we need to unpack it first.
    File genotypingIndex = genotyping.vcfFile.index

    if (runMultiQC) {
        call multiqc.MultiQC as multiqcTask {
            input:
                # Multiqc will only run if these files are created.
                dependencies = [genotypingIndex],
                outDir = outputDir + "/multiqc",
                analysisDirectory = outputDir,
                dockerImage = dockerImages["multiqc"]
        }
    }

    output {
        Array[IndexedBamFile] libraryMarkdupBamFiles = flatten(sample.libraryMarkdupBamFiles)
        Array[IndexedBamFile] libraryBqsrBamFiles = flatten(sample.libraryBqsrBamFiles)
        IndexedVcfFile? multiSampleVcf = genotyping.vcfFile
        Array[IndexedBamFile] sampleBams = bamFiles
        Array[File] bamMetricsFiles = flatten(sample.metricsFiles)

    }
}