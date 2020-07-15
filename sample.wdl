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

import "BamMetrics/bammetrics.wdl" as bammetrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "structs.wdl" as structs
import "tasks/bwa.wdl" as bwa
import "tasks/sambamba.wdl" as sambamba
import "QC/QC.wdl" as qc


workflow SampleWorkflow {
    input {
        Sample sample
        String sampleDir
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        BwaIndex bwaIndex
        File dbsnpVCF
        File dbsnpVCFIndex
        Map[String, String] dockerImages
        String platform = "illumina"
        Boolean useBwaKit = false
        Array[File] scatters
        Int bwaThreads = 4
        String? adapterForward
        String? adapterReverse
    }
    meta {allowNestedInputs: true}

    scatter (readgroup in sample.readgroups) {
        String readgroupDir = sampleDir + "/lib_" + readgroup.lib_id + "--rg_" + readgroup.id

        call qc.QC as QC {
            input:
                outputDir = readgroupDir,
                read1 = readgroup.R1,
                read2 = readgroup.R2,
                adapterForward = adapterForward,
                adapterReverse = adapterReverse,
                dockerImages = dockerImages
        }

        if (! useBwaKit) {
            call bwa.Mem as bwaMem {
                input:
                    read1 = QC.qcRead1,
                    read2 = QC.qcRead2,
                    outputPath = readgroupDir + "/" + sample.id + "-" + readgroup.lib_id + "-" + readgroup.id + ".bam",
                    readgroup = "@RG\\tID:~{sample.id}-~{readgroup.lib_id}-~{readgroup.id}\\tLB:~{readgroup.lib_id}\\tSM:~{sample.id}\\tPL:~{platform}",
                    bwaIndex = bwaIndex,
                    threads = bwaThreads,
                    dockerImage = dockerImages["bwa+samtools"]
            }
        }

        if (useBwaKit) {
            call bwa.Kit as bwakit {
                input:
                    read1 = QC.qcRead1,
                    read2 = QC.qcRead2,
                    outputPrefix = readgroupDir + "/" + sample.id + "-" + readgroup.lib_id + "-" + readgroup.id,
                    readgroup = "@RG\\tID:~{sample.id}-~{readgroup.lib_id}-~{readgroup.id}\\tLB:~{readgroup.lib_id}\\tSM:~{sample.id}\\tPL:~{platform}",
                    bwaIndex = bwaIndex,
                    threads = bwaThreads,
                    dockerImage = dockerImages["bwakit+samtools"]
            }
        }
    }

    call sambamba.Markdup as markdup {
        input:
            inputBams = if useBwaKit
                then select_all(bwakit.outputBam)
                else select_all(bwaMem.outputBam),
            outputPath = sampleDir + "/" + sample.id + ".markdup.bam",
            dockerImage = dockerImages["sambamba"]
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bam = markdup.outputBam,
            bamIndex = markdup.outputBamIndex,
            outputDir = sampleDir,
            bamName =  sample.id + ".bqsr",
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            dbsnpVCF = dbsnpVCF,
            dbsnpVCFIndex = dbsnpVCFIndex,
            dockerImages = dockerImages,
            scatters = scatters
    }

    call bammetrics.BamMetrics as metrics {
        input:
            bam = markdup.outputBam,
            bamIndex = markdup.outputBamIndex,
            outputDir = sampleDir,
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            dockerImages = dockerImages
    }

    output {
        File markdupBam = markdup.outputBam
        File markdupBamIndex = markdup.outputBamIndex
        File recalibratedBam = bqsr.recalibratedBam
        File recalibratedBamIndex = bqsr.recalibratedBamIndex
        Array[File] reports = flatten([flatten(QC.reports), 
                                       metrics.reports,
                                       [bqsr.BQSRreport]
                                       ])
    }

    parameter_meta {
        sample: {description: "The sample information: sample id, readgroups, etc.", category: "required"}
        sampleDir: {description: "The directory the output should be written to.", category: "required"}
        bwaIndex: {description: "The BWA index files.", category: "required"}
        referenceFasta: { description: "The reference fasta file", category: "required" }
        referenceFastaFai: { description: "Fasta index (.fai) file of the reference", category: "required" }
        referenceFastaDict: { description: "Sequence dictionary (.dict) file of the reference", category: "required" }
        dbsnpVCF: { description: "dbsnp VCF file used for checking known sites", category: "required"}
        dbsnpVCFIndex: { description: "Index (.tbi) file for the dbsnp VCF", category: "required"}
        dockerImages: {description: "The docker images used.", category: "required"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        useBwaKit: {description: "Whether or not BWA kit should be used. If false BWA mem will be used.", category: "advanced"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        scatters: {description: "List of bed files to be used for scattering", category: "advanced"}
        bwaThreads: {description: "The amount of threads for the alignment process", category: "advanced"}
    }
}
