version 1.0

import "gatk-CNVcalling/pairedCnvCalling.wdl" as pairedCnvCalling
import "gatk-CNVcalling/CNV-PON.wdl" as cnvPon
import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biowdl.wdl" as biowdl
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc

workflow Somatic {
    input {
        File sampleConfigFile
        String outputDir = "."
        Reference reference
        BwaIndex bwaIndex
        IndexedVcfFile dbSNP
        File? regions
        Boolean performCnvCalling = false
        File? CnvPanelOfNormals
        File? preprocessedIntervals
        # Only run multiQC if the user specified an outputDir
        Boolean runMultiQC = if (outputDir == ".") then false else true

        File dockerImagesFile
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

        String sampleIds = samp.id
        IndexedBamFile bamFiles = sample.bqsrBamFile
        if (!defined(samp.control)) {
            File controlBams = sample.bqsrBamFile.file
            File controlBamIndexes = sample.bqsrBamFile.index
        }
    }

    if (performCnvCalling && (! defined(CnvPanelOfNormals) || ! defined(preprocessedIntervals))) {
        call cnvPon.PanelOfNormals as panelOfNormals {
            input:
                inputBams = select_all(controlBams),
                inputBamIndexes = select_all(controlBamIndexes),
                referenceFasta = reference.fasta,
                referenceFastaFai = reference.fai,
                referenceFastaDict = reference.dict,
                regions = regions,
                outputDir = outputDir + "/PON/",
                dockerImages = {"gatk": dockerImages["gatk-broad"]}  # These tasks will run into trouble with the biocontainers
        }
    }

    scatter (samp in sampleConfig.samples) {
        if (defined(samp.control)) {
            call GetSamplePositionInArray as controlPostition  {
                input:
                    sampleIds = sampleIds,
                    sample = select_first([samp.control])
            }

            call GetSamplePositionInArray as casePosition  {
                input:
                    sampleIds = sampleIds,
                    sample = samp.id,
                    dockerImage = dockerImages["python"]
            }

            call somaticVariantcallingWorkflow.SomaticVariantcalling as somaticVariantcalling {
                input:
                    outputDir = outputDir + "/samples/" + samp.id + "/somatic-variantcalling/",
                    referenceFasta = reference.fasta,
                    referenceFastaFai = reference.fai,
                    referenceFastaDict = reference.dict,
                    tumorSample = samp.id,
                    tumorBam = bamFiles[casePosition.position].file,
                    tumorBamIndex = bamFiles[casePosition.position].index,
                    controlSample = sampleIds[controlPostition.position],
                    controlBam = bamFiles[controlPostition.position].file,
                    controlBamIndex = bamFiles[controlPostition.position].index,
                    regions = regions,
                    dockerImages = dockerImages
            }

            if (performCnvCalling) {
                call pairedCnvCalling.PairedCnvCalling as CNVs {
                    input:
                        caseSampleName = samp.id,
                        caseBam = bamFiles[casePosition.position].file,
                        caseBamIndex = bamFiles[casePosition.position].index,
                        controlSampleName = sampleIds[controlPostition.position],
                        controlBam = bamFiles[controlPostition.position].file,
                        controlBamIndex = bamFiles[controlPostition.position].index,
                        PON = select_first([CnvPanelOfNormals, panelOfNormals.PON]),
                        preprocessedIntervals = select_first([preprocessedIntervals,
                            panelOfNormals.preprocessedIntervals]),
                        commonVariantSites = dbSNP.file,
                        commonVariantSitesIndex = dbSNP.index,
                        outputDir = outputDir + "/samples/" + samp.id + "/CNVcalling/",
                        referenceFasta = reference.fasta,
                        referenceFastaFai = reference.fai,
                        referenceFastaDict = reference.dict,
                        dockerImages = {"gatk": dockerImages["gatk-broad"]}  # These tasks will run into trouble with the biocontainers
                }
            }
        }
    }

    if (runMultiQC) {
        call multiqc.MultiQC as multiqcTask {
            input:
                # Multiqc will only run if these files are created.
                dependencies = select_all(somaticVariantcalling.somaticSeqSnvVcfIndex),
                outDir = outputDir + "/multiqc",
                analysisDirectory = outputDir,
                dockerImage = dockerImages["multiqc"]
        }
    }

    output {
        Array[IndexedBamFile] sampleBams = bamFiles
        Array[IndexedBamFile] markdupBams = sample.markdupBamFile
        Array[File] bamMetricsFiles = flatten(sample.metricsFiles)
        Array[File?] somaticSeqSnvVcf = somaticVariantcalling.somaticSeqSnvVcf
        Array[File?] somaticSeqSnvVcfIndex = somaticVariantcalling.somaticSeqSnvVcfIndex
        Array[File?] somaticSeqIndelVcf = somaticVariantcalling.somaticSeqIndelVcf
        Array[File?] somaticSeqIndelVcfIndex = somaticVariantcalling.somaticSeqIndelVcfIndex
        Array[File?] mutect2Vcf = somaticVariantcalling.mutect2Vcf
        Array[File?] mutect2VcfIndex = somaticVariantcalling.mutect2VcfIndex
        Array[File?] vardictVcf = somaticVariantcalling.vardictVcf
        Array[File?] vardictVcfIndex = somaticVariantcalling.vardictVcfIndex
        Array[File?] strelkaSnvsVcf = somaticVariantcalling.strelkaSnvsVcf
        Array[File?] strelkaSnvsVcfIndex = somaticVariantcalling.strelkaSnvsVcfIndex
        Array[File?] strelkaIndelsVcf = somaticVariantcalling.strelkaIndelsVcf
        Array[File?] strelkaIndelsVcfIndex = somaticVariantcalling.strelkaIndelsVcfIndex
        Array[File?] strelkaCombinedVcf = somaticVariantcalling.strelkaCombinedVcf
        Array[File?] strelkaCombinedVcfIndex = somaticVariantcalling.strelkaCombinedVcfIndex
        Array[File?] mantaVcf = somaticVariantcalling.mantaVcf
        Array[File?] mantaVcfIndex = somaticVariantcalling.mantaVcfIndex
        Array[File?] combinedVcf = somaticVariantcalling.combinedVcf
        Array[File?] combinedVcfIndex = somaticVariantcalling.combinedVcfIndex
        Array[File?] ensembleIndelsClassifier = somaticVariantcalling.ensembleIndelsClassifier
        Array[File?] ensembleSNVClassifier = somaticVariantcalling.ensembleSNVClassifier

        # CNV
        File? generatedpreProcessedIntervals = panelOfNormals.preprocessedIntervals
        File? generatedPON = panelOfNormals.PON

        Array[File?] caseAllelicCounts = CNVs.caseAllelicCounts
        Array[File?] caseReadCounts = CNVs.caseReadCounts
        Array[File?] caseStandardizedCopyRatios = CNVs.caseStandardizedCopyRatios
        Array[File?] caseDenoisedCopyRatios = CNVs.caseDenoisedCopyRatios
        Array[File?] caseHetrozygousAllelicCounts = CNVs.caseHetrozygousAllelicCounts
        Array[File?] caseNormalHetrozygousAllelicCounts = CNVs.caseNormalHetrozygousAllelicCounts
        Array[File?] caseCopyRatioSegments = CNVs.caseCopyRatioSegments
        Array[File?] caseCopyRatioCBS = CNVs.caseCopyRatioCBS
        Array[File?] caseAlleleFractionCBS = CNVs.caseAlleleFractionCBS
        Array[File?] caseCalledSegments = CNVs.caseCalledSegments
        Array[File?] caseCalledSegmentsIgv = CNVs.caseCalledSegmentsIgv
        Array[File?] caseDenoisedCopyRatiosPlot = CNVs.caseDenoisedCopyRatiosPlot
        Array[File?] caseDenoisedCopyRatiosLimitedPlot = CNVs.caseDenoisedCopyRatiosLimitedPlot
        Array[File?] caseModeledSegmentsPlot = CNVs.caseModeledSegmentsPlot

        Array[File?] controlAllelicCounts = CNVs.controlAllelicCounts
        Array[File?] controlReadCounts = CNVs.controlReadCounts
        Array[File?] controlStandardizedCopyRatios = CNVs.controlStandardizedCopyRatios
        Array[File?] controlDenoisedCopyRatios = CNVs.controlDenoisedCopyRatios
        Array[File?] controlHetrozygousAllelicCounts = CNVs.controlHetrozygousAllelicCounts
        Array[File?] controlCopyRatioSegments = CNVs.controlCopyRatioSegments
        Array[File?] controlCopyRatioCBS = CNVs.controlCopyRatioCBS
        Array[File?] controlAlleleFractionCBS = CNVs.controlAlleleFractionCBS
        Array[File?] controlCalledSegments = CNVs.controlCalledSegments
        Array[File?] controlCalledSegmentsIgv = CNVs.controlCalledSegmentsIgv
        Array[File?] controlDenoisedCopyRatiosPlot = CNVs.controlDenoisedCopyRatiosPlot
        Array[File?] controlDenoisedCopyRatiosLimitedPlot = CNVs.controlDenoisedCopyRatiosLimitedPlot
        Array[File?] controlModeledSegmentsPlot = CNVs.controlModeledSegmentsPlot
    }

    parameter_meta {
        sampleConfigFile: {description: "The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.",
                           category: "required"}
        outputDir: {description: "The directory the output should be written to.", category: "common"}
        reference: {description: "The reference files: a fasta, its index and the associated sequence dictionary.", category: "required"}
        bwaIndex: {description: "The BWA index files.", category: "required"}
        dbSNP: {description: "A dbSNP VCF file and its index.", category: "required"}
        regions: {description: "A bed file describing the regions to call variants for.", category: "common"}
        performCnvCalling: {description: "Whether or not CNV calling should be performed.", category: "common"}
        CnvPanelOfNormals: {description: "The panel of normals file to be used for CNV calling. If not provided (and performCnvCalling is set to true) then this will be generated on the fly using the samples lacking a control sample in the samplesheet.",
                            category: "common"}
        preprocessedIntervals: {description: "The preprocessed intervals to be used for CNV calling. If not provided (and performCnvCalling is set to true) then this will be generated on the fly.",
                            category: "common"}
        runMultiQC: {description: "Whether or not MultiQC should be run.", category: "advanced"}

        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.",
                           category: "advanced"}
    }
}

task GetSamplePositionInArray {
    input {
        Array[String] sampleIds
        String sample

        String dockerImage = "python:3.7-slim"
    }

    command <<<
        python <<CODE
        for i, sample in enumerate(['~{sep="','" sampleIds}']):
            if sample == '~{sample}':
                print(i)
                exit()
        CODE
    >>>

    output {
        Int position = read_int(stdout())
    }

    runtime {
        docker: dockerImage
        # 4 gigs of memory to be able to build the docker image in singularity
        memory: "4G"
    }

    parameter_meta {
        sampleIds: {description: "A list of sample ids.", category: "required"}
        sample: {description: "The sample for which the position is wanted.", category: "required"}
        dockerImage: {description: "The docker image used for this task. Changing this may result in errors which the developers may choose not to address.",
                      category: "advanced"}
    }
}
