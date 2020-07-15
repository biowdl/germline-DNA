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

import "sample.wdl" as sampleWf
import "structural-variantcalling/structural-variantcalling.wdl" as structuralVariantCalling
import "gatk-variantcalling/single-sample-variantcalling.wdl" as variantCallingWorkflow
import "gatk-variantcalling/jointgenotyping.wdl" as jgwf
import "gatk-variantcalling/calculate-regions.wdl" as calcRegions
import "structs.wdl" as structs
import "tasks/biowdl.wdl" as biowdl
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc
import "tasks/chunked-scatter.wdl" as chunkedScatter

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
        Boolean jointgenotyping = true
        Boolean singleSampleGvcf = false
        String? adapterForward = "AGATCGGAAGAG"  # Illumina universal adapter
        String? adapterReverse = "AGATCGGAAGAG"  # Illumina universal adapter
        String platform = "illumina"
        Boolean useBwaKit = false
        Int scatterSizeMillions = 1000
        Int? scatterSize
        Int bwaThreads = 4
        # Only run multiQC if the user specified an outputDir
        Boolean runSVcalling = false
    }
    meta {allowNestedInputs: true}

    Boolean mergeVcfs = !jointgenotyping || singleSampleGvcf

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

    call calcRegions.CalculateRegions as calculateRegions {
        input:
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            XNonParRegions = XNonParRegions,
            YNonParRegions = YNonParRegions,
            regions = regions,
            scatterSize = scatterSize,
            scatterSizeMillions = scatterSizeMillions,
            dockerImages = dockerImages
    }

    call chunkedScatter.ScatterRegions as scatterList {
        input:
            inputFile = select_first([regions, referenceFastaFai]),
            scatterSize = scatterSize,
            scatterSizeMillions = scatterSizeMillions,
            dockerImage = dockerImages["chunked-scatter"]
    }

    # Running sample subworkflow
    scatter (sample in sampleConfig.samples) {
        String sampleIds = sample.id
        String sampleDir = outputDir + "/samples/" + sample.id + "/"
        call sampleWf.SampleWorkflow as sampleWorkflow {
            input:
                sampleDir = sampleDir,
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
                platform = platform
        }
        
        call variantCallingWorkflow.SingleSampleCalling as SingleSampleCalling {
            input:
                bam = sampleWorkflow.recalibratedBam,
                bamIndex = sampleWorkflow.recalibratedBamIndex,
                gender = select_first([sample.gender, "unknown"]),
                sampleName = sample.id,
                outputDir = sampleDir,
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFIndex = dbsnpVCFIndex,
                XNonParRegions = calculateRegions.Xregions,
                YNonParRegions = calculateRegions.Yregions,
                statsRegions = regions,
                autosomalRegionScatters = calculateRegions.autosomalRegionScatters,
                gvcf = jointgenotyping,
                mergeVcf = mergeVcfs,
                dockerImages = dockerImages                    
        }


        if (runSVcalling) {
            call structuralVariantCalling.SVcalling as svCalling {
                input:
                    bamFile = sampleWorkflow.markdupBam,
                    bamIndex = sampleWorkflow.markdupBamIndex,
                    referenceFasta = referenceFasta,
                    referenceFastaFai = referenceFastaFai,
                    referenceFastaDict = referenceFastaDict,
                    bwaIndex = bwaIndex,
                    sample = sample.id,
                    outputDir = sampleDir,
                    dockerImages = dockerImages
            }
        }
    }

    if (jointgenotyping) {
        call jgwf.JointGenotyping as JointGenotyping {
            input:
                gvcfFiles = flatten(SingleSampleCalling.vcfScatters),
                gvcfFilesIndex = flatten(SingleSampleCalling.vcfIndexScatters),
                outputDir = outputDir,
                vcfBasename = "multisample",
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                sampleIds = sampleIds,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFIndex = dbsnpVCFIndex,
                regions = regions,
                scatterSize = scatterSize,
                dockerImages = dockerImages
        }
    }

    Array[File] allReports = flatten([
        flatten(sampleWorkflow.reports), flatten(SingleSampleCalling.reports), select_first([JointGenotyping.reports, []])
        ])

    call multiqc.MultiQC as multiqcTask {
        input:
            reports = allReports,
            outDir = outputDir,
            dockerImage = dockerImages["multiqc"]
    }

    output {
        File multiqcReport = multiqcTask.multiqcReport
        Array[File] reports = allReports
        File? multiSampleVcf = JointGenotyping.multisampleVcf
        File? multisampleVcfIndex = JointGenotyping.multisampleVcfIndex
        File? multisampleGVcf = JointGenotyping.multisampleGVcf
        File? multisampleGVcfIndex = JointGenotyping.multisampleGVcfIndex
        Array[File] singleSampleVcfs = if jointgenotyping then [] else select_all(SingleSampleCalling.outputVcf)
        Array[File] singleSampleVcfsIndex = if jointgenotyping then [] else select_all(SingleSampleCalling.outputVcfIndex)
        Array[File] singleSampleGvcfs = if jointgenotyping then select_all(SingleSampleCalling.outputVcf) else []
        Array[File] singleSampleGvcfsIndex = if jointgenotyping then select_all(SingleSampleCalling.outputVcfIndex) else []
        Array[File] recalibratedBams = sampleWorkflow.recalibratedBam
        Array[File] recalibratedBamIndexes = sampleWorkflow.recalibratedBamIndex
        Array[File] markdupBams = sampleWorkflow.markdupBam
        Array[File] markdupBamIndexes = sampleWorkflow.markdupBamIndex
        Array[File?] cleverVCFs = svCalling.cleverVcf
        Array[File?] matecleverVCFs = svCalling.cleverVcf
        Array[File?] mantaVCFs = svCalling.mantaVcf
        Array[File?] dellyVCFs = svCalling.dellyVcf
        Array[File?] survivorVCFs = svCalling.survivorVcf
        Array[Array[File]?] renamedVCFs = svCalling.renamedVcfs
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
        bwaIndex: {description: "The BWA index files.", category: "required"}
        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.",
                           category: "advanced"}
        regions: {description: "A bed file describing the regions to call variants for.", category: "common"}
        runSVcalling: {description: "Whether or not Structural-variantcalling should be run.", category: "advanced"}
        runMultiQC: {description: "Whether or not MultiQC should be run.", category: "advanced"}
        XNonParRegions: {description: "Bed file with the non-PAR regions of X.", category: "common"}
        YNonParRegions: {description: "Bed file with the non-PAR regions of Y.", category: "common"}
        useBwaKit: {description: "Whether or not BWA kit should be used. If false BWA mem will be used.", category: "advanced"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        scatterSize: {description: "The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.",
              category: "advanced"}
        scatterSizeMillions:{ description: "Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.",
                              category: "advanced"}
        jointgenotyping: {description: "Whether to perform jointgenotyping (using HaplotypeCaller to call GVCFs and merge them with GenotypeGVCFs) or not",
                  category: "common"}
        singleSampleGvcf: {description: "Whether to output single-sample gvcfs", category: "common"}
        bwaThreads: {description: "The amount of threads for the alignment process", category: "advanced"}
    }
}
