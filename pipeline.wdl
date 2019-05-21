version 1.0

import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "somatic-variantcalling/somatic-variantcalling.wdl" as somaticVariantcallingWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc


workflow pipeline {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
        String outputDir
        Reference reference
        BwaIndex bwaIndex
        File dockerTagsFile
        IndexedVcfFile dbSNP
        File? regions
    }

    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerTagsFile {
        input:
            yaml = dockerTagsFile
    }
    Map[String, String] dockerTags = read_json(ConvertDockerTagsFile.json)

    call common.YamlToJson as ConvertSampleConfig {
        input:
            yaml = sampleConfigFile
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])


    #FIXME The following Copy calls are a workaround to ensure all data is on the same device.
    #      This is necssary to avoid cromwell from copying the data an excessive amount of times.
    #      Since containers are being used, soft-linking cannot be used for localization.
    #      Hard-links cannot be made between different devices/shares. Therefore, cromwell will
    #      resort to copying input files. It will do so seperatly for every call, which creates a
    #      huge amount of overhead in disk usage. By copying the data to (presumably) the same
    #      device as the cromwell-execution folder, hard-linking can be used instead.

    #Copy BWA index into ouput directory
    call common.Copy as copyBWAfasta {
        input:
            inputFile = bwaIndex.fastaFile,
            outputPath = outputDir + "/reference/bwa_index/" + basename(bwaIndex.fastaFile)
    }

    scatter (indexFile in bwaIndex.indexFiles) {
        call common.Copy as copyBWAindexFile {
            input:
                inputFile = indexFile,
                outputPath = outputDir + "/reference/bwa_index/" + basename(indexFile)
        }
    }

    BwaIndex effectiveBWAindex = object {
        fastaFile: copyBWAfasta.outputFile,
        indexFiles: copyBWAindexFile.outputFile
    }

    #Copy reference into output directory
    call common.Copy as copyFasta {
        input:
            inputFile = reference.fasta,
            outputPath = outputDir + "/reference/fasta/" + basename(reference.fasta)
    }

    call common.Copy as copyFai {
        input:
            inputFile = reference.fai,
            outputPath = outputDir + "/reference/fasta/" + basename(reference.fai)
    }

    call common.Copy as copyDict {
        input:
            inputFile = reference.dict,
            outputPath = outputDir + "/reference/fasta/" + basename(reference.dict)
    }

    Reference effectiveReference = object {
        fasta: copyFasta.outputFile,
        fai: copyFai.outputFile,
        dict: copyDict.outputFile
    }

    # Copy and validate dnsnp
    call common.Copy as copyDBsnp {
        input:
            inputFile = dbSNP.file,
            outputPath = outputDir + "/reference/dbsnp/" + basename(dbSNP.file)
    }

    call common.Copy as copyDBsnpIndex {
        input:
            inputFile = dbSNP.index,
            outputPath = outputDir + "/reference/dbsnp/" + basename(dbSNP.index)
    }

    IndexedVcfFile effectiveDBsnp = object {
        file: copyDBsnp.outputFile,
        index: copyDBsnpIndex.outputFile
    }

    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = effectiveDBsnp,
            reference = effectiveReference,
            dockerTag = dockerTags["biopet-validatevcf"]
    }

    # Running sample subworkflow
    scatter (sm in allSamples) {
        call sampleWorkflow.Sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm.id,
                sample = sm,
                reference = effectiveReference,
                bwaIndex = effectiveBWAindex,
                dbSNP = effectiveDBsnp,
                regions = regions,
                dockerTags = dockerTags
        }

        String sampleIds = sm.id
        IndexedBamFile bamFiles = sample.bam
    }

    scatter (sm in allSamples) {
        if (defined(sm.control)) {
            call GetSamplePositionInArray as contolPosition  {
                input:
                    sampleIds = sampleIds,
                    sample = select_first([sm.control])
            }

            call GetSamplePositionInArray as casePosition  {
                input:
                    sampleIds = sampleIds,
                    sample = sm.id
            }

            call somaticVariantcallingWorkflow.SomaticVariantcalling as somaticVariantcalling {
                input:
                    outputDir = outputDir + "/samples/" + sm.id + "/somatic-variantcalling/",
                    reference = effectiveReference,
                    tumorSample = sm.id,
                    tumorBam = bamFiles[casePosition.position],
                    controlSample = sampleIds[contolPosition.position],
                    controlBam = bamFiles[contolPosition.position],
                    regions = regions,
                    dockerTags = dockerTags
            }
        }
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = effectiveReference,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcf,
            vcfBasename = "multisample",
            dbsnpVCF = effectiveDBsnp,
            dockerTags = dockerTags,
            regions = regions
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcf = genotyping.vcfFile,
            reference = effectiveReference,
            outputDir = genotypingDir + "/stats",
            dockerTag = dockerTags["biopet-vcfstats"],
            intervals = regions
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            # Multiqc will only run if these files are created.
            dependencies = [genotyping.vcfFile.file],
            outDir = outputDir + "/multiqc",
            analysisDirectory = outputDir,
            dockerTag = dockerTags["multiqc"]
    }

    output {
    }
}

task GetSamplePositionInArray {
    input {
        Array[String] sampleIds
        String sample

        String dockerTag = "3.7-slim"
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
        docker: "python:" + dockerTag
        # 4 gigs of memory to be able to build the docker image in singularity
        memory: 4
    }
}