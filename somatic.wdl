version 1.0

# Copyright (c) 2018 Leiden University Medical Center
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        BwaIndex bwaIndex
        File dbsnpVCF
        File dbsnpVCFIndex
        File? regions
        Boolean performCnvCalling = false
        File? cnvPanelOfNormals
        File? preprocessedIntervals
        String platform = "illumina"
        String? adapterForward = "AGATCGGAAGAG"  # Illumina universal adapter
        String? adapterReverse = "AGATCGGAAGAG"  # Illumina universal adapter
        Boolean useBwaKit = false

        Boolean runStrelka = true
        Boolean runVardict = true
        Boolean runMutect2 = true
        Boolean runManta = true
        Boolean runCombineVariants = false
        Int? cnvMinimumContigLength
        Int scatterSizeMillions = 1000
        Int scatterSize = scatterSizeMillions * 1000000
        # Only run multiQC if the user specified an outputDir
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
    scatter (sample in sampleConfig.samples) {
        call sampleWorkflow.SampleWorkflow as sampleWorkflow {
            input:
                sampleDir = outputDir + "/samples/" + sample.id,
                sample = sample,
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                bwaIndex = bwaIndex,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFIndex = dbsnpVCFIndex,
                adapterForward = adapterForward,
                adapterReverse = adapterReverse,
                useBwaKit = useBwaKit,
                dockerImages = dockerImages,
                scatterSize = scatterSize,
                platform = platform
        }

        String sampleIds = sample.id
        if (!defined(sample.control)) {
            File controlBams = sampleWorkflow.recalibratedBam
            File controlBamIndexes = sampleWorkflow.recalibratedBamIndex
        }
    }

    if (performCnvCalling && (! defined(cnvPanelOfNormals) || ! defined(preprocessedIntervals))) {
        call cnvPon.PanelOfNormals as generateCnvPanelOfNormals {
            input:
                inputBams = select_all(controlBams),
                inputBamIndexes = select_all(controlBamIndexes),
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                regions = regions,
                outputDir = outputDir + "/PON/",
                dockerImages = {"gatk": dockerImages["gatk-broad"]}  # These tasks will run into trouble with the biocontainers
        }
    }

    scatter (sample in sampleConfig.samples) {
        if (defined(sample.control)) {
            call GetSamplePositionInArray as controlPostition  {
                input:
                    sampleIds = sampleIds,
                    sample = select_first([sample.control])
            }

            call GetSamplePositionInArray as casePosition  {
                input:
                    sampleIds = sampleIds,
                    sample = sample.id,
                    dockerImage = dockerImages["python"]
            }

            call somaticVariantcallingWorkflow.SomaticVariantcalling as somaticVariantcalling {
                input:
                    outputDir = outputDir + "/samples/" + sample.id + "/somatic-variantcalling/",
                    referenceFasta = referenceFasta,
                    referenceFastaFai = referenceFastaFai,
                    referenceFastaDict = referenceFastaDict,
                    tumorSample = sample.id,
                    tumorBam = sampleWorkflow.recalibratedBam[casePosition.position],
                    tumorBamIndex = sampleWorkflow.recalibratedBamIndex[casePosition.position],
                    controlSample = sampleIds[controlPostition.position],
                    controlBam = sampleWorkflow.recalibratedBam[controlPostition.position],
                    controlBamIndex = sampleWorkflow.recalibratedBamIndex[controlPostition.position],
                    regions = regions,
                    dockerImages = dockerImages,
                    runStrelka = runStrelka,
                    runVardict = runVardict,
                    runMutect2 = runMutect2,
                    runManta = runManta,
                    runCombineVariants = runCombineVariants
            }

            if (performCnvCalling) {
                call pairedCnvCalling.PairedCnvCalling as CNVs {
                    input:
                        caseSampleName = sample.id,
                        caseBam = sampleWorkflow.recalibratedBam[casePosition.position],
                        caseBamIndex = sampleWorkflow.recalibratedBamIndex[casePosition.position],
                        controlSampleName = sampleIds[controlPostition.position],
                        controlBam = sampleWorkflow.recalibratedBam[controlPostition.position],
                        controlBamIndex = sampleWorkflow.recalibratedBamIndex[controlPostition.position],
                        PON = select_first([cnvPanelOfNormals, generateCnvPanelOfNormals.PON]),
                        preprocessedIntervals = select_first([preprocessedIntervals,
                        generateCnvPanelOfNormals.preprocessedIntervals]),
                        commonVariantSites = dbsnpVCF,
                        commonVariantSitesIndex = dbsnpVCFIndex,
                        outputDir = outputDir + "/samples/" + sample.id + "/CNVcalling/",
                        referenceFasta = referenceFasta,
                        referenceFastaFai = referenceFastaFai,
                        referenceFastaDict = referenceFastaDict,
                        minimumContigLength = cnvMinimumContigLength,
                        dockerImages = {"gatk": dockerImages["gatk-broad"]}  # These tasks will run into trouble with the biocontainers
                }
            }
        }
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            reports = flatten(sampleWorkflow.reports),
            outDir = outputDir + "/multiqc",
            dockerImage = dockerImages["multiqc"]
    }

    output {
        File multiqcReport = multiqcTask.multiqcReport
        Array[File] recalibratedBams = sampleWorkflow.recalibratedBam
        Array[File] reports = flatten(sampleWorkflow.reports)
        Array[File] recalibratedBamIndexes = sampleWorkflow.recalibratedBamIndex
        Array[File] markdupBams = sampleWorkflow.markdupBam
        Array[File] markdupBamIndex = sampleWorkflow.markdupBamIndex
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
        File? generatedpreProcessedIntervals = generateCnvPanelOfNormals.preprocessedIntervals
        File? generatedPON = generateCnvPanelOfNormals.PON

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
        referenceFasta: { description: "The reference fasta file", category: "required" }
        referenceFastaFai: { description: "Fasta index (.fai) file of the reference", category: "required" }
        referenceFastaDict: { description: "Sequence dictionary (.dict) file of the reference", category: "required" }
        dbsnpVCF: { description: "dbsnp VCF file used for checking known sites", category: "required"}
        dbsnpVCFIndex: { description: "Index (.tbi) file for the dbsnp VCF", category: "required"}
        useBwaKit: {description: "Whether or not BWA kit should be used. If false BWA mem will be used.", category: "advanced"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        bwaIndex: {description: "The BWA index files.", category: "required"}
        regions: {description: "A bed file describing the regions to call variants for.", category: "common"}
        performCnvCalling: {description: "Whether or not CNV calling should be performed.", category: "common"}
        cnvPanelOfNormals: {description: "The panel of normals file to be used for CNV calling. If not provided (and performCnvCalling is set to true) then this will be generated on the fly using the samples lacking a control sample in the samplesheet.",
                            category: "common"}
        preprocessedIntervals: {description: "The preprocessed intervals to be used for CNV calling. If not provided (and performCnvCalling is set to true) then this will be generated on the fly.",
                            category: "common"}
        runMultiQC: {description: "Whether or not MultiQC should be run.", category: "advanced"}

        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.",
                           category: "advanced"}
        cnvMinimumContigLength: {description: "The minimum length for a contig to be included in the CNV plots.", category: "advanced"}
        scatterSize: {description: "The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.",
              category: "advanced"}
        scatterSizeMillions:{ description: "Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.",
                              category: "advanced"}
        runStrelka: {description: "Whether or not to run Strelka.", category: "common"}
        runManta: {description: "Whether or not manta should be run as part of the Strelka pipeline.", category: "common"}
        runVardict: {description: "Whether or not to run VarDict.", category: "common"}
        runMutect2: {description: "Whether or not to run Mutect2.", category: "common"}
        runCombineVariants: {description: "Whether or not to combine the variant calling results into one VCF file.", category: "advanced"}
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
