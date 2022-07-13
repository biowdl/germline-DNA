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
import "tasks/biowdl.wdl" as biowdl
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc
import "tasks/chunked-scatter.wdl" as chunkedScatter

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
        Boolean umiDeduplication = false
        Boolean collectUmiStats = false
        Boolean performCnvCalling = false
        String platform = "illumina"
        Boolean useBwaKit = false
        Boolean runStrelka = true
        Boolean runVardict = true
        Boolean runMutect2 = true
        Boolean runManta = true
        Boolean runCombineVariants = false
        Int scatterSizeMillions = 1000

        File? regions
        File? cnvPanelOfNormals
        File? preprocessedIntervals
        String? adapterForward = "AGATCGGAAGAG"  # Illumina universal adapter.
        String? adapterReverse = "AGATCGGAAGAG"  # Illumina universal adapter.
        Int? cnvMinimumContigLength
        Int? scatterSize
        File? commonVariantSites
        File? commonVariantSitesIndex

        Int bwaThreads = 4
        File dockerImagesFile

        File? DONOTDEFINETHISFILE
        String? DONOTDEFINETHISSTRING
    }

    meta {allowNestedInputs: true}

    # Parse docker Tags configuration and sample sheet.
    call common.YamlToJson as convertDockerImagesFile {
        input:
            yaml = dockerImagesFile,
            outputJson = "dockerImages.json"
    }

    Map[String, String] dockerImages = read_json(convertDockerImagesFile.json)

    call biowdl.InputConverter as convertSampleConfig {
        input:
            samplesheet = sampleConfigFile,
            dockerImage = dockerImages["biowdl-input-converter"]
    }

    SampleConfig sampleConfig = read_json(convertSampleConfig.json)

    call chunkedScatter.ScatterRegions as scatterList {
        input:
            inputFile = select_first([regions, referenceFastaFai]),
            scatterSize = scatterSize,
            scatterSizeMillions = scatterSizeMillions,
            dockerImage = dockerImages["chunked-scatter"]
    }

    # Running sample subworkflow.
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
                scatters = scatterList.scatters,
                bwaThreads = bwaThreads,
                platform = platform,
                umiDeduplication = umiDeduplication,
                collectUmiStats = collectUmiStats
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
                dockerImages = {"gatk": dockerImages["gatk-broad"]}  # These tasks will run into trouble with the biocontainers.
        }
    }

    scatter (sample in sampleConfig.samples) {
        call GetSamplePositionInArray as casePosition  {
            input:
                sampleIds = sampleIds,
                sample = sample.id,
        }

        File tumorBam = sampleWorkflow.recalibratedBam[casePosition.position]
        File tumorBamIndex = sampleWorkflow.recalibratedBamIndex[casePosition.position]
        

        if (defined(sample.control)) {
            call GetSamplePositionInArray as controlPostition  {
                input:
                    sampleIds = sampleIds,
                    sample = select_first([sample.control])
            }

        }
        Int controlPos = select_first([controlPostition.position, 0])
        String? controlSample = if (defined(sample.control)) then sampleIds[controlPos] else DONOTDEFINETHISSTRING
        File? controlBam = if (defined(sample.control)) then sampleWorkflow.recalibratedBam[controlPos] else DONOTDEFINETHISFILE
        File? controlBamIndex = if (defined(sample.control)) then sampleWorkflow.recalibratedBamIndex[controlPos] else DONOTDEFINETHISFILE
        
        call somaticVariantcallingWorkflow.SomaticVariantcalling as somaticVariantcalling {
            input:
                outputDir = outputDir + "/samples/" + sample.id + "/somatic-variantcalling/",
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                tumorSample = sample.id,
                tumorBam = tumorBam,
                tumorBamIndex = tumorBamIndex,
                controlSample = controlSample,
                controlBam = controlBam,
                controlBamIndex =controlBamIndex,
                regions = regions,
                dockerImages = dockerImages,
                runStrelka = runStrelka,
                runVardict = runVardict,
                runMutect2 = runMutect2,
                runManta = runManta,
                runCombineVariants = runCombineVariants
        }

        if (performCnvCalling && defined(sample.control)) {
            call pairedCnvCalling.PairedCnvCalling as CNVs {
                input:
                    caseSampleName = sample.id,
                    caseBam = tumorBam,
                    caseBamIndex = tumorBamIndex,
                    controlSampleName = select_first([controlSample]),
                    controlBam = select_first([controlBam]),
                    controlBamIndex = select_first([controlBamIndex]),
                    PON = select_first([cnvPanelOfNormals, generateCnvPanelOfNormals.PON]),
                    preprocessedIntervals = select_first([preprocessedIntervals,
                    generateCnvPanelOfNormals.preprocessedIntervals]),
                    commonVariantSites = select_first([commonVariantSites, dbsnpVCF]),
                    commonVariantSitesIndex = select_first([commonVariantSitesIndex, dbsnpVCFIndex]),
                    outputDir = outputDir + "/samples/" + sample.id + "/CNVcalling/",
                    referenceFasta = referenceFasta,
                    referenceFastaFai = referenceFastaFai,
                    referenceFastaDict = referenceFastaDict,
                    minimumContigLength = cnvMinimumContigLength,
                    dockerImages = {"gatk": dockerImages["gatk-broad"]}  # These tasks will run into trouble with the biocontainers
            }
        }
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            reports = flatten(sampleWorkflow.reports),
            outDir = outputDir,
            dockerImage = dockerImages["multiqc"]
    }

    output {
        File dockerImagesList = convertDockerImagesFile.json
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
        # inputs
        sampleConfigFile: {description: "The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.", category: "required"}
        outputDir: {description: "The directory the output should be written to.", category: "common"}
        referenceFasta: {description: "The reference fasta file.", category: "required"}
        referenceFastaFai: {description: "Fasta index (.fai) file of the reference.", category: "required"}
        referenceFastaDict: {description: "Sequence dictionary (.dict) file of the reference.", category: "required"}
        bwaIndex: {description: "The BWA index files.", category: "required"}
        dbsnpVCF: {description: "dbsnp VCF file used for checking known sites.", category: "required"}
        dbsnpVCFIndex: {description: "Index (.tbi) file for the dbsnp VCF.", category: "required"}
        performCnvCalling: {description: "Whether or not CNV calling should be performed.", category: "common"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        useBwaKit: {description: "Whether or not BWA kit should be used. If false BWA mem will be used.", category: "advanced"}
        runStrelka: {description: "Whether or not to run Strelka.", category: "common"}
        runVardict: {description: "Whether or not to run VarDict.", category: "common"}
        runMutect2: {description: "Whether or not to run Mutect2.", category: "common"}
        runManta: {description: "Whether or not manta should be run as part of the Strelka pipeline.", category: "common"}
        runCombineVariants: {description: "Whether or not to combine the variant calling results into one VCF file.", category: "advanced"}
        scatterSizeMillions:{description: "Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.", category: "advanced"}
        regions: {description: "A bed file describing the regions to call variants for.", category: "common"}
        cnvPanelOfNormals: {description: "The panel of normals file to be used for CNV calling. If not provided (and performCnvCalling is set to true) then this will be generated on the fly using the samples lacking a control sample in the samplesheet.", category: "common"}
        preprocessedIntervals: {description: "The preprocessed intervals to be used for CNV calling. If not provided (and performCnvCalling is set to true) then this will be generated on the fly.", category: "common"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        cnvMinimumContigLength: {description: "The minimum length for a contig to be included in the CNV plots.", category: "advanced"}
        scatterSize: {description: "The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.", category: "advanced"}
        bwaThreads: {description: "The amount of threads for the alignment process", category: "advanced"}
        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.", category: "advanced"}
        umiDeduplication: {description: "Whether or not UMI based deduplication should be performed.", category: "common"}
        collectUmiStats: {description: "Whether or not UMI deduplication stats should be collected. This will potentially cause a massive increase in memory usage of the deduplication step.", category: "advanced"}
        commonVariantSites: {description: "Alternative to dnSNP for specifying common variant sites used for allelic counts collection in CNV detection. Can be a picard-style interval list or a VCf.", category: "advanced"}
        commonVariantSitesIndex: {description: "The index for the commonVariantSitesIndex VCF.", category: "advanced"}
        
        # outputs
        dockerImagesList: {description: "Json file describing the docker images used by the pipeline."}
        multiqcReport: {description: ""}
        recalibratedBams: {description: ""}
        reports: {description: ""}
        recalibratedBamIndexes: {description: ""}
        markdupBams: {description: ""}
        markdupBamIndex: {description: ""}
        somaticSeqSnvVcf: {description: ""}
        somaticSeqSnvVcfIndex: {description: ""}
        somaticSeqIndelVcf: {description: ""}
        somaticSeqIndelVcfIndex: {description: ""}
        mutect2Vcf: {description: ""}
        mutect2VcfIndex: {description: ""}
        vardictVcf: {description: ""}
        vardictVcfIndex: {description: ""}
        strelkaSnvsVcf: {description: ""}
        strelkaSnvsVcfIndex: {description: ""}
        strelkaIndelsVcf: {description: ""}
        strelkaIndelsVcfIndex: {description: ""}
        strelkaCombinedVcf: {description: ""}
        strelkaCombinedVcfIndex: {description: ""}
        mantaVcf: {description: ""}
        mantaVcfIndex: {description: ""}
        combinedVcf: {description: ""}
        combinedVcfIndex: {description: ""}
        ensembleIndelsClassifier: {description: ""}
        ensembleSNVClassifier: {description: ""}
        generatedpreProcessedIntervals: {description: ""}
        generatedPON: {description: ""}
        caseAllelicCounts: {description: ""}
        caseReadCounts: {description: ""}
        caseStandardizedCopyRatios: {description: ""}
        caseDenoisedCopyRatios: {description: ""}
        caseHetrozygousAllelicCounts: {description: ""}
        caseNormalHetrozygousAllelicCounts: {description: ""}
        caseCopyRatioSegments: {description: ""}
        caseCopyRatioCBS: {description: ""}
        caseAlleleFractionCBS: {description: ""}
        caseCalledSegments: {description: ""}
        caseCalledSegmentsIgv: {description: ""}
        caseDenoisedCopyRatiosPlot: {description: ""}
        caseDenoisedCopyRatiosLimitedPlot: {description: ""}
        caseModeledSegmentsPlot: {description: ""}
        controlAllelicCounts: {description: ""}
        controlReadCounts: {description: ""}
        controlStandardizedCopyRatios: {description: ""}
        controlDenoisedCopyRatios: {description: ""}
        controlHetrozygousAllelicCounts: {description: ""}
        controlCopyRatioSegments: {description: ""}
        controlCopyRatioCBS: {description: ""}
        controlAlleleFractionCBS: {description: ""}
        controlCalledSegments: {description: ""}
        controlCalledSegmentsIgv: {description: ""}
        controlDenoisedCopyRatiosPlot: {description: ""}
        controlDenoisedCopyRatiosLimitedPlot: {description: ""}
        controlModeledSegmentsPlot: {description: ""}
    }
}

task GetSamplePositionInArray {
    input {
        Array[String] sampleIds
        String sample

        # python:3.7-slim's sha256 digest. This image is based on debian buster.
        String dockerImage = "python@sha256:e0f6a4df17d5707637fa3557ab266f44dddc46ebfc82b0f1dbe725103961da4e"
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
        # 4 gigs of memory to be able to build the docker image in singularity.
        memory: "4G"
        docker: dockerImage
    }

    parameter_meta {
        # inputs
        sampleIds: {description: "A list of sample ids.", category: "required"}
        sample: {description: "The sample for which the position is wanted.", category: "required"}
        dockerImage: {description: "The docker image used for this task. Changing this may result in errors which the developers may choose not to address.", category: "advanced"}

        # outputs
        position: {description: ""}
    }
}
