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

import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/samtools.wdl" as samtools
import "BamMetrics/bammetrics.wdl" as bammetrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "structs.wdl" as structs
import "structural-variantcalling/structural-variantcalling.wdl" as structuralVariantCalling
import "tasks/picard.wdl" as picard
import "tasks/bwa.wdl" as bwa
import "QC/QC.wdl" as qc


workflow Sample {
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
    }

    scatter (readgroup in sample.readgroups) {
        String libraryDir = sampleDir + "/lib_" + readgroup.lib_id
        String readgroupDir = libraryDir + "/rg_" + readgroup.id

        call qc.QC as qc {
            input:
                outputDir = readgroupDir,
                read1 = readgroup.R1,
                read2 = readgroup.R2,
                dockerImages = dockerImages
        }

        if (! useBwaKit) {
            call bwa.Mem as bwaMem {
                input:
                    read1 = qc.qcRead1,
                    read2 = qc.qcRead2,
                    outputPath = readgroupDir + "/" + basename(readgroup.R1) + ".bam",
                    readgroup = "@RG\\tID:~{sample.id}-~{readgroup.lib_id}-~{readgroup.id}\\tLB:~{readgroup.lib_id}\\tSM:~{sample.id}\\tPL:~{platform}",
                    bwaIndex = bwaIndex,
                    dockerImage = dockerImages["bwa+picard"]
            }
        }

        if (useBwaKit) {
            call bwa.Kit as bwakit {
                input:
                    read1 = qc.qcRead1,
                    read2 = qc.qcRead2,
                    outputPrefix = readgroupDir + "/" + basename(readgroup.R1),
                    readgroup = "@RG\\tID:~{sample.id}-~{readgroup.lib_id}-~{readgroup.id}\\tLB:~{readgroup.lib_id}\\tSM:~{sample.id}\\tPL:~{platform}",
                    bwaIndex = bwaIndex,
                    dockerImage = dockerImages["bwakit"]
            }
        }
    }

    call picard.MarkDuplicates as markdup {
        input:
            inputBams = if useBwaKit
                then select_all(bwakit.outputBam)
                else select_all(bwaMem.outputBam),
            inputBamIndexes = if useBwaKit
                then select_all(bwakit.outputBamIndex)
                else select_all(bwaMem.outputBamIndex),
            outputBamPath = sampleDir + "/" + sample.id + ".markdup.bam",
            metricsPath = sampleDir + "/" + sample.id + ".markdup.metrics",
            dockerImage = dockerImages["picard"]
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
            dockerImages = dockerImages
    }

    call bammetrics.BamMetrics as metrics {
        input:
            bam = markdup.outputBam,
            bamIndex = markdup.outputBamIndex,
            outputDir = sampleDir + "/metrics",
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            dockerImages = dockerImages
    }

    Array[Array[File]] allMetrics = [[metrics.flagstats],
        metrics.picardMetricsFiles, metrics.rnaMetrics,
        metrics.targetedPcrMetrics, [markdup.metricsFile], flatten(qc.reports)]

    call structuralVariantCalling.SVcalling as svCalling {
        input:
            bamFile = bqsr.recalibratedBam,
            bamIndex = bqsr.recalibratedBamIndex,
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            bwaIndex = bwaIndex,
            sample = sample.id,
            outputDir = sampleDir,
            dockerImages = dockerImages
    }

    output {
        File markdupBam = markdup.outputBam
        File markdupBamIndex = markdup.outputBamIndex
        File recalibratedBam = bqsr.recalibratedBam
        File recalibratedBamIndex = bqsr.recalibratedBamIndex
        Array[File] metricsFiles = flatten(allMetrics)
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
    }
}
