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
import "tasks/bwa-mem2.wdl" as bwamem2
import "tasks/sambamba.wdl" as sambamba
import "tasks/picard.wdl" as picard
import "QC/QC.wdl" as qc
import "tasks/umi-tools.wdl" as umiTools

workflow SampleWorkflow {
    input {
        Sample sample
        String sampleDir
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        File dbsnpVCF
        File dbsnpVCFIndex
        Boolean umiDeduplication
        Boolean collectUmiStats
        String platform = "illumina"
        Boolean useBwaKit = false
        Array[File] scatters

        BwaIndex? bwaIndex
        BwaIndex? bwaMem2Index
        String? adapterForward
        String? adapterReverse

        Int bwaThreads = 4
        Map[String, String] dockerImages
		
        String? DONOTDEFINE
    }

    meta {
        WDL_AID: {
            exclude: ["DONOTDEFINE"]
        }
        allowNestedInputs: true
    }

    scatter (readgroup in sample.readgroups) {
        String readgroupDir = sampleDir + "/lib_" + readgroup.lib_id + "--rg_" + readgroup.id
        call qc.QC as qualityControl {
            input:
                outputDir = readgroupDir,
                read1 = readgroup.R1,
                read2 = readgroup.R2,
                adapterForward = adapterForward,
                adapterReverse = adapterReverse,
                dockerImages = dockerImages
        }

        if (defined(bwaMem2Index)) {
            call bwamem2.Mem as bwamem2Mem {
                input:
                    read1 = qualityControl.qcRead1,
                    read2 = qualityControl.qcRead2,
                    outputPrefix = readgroupDir + "/" + sample.id + "-" + readgroup.lib_id + "-" + readgroup.id,
                    readgroup = "@RG\\tID:~{sample.id}-~{readgroup.lib_id}-~{readgroup.id}\\tLB:~{readgroup.lib_id}\\tSM:~{sample.id}\\tPL:~{platform}",
                    bwaIndex = select_first([bwaMem2Index]),
                    threads = bwaThreads,
                    usePostalt = useBwaKit,
                    dockerImage = dockerImages["bwamem2+kit+samtools"]
            }
        }

        # We assume bwaIndex present if bwamem2index is not present.
        # If not, we create a crash.
        if (!defined(bwaMem2Index)) {
            call bwa.Mem as bwaMem {
                input:
                    read1 = qualityControl.qcRead1,
                    read2 = qualityControl.qcRead2,
                    outputPrefix = readgroupDir + "/" + sample.id + "-" + readgroup.lib_id + "-" + readgroup.id,
                    readgroup = "@RG\\tID:~{sample.id}-~{readgroup.lib_id}-~{readgroup.id}\\tLB:~{readgroup.lib_id}\\tSM:~{sample.id}\\tPL:~{platform}",
                    bwaIndex = select_first([bwaIndex]),
                    threads = bwaThreads,
                    usePostalt = useBwaKit,
                    dockerImage = dockerImages["bwakit+samtools"]
            }
        }
        Boolean paired = defined(readgroup.R2)
    }

    call sambamba.Markdup as markdup {
        input:
            inputBams = if defined(bwaMem2Index) 
                        then select_all(bwamem2Mem.outputBam)
                        else select_all(bwaMem.outputBam),
            outputPath = sampleDir + "/" + sample.id + ".markdup.bam",
            dockerImage = dockerImages["sambamba"]
    }
	
    if (umiDeduplication) {
        call umiTools.Dedup as umiDedup {
            input:
                inputBam = markdup.outputBam,
                inputBamIndex = markdup.outputBamIndex,
                outputBamPath = sampleDir + "/" + sample.id + ".dedup.bam",
                tmpDir = sampleDir + "/" + sample.id + "_tmp",
                statsPrefix = if collectUmiStats
                              then sampleDir + "/" + sample.id
                              else DONOTDEFINE,
                # Assumes that if one readgroup is paired, all are.
                paired = paired[0],
                dockerImage = dockerImages["umi-tools"]
        }
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bam = select_first([umiDedup.deduppedBam, markdup.outputBam]),
            bamIndex = select_first([umiDedup.deduppedBamIndex, markdup.outputBamIndex]),
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
            bam = select_first([umiDedup.deduppedBam, markdup.outputBam]),
            bamIndex = select_first([umiDedup.deduppedBamIndex, markdup.outputBamIndex]),
            outputDir = sampleDir,
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            dockerImages = dockerImages
    }

    output {
        File markdupBam = select_first([umiDedup.deduppedBam, markdup.outputBam])
        File markdupBamIndex = select_first([umiDedup.deduppedBamIndex, markdup.outputBamIndex])
        File recalibratedBam = bqsr.recalibratedBam
        File recalibratedBamIndex = bqsr.recalibratedBamIndex
        File? umiEditDistance = umiDedup.editDistance
        File? umiStats = umiDedup.umiStats
        File? umiPositionStats = umiDedup.positionStats
        Array[File] umiReports = select_all([umiStats, umiPositionStats])
        Array[File] reports = flatten([flatten(qualityControl.reports),
                                       metrics.reports,
                                      umiReports,
                                       [bqsr.BQSRreport]
                                       ])
    }

    parameter_meta {
        # inputs
        sample: {description: "The sample information: sample id, readgroups, etc.", category: "required"}
        sampleDir: {description: "The directory the output should be written to.", category: "required"}
        referenceFasta: {description: "The reference fasta file.", category: "required"}
        referenceFastaFai: {description: "Fasta index (.fai) file of the reference.", category: "required"}
        referenceFastaDict: {description: "Sequence dictionary (.dict) file of the reference.", category: "required"}
        dbsnpVCF: {description: "dbsnp VCF file used for checking known sites.", category: "required"}
        dbsnpVCFIndex: {description: "Index (.tbi) file for the dbsnp VCF.", category: "required"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        useBwaKit: {description: "Whether or not BWA kit should be used. If false BWA mem will be used.", category: "advanced"}
        scatters: {description: "List of bed files to be used for scattering.", category: "advanced"}
        bwaIndex: {description: "The BWA index files. These or the bwaMem2Index should be provided.", category: "common"}
        bwaMem2Index: {description: "The bwa-mem2 index files. These or the bwaIndex should be provided.", category: "common"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        bwaThreads: {description: "The amount of threads for the alignment process.", category: "advanced"}
        dockerImages: {description: "The docker images used.", category: "required"}
        umiDeduplication: {description: "Whether or not UMI based deduplication should be performed.", category: "common"}
        collectUmiStats: {description: "Whether or not UMI stats collection should be performed.", category: "common"}

        # outputs
        markdupBam: {description: ""}
        markdupBamIndex: {description: ""}
        recalibratedBam: {description: ""}
        recalibratedBamIndex: {description: ""}
        reports: {description: ""}
        umiEditDistance: {description: ""}
        umiStats: {description: ""}
        umiPositionStats: {description: ""}
        umiReports: {description: ""}
    }
}
