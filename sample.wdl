version 1.0


import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/samtools.wdl" as samtools
import "BamMetrics/bammetrics.wdl" as bammetrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "structs.wdl" as structs
import "tasks/picard.wdl" as picard
import "tasks/bwa.wdl" as bwa
import "QC/QC.wdl" as qc


workflow Sample {
    input {
        Sample sample
        String sampleDir
        Reference reference
        BwaIndex bwaIndex
        IndexedVcfFile dbSNP
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

    IndexedBamFile markdupBam = object {
            file: markdup.outputBam,
            index: markdup.outputBamIndex,
    }

    call preprocess.GatkPreprocess as bqsr {
        input:
            bamFile = markdupBam,
            outputDir = sampleDir,
            bamName =  sample.id + ".bqsr",
            outputRecalibratedBam = true,
            reference = reference,
            dbsnpVCF = dbSNP,
            dockerImages = dockerImages
    }

    call bammetrics.BamMetrics as metrics {
        input:
            bam = markdupBam ,
            outputDir = sampleDir + "/metrics",
            reference = reference,
            dockerImages = dockerImages
    }

    Array[Array[File]] allMetrics = [[metrics.flagstats],
        metrics.picardMetricsFiles, metrics.rnaMetrics,
        metrics.targetedPcrMetrics, [markdup.metricsFile], flatten(qc.reports)]

    output {
        IndexedBamFile markdupBamFile = markdupBam
        IndexedBamFile bqsrBamFile = select_first([bqsr.outputBamFile])
        Array[File] metricsFiles = flatten(allMetrics)
    }

    parameter_meta {
        sample: {description: "The sample information: sample id, readgroups, etc.", category: "required"}
        sampleDir: {description: "The directory the output should be written to.", category: "required"}
        reference: {description: "The reference files: a fasta, its index and the associated sequence dictionary.", category: "required"}
        bwaIndex: {description: "The BWA index files.", category: "required"}
        dbSNP: {description: "A dbSNP VCF file and its index.", category: "required"}
        dockerImages: {description: "The docker images used.", category: "required"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        useBwaKit: {description: "Whether or not BWA kit should be used. If false BWA mem will be used.", category: "advanced"}
    }
}
