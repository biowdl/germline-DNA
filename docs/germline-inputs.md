---
layout: default
title: "Inputs: Germline"
---

# Inputs for Germline

The following is an overview of all available inputs in
Germline.


## Required inputs
<dl>
<dt id="Germline.bwaIndex"><a href="#Germline.bwaIndex">Germline.bwaIndex</a></dt>
<dd>
    <i>struct(fastaFile : File, indexFiles : Array[File]) </i><br />
    The BWA index files.
</dd>
<dt id="Germline.dbsnpVCF"><a href="#Germline.dbsnpVCF">Germline.dbsnpVCF</a></dt>
<dd>
    <i>File </i><br />
    dbsnp VCF file used for checking known sites
</dd>
<dt id="Germline.dbsnpVCFIndex"><a href="#Germline.dbsnpVCFIndex">Germline.dbsnpVCFIndex</a></dt>
<dd>
    <i>File </i><br />
    Index (.tbi) file for the dbsnp VCF
</dd>
<dt id="Germline.dockerImagesFile"><a href="#Germline.dockerImagesFile">Germline.dockerImagesFile</a></dt>
<dd>
    <i>File </i><br />
    A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.
</dd>
<dt id="Germline.referenceFasta"><a href="#Germline.referenceFasta">Germline.referenceFasta</a></dt>
<dd>
    <i>File </i><br />
    The reference fasta file
</dd>
<dt id="Germline.referenceFastaDict"><a href="#Germline.referenceFastaDict">Germline.referenceFastaDict</a></dt>
<dd>
    <i>File </i><br />
    Sequence dictionary (.dict) file of the reference
</dd>
<dt id="Germline.referenceFastaFai"><a href="#Germline.referenceFastaFai">Germline.referenceFastaFai</a></dt>
<dd>
    <i>File </i><br />
    Fasta index (.fai) file of the reference
</dd>
<dt id="Germline.sampleConfigFile"><a href="#Germline.sampleConfigFile">Germline.sampleConfigFile</a></dt>
<dd>
    <i>File </i><br />
    The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.
</dd>
<dt id="Germline.svCalling.manta.cores"><a href="#Germline.svCalling.manta.cores">Germline.svCalling.manta.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The the number of cores required to run a program
</dd>
<dt id="Germline.svCalling.manta.memoryGb"><a href="#Germline.svCalling.manta.memoryGb">Germline.svCalling.manta.memoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The memory required to run the manta
</dd>
</dl>

## Other common inputs
<dl>
<dt id="Germline.adapterForward"><a href="#Germline.adapterForward">Germline.adapterForward</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads first or single end reads.
</dd>
<dt id="Germline.adapterReverse"><a href="#Germline.adapterReverse">Germline.adapterReverse</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads second end reads.
</dd>
<dt id="Germline.jointgenotyping"><a href="#Germline.jointgenotyping">Germline.jointgenotyping</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether to perform jointgenotyping (using HaplotypeCaller to call GVCFs and merge them with GenotypeGVCFs) or not
</dd>
<dt id="Germline.outputDir"><a href="#Germline.outputDir">Germline.outputDir</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"."</code><br />
    The directory the output should be written to.
</dd>
<dt id="Germline.regions"><a href="#Germline.regions">Germline.regions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to call variants for.
</dd>
<dt id="Germline.sample.bqsr.regions"><a href="#Germline.sample.bqsr.regions">Germline.sample.bqsr.regions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to operate on.
</dd>
<dt id="Germline.sample.bqsr.splitSplicedReads"><a href="#Germline.sample.bqsr.splitSplicedReads">Germline.sample.bqsr.splitSplicedReads</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not gatk's SplitNCgarReads should be run to split spliced reads. This should be enabled for RNAseq samples.
</dd>
<dt id="Germline.sample.bwakit.sixtyFour"><a href="#Germline.sample.bwakit.sixtyFour">Germline.sample.bwakit.sixtyFour</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the index uses the '.64' suffixes.
</dd>
<dt id="Germline.sample.metrics.ampliconIntervals"><a href="#Germline.sample.metrics.ampliconIntervals">Germline.sample.metrics.ampliconIntervals</a></dt>
<dd>
    <i>File? </i><br />
    An interval list describinig the coordinates of the amplicons sequenced. This should only be used for targeted sequencing or WES. Required if `ampliconIntervals` is defined.
</dd>
<dt id="Germline.sample.metrics.refRefflat"><a href="#Germline.sample.metrics.refRefflat">Germline.sample.metrics.refRefflat</a></dt>
<dd>
    <i>File? </i><br />
    A refflat file containing gene annotations. If defined RNA sequencing metrics will be collected.
</dd>
<dt id="Germline.sample.metrics.strandedness"><a href="#Germline.sample.metrics.strandedness">Germline.sample.metrics.strandedness</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"None"</code><br />
    The strandedness of the RNA sequencing library preparation. One of "None" (unstranded), "FR" (forward-reverse: first read equal transcript) or "RF" (reverse-forward: second read equals transcript).
</dd>
<dt id="Germline.sample.metrics.targetIntervals"><a href="#Germline.sample.metrics.targetIntervals">Germline.sample.metrics.targetIntervals</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    An interval list describing the coordinates of the targets sequenced. This should only be used for targeted sequencing or WES. If defined targeted PCR metrics will be collected. Requires `ampliconIntervals` to also be defined.
</dd>
<dt id="Germline.sample.qc.contaminations"><a href="#Germline.sample.qc.contaminations">Germline.sample.qc.contaminations</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Contaminants/adapters to be removed from the reads.
</dd>
<dt id="Germline.sample.qc.readgroupName"><a href="#Germline.sample.qc.readgroupName">Germline.sample.qc.readgroupName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>sub(basename(read1),"(\.fq)?(\.fastq)?(\.gz)?","")</code><br />
    The name of the readgroup.
</dd>
<dt id="Germline.singleSampleGvcf"><a href="#Germline.singleSampleGvcf">Germline.singleSampleGvcf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to output single-sample gvcfs
</dd>
<dt id="Germline.svCalling.manta.callRegions"><a href="#Germline.svCalling.manta.callRegions">Germline.svCalling.manta.callRegions</a></dt>
<dd>
    <i>File? </i><br />
    The bed file which indicates the regions to operate on.
</dd>
<dt id="Germline.svCalling.manta.callRegionsIndex"><a href="#Germline.svCalling.manta.callRegionsIndex">Germline.svCalling.manta.callRegionsIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index of the bed file which indicates the regions to operate on.
</dd>
<dt id="Germline.svCalling.manta.exome"><a href="#Germline.svCalling.manta.exome">Germline.svCalling.manta.exome</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the data is from exome sequencing.
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.excludeIntervalList"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.excludeIntervalList">Germline.variantcalling.callAutosomal.haplotypeCaller.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.pedigree"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.pedigree">Germline.variantcalling.callAutosomal.haplotypeCaller.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders"
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.ploidy"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.ploidy">Germline.variantcalling.callAutosomal.haplotypeCaller.ploidy</a></dt>
<dd>
    <i>Int? </i><br />
    The ploidy with which the variants should be called.
</dd>
<dt id="Germline.variantcalling.callX.excludeIntervalList"><a href="#Germline.variantcalling.callX.excludeIntervalList">Germline.variantcalling.callX.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="Germline.variantcalling.callX.pedigree"><a href="#Germline.variantcalling.callX.pedigree">Germline.variantcalling.callX.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders"
</dd>
<dt id="Germline.variantcalling.callY.excludeIntervalList"><a href="#Germline.variantcalling.callY.excludeIntervalList">Germline.variantcalling.callY.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="Germline.variantcalling.callY.pedigree"><a href="#Germline.variantcalling.callY.pedigree">Germline.variantcalling.callY.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders"
</dd>
<dt id="Germline.variantcalling.genotypeGvcfs.pedigree"><a href="#Germline.variantcalling.genotypeGvcfs.pedigree">Germline.variantcalling.genotypeGvcfs.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders"
</dd>
<dt id="Germline.XNonParRegions"><a href="#Germline.XNonParRegions">Germline.XNonParRegions</a></dt>
<dd>
    <i>File? </i><br />
    Bed file with the non-PAR regions of X.
</dd>
<dt id="Germline.YNonParRegions"><a href="#Germline.YNonParRegions">Germline.YNonParRegions</a></dt>
<dd>
    <i>File? </i><br />
    Bed file with the non-PAR regions of Y.
</dd>
</dl>

## Advanced inputs
<details>
<summary> Show/Hide </summary>
<dl>
<dt id="Germline.ConvertDockerImagesFile.dockerImage"><a href="#Germline.ConvertDockerImagesFile.dockerImage">Germline.ConvertDockerImagesFile.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/biowdl-input-converter:0.2.1--py_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.ConvertDockerImagesFile.outputJson"><a href="#Germline.ConvertDockerImagesFile.outputJson">Germline.ConvertDockerImagesFile.outputJson</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>basename(yaml,"\.ya?ml$") + ".json"</code><br />
    The location the output JSON file should be written to.
</dd>
<dt id="Germline.ConvertSampleConfig.checkFileMd5sums"><a href="#Germline.ConvertSampleConfig.checkFileMd5sums">Germline.ConvertSampleConfig.checkFileMd5sums</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the MD5 sums of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="Germline.ConvertSampleConfig.old"><a href="#Germline.ConvertSampleConfig.old">Germline.ConvertSampleConfig.old</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the old samplesheet format should be used.
</dd>
<dt id="Germline.ConvertSampleConfig.outputFile"><a href="#Germline.ConvertSampleConfig.outputFile">Germline.ConvertSampleConfig.outputFile</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"samplesheet.json"</code><br />
    The location the JSON representation of the samplesheet should be written to.
</dd>
<dt id="Germline.ConvertSampleConfig.skipFileCheck"><a href="#Germline.ConvertSampleConfig.skipFileCheck">Germline.ConvertSampleConfig.skipFileCheck</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not the existance of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="Germline.multiqcTask.clConfig"><a href="#Germline.multiqcTask.clConfig">Germline.multiqcTask.clConfig</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--cl-config` option.
</dd>
<dt id="Germline.multiqcTask.comment"><a href="#Germline.multiqcTask.comment">Germline.multiqcTask.comment</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--comment` option.
</dd>
<dt id="Germline.multiqcTask.config"><a href="#Germline.multiqcTask.config">Germline.multiqcTask.config</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--config` option.
</dd>
<dt id="Germline.multiqcTask.dataDir"><a href="#Germline.multiqcTask.dataDir">Germline.multiqcTask.dataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--data-dir` flag.
</dd>
<dt id="Germline.multiqcTask.dataFormat"><a href="#Germline.multiqcTask.dataFormat">Germline.multiqcTask.dataFormat</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--data-format` option.
</dd>
<dt id="Germline.multiqcTask.dirs"><a href="#Germline.multiqcTask.dirs">Germline.multiqcTask.dirs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--dirs` flag.
</dd>
<dt id="Germline.multiqcTask.dirsDepth"><a href="#Germline.multiqcTask.dirsDepth">Germline.multiqcTask.dirsDepth</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to MultiQC's `--dirs-depth` option.
</dd>
<dt id="Germline.multiqcTask.exclude"><a href="#Germline.multiqcTask.exclude">Germline.multiqcTask.exclude</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--exclude` option.
</dd>
<dt id="Germline.multiqcTask.export"><a href="#Germline.multiqcTask.export">Germline.multiqcTask.export</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--export` flag.
</dd>
<dt id="Germline.multiqcTask.fileList"><a href="#Germline.multiqcTask.fileList">Germline.multiqcTask.fileList</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--file-list` option.
</dd>
<dt id="Germline.multiqcTask.fileName"><a href="#Germline.multiqcTask.fileName">Germline.multiqcTask.fileName</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--filename` option.
</dd>
<dt id="Germline.multiqcTask.flat"><a href="#Germline.multiqcTask.flat">Germline.multiqcTask.flat</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--flat` flag.
</dd>
<dt id="Germline.multiqcTask.force"><a href="#Germline.multiqcTask.force">Germline.multiqcTask.force</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--force` flag.
</dd>
<dt id="Germline.multiqcTask.fullNames"><a href="#Germline.multiqcTask.fullNames">Germline.multiqcTask.fullNames</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--fullnames` flag.
</dd>
<dt id="Germline.multiqcTask.ignore"><a href="#Germline.multiqcTask.ignore">Germline.multiqcTask.ignore</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore` option.
</dd>
<dt id="Germline.multiqcTask.ignoreSamples"><a href="#Germline.multiqcTask.ignoreSamples">Germline.multiqcTask.ignoreSamples</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore-samples` option.
</dd>
<dt id="Germline.multiqcTask.ignoreSymlinks"><a href="#Germline.multiqcTask.ignoreSymlinks">Germline.multiqcTask.ignoreSymlinks</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--ignore-symlinks` flag.
</dd>
<dt id="Germline.multiqcTask.interactive"><a href="#Germline.multiqcTask.interactive">Germline.multiqcTask.interactive</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to MultiQC's `--interactive` flag.
</dd>
<dt id="Germline.multiqcTask.lint"><a href="#Germline.multiqcTask.lint">Germline.multiqcTask.lint</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--lint` flag.
</dd>
<dt id="Germline.multiqcTask.megaQCUpload"><a href="#Germline.multiqcTask.megaQCUpload">Germline.multiqcTask.megaQCUpload</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Opposite to MultiQC's `--no-megaqc-upload` flag.
</dd>
<dt id="Germline.multiqcTask.memory"><a href="#Germline.multiqcTask.memory">Germline.multiqcTask.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.multiqcTask.module"><a href="#Germline.multiqcTask.module">Germline.multiqcTask.module</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--module` option.
</dd>
<dt id="Germline.multiqcTask.noDataDir"><a href="#Germline.multiqcTask.noDataDir">Germline.multiqcTask.noDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--no-data-dir` flag.
</dd>
<dt id="Germline.multiqcTask.pdf"><a href="#Germline.multiqcTask.pdf">Germline.multiqcTask.pdf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--pdf` flag.
</dd>
<dt id="Germline.multiqcTask.sampleNames"><a href="#Germline.multiqcTask.sampleNames">Germline.multiqcTask.sampleNames</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--sample-names` option.
</dd>
<dt id="Germline.multiqcTask.tag"><a href="#Germline.multiqcTask.tag">Germline.multiqcTask.tag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--tag` option.
</dd>
<dt id="Germline.multiqcTask.template"><a href="#Germline.multiqcTask.template">Germline.multiqcTask.template</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--template` option.
</dd>
<dt id="Germline.multiqcTask.title"><a href="#Germline.multiqcTask.title">Germline.multiqcTask.title</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--title` option.
</dd>
<dt id="Germline.multiqcTask.zipDataDir"><a href="#Germline.multiqcTask.zipDataDir">Germline.multiqcTask.zipDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--zip-data-dir` flag.
</dd>
<dt id="Germline.platform"><a href="#Germline.platform">Germline.platform</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"illumina"</code><br />
    The platform used for sequencing.
</dd>
<dt id="Germline.runMultiQC"><a href="#Germline.runMultiQC">Germline.runMultiQC</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>if outputDir == "." then false else true</code><br />
    Whether or not MultiQC should be run.
</dd>
<dt id="Germline.runSVcalling"><a href="#Germline.runSVcalling">Germline.runSVcalling</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not Structural-variantcalling should be run.
</dd>
<dt id="Germline.sample.bqsr.applyBqsr.javaXmx"><a href="#Germline.sample.bqsr.applyBqsr.javaXmx">Germline.sample.bqsr.applyBqsr.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.bqsr.applyBqsr.memory"><a href="#Germline.sample.bqsr.applyBqsr.memory">Germline.sample.bqsr.applyBqsr.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bqsr.baseRecalibrator.javaXmx"><a href="#Germline.sample.bqsr.baseRecalibrator.javaXmx">Germline.sample.bqsr.baseRecalibrator.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes"><a href="#Germline.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes">Germline.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    The indexed for the known variant VCFs.
</dd>
<dt id="Germline.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFs"><a href="#Germline.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFs">Germline.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFs</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    VCF files with known indels.
</dd>
<dt id="Germline.sample.bqsr.baseRecalibrator.memory"><a href="#Germline.sample.bqsr.baseRecalibrator.memory">Germline.sample.bqsr.baseRecalibrator.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bqsr.gatherBamFiles.javaXmx"><a href="#Germline.sample.bqsr.gatherBamFiles.javaXmx">Germline.sample.bqsr.gatherBamFiles.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.bqsr.gatherBamFiles.memory"><a href="#Germline.sample.bqsr.gatherBamFiles.memory">Germline.sample.bqsr.gatherBamFiles.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bqsr.gatherBqsr.javaXmx"><a href="#Germline.sample.bqsr.gatherBqsr.javaXmx">Germline.sample.bqsr.gatherBqsr.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.bqsr.gatherBqsr.memory"><a href="#Germline.sample.bqsr.gatherBqsr.memory">Germline.sample.bqsr.gatherBqsr.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bqsr.scatterList.bamFile"><a href="#Germline.sample.bqsr.scatterList.bamFile">Germline.sample.bqsr.scatterList.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="Germline.sample.bqsr.scatterList.bamIndex"><a href="#Germline.sample.bqsr.scatterList.bamIndex">Germline.sample.bqsr.scatterList.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="Germline.sample.bqsr.scatterList.javaXmx"><a href="#Germline.sample.bqsr.scatterList.javaXmx">Germline.sample.bqsr.scatterList.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.bqsr.scatterList.memory"><a href="#Germline.sample.bqsr.scatterList.memory">Germline.sample.bqsr.scatterList.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bqsr.scatterSizeMillions"><a href="#Germline.sample.bqsr.scatterSizeMillions">Germline.sample.bqsr.scatterSizeMillions</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily
</dd>
<dt id="Germline.sample.bqsr.splitNCigarReads.javaXmx"><a href="#Germline.sample.bqsr.splitNCigarReads.javaXmx">Germline.sample.bqsr.splitNCigarReads.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.bqsr.splitNCigarReads.memory"><a href="#Germline.sample.bqsr.splitNCigarReads.memory">Germline.sample.bqsr.splitNCigarReads.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"16G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bwakit.compressionLevel"><a href="#Germline.sample.bwakit.compressionLevel">Germline.sample.bwakit.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level of the output BAM.
</dd>
<dt id="Germline.sample.bwakit.memory"><a href="#Germline.sample.bwakit.memory">Germline.sample.bwakit.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bwakit.sortMemoryPerThread"><a href="#Germline.sample.bwakit.sortMemoryPerThread">Germline.sample.bwakit.sortMemoryPerThread</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory for each sorting thread.
</dd>
<dt id="Germline.sample.bwakit.sortThreads"><a href="#Germline.sample.bwakit.sortThreads">Germline.sample.bwakit.sortThreads</a></dt>
<dd>
    <i>Int? </i><br />
    The number of additional threads to use for sorting.
</dd>
<dt id="Germline.sample.bwakit.threads"><a href="#Germline.sample.bwakit.threads">Germline.sample.bwakit.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of threads to use for alignment.
</dd>
<dt id="Germline.sample.bwaMem.memory"><a href="#Germline.sample.bwaMem.memory">Germline.sample.bwaMem.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.bwaMem.picardXmx"><a href="#Germline.sample.bwaMem.picardXmx">Germline.sample.bwaMem.picardXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to picard SortSam. Should be lower than `memory` to accommodate JVM overhead and BWA mem's memory usage.
</dd>
<dt id="Germline.sample.bwaMem.threads"><a href="#Germline.sample.bwaMem.threads">Germline.sample.bwaMem.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of threads to use.
</dd>
<dt id="Germline.sample.markdup.javaXmx"><a href="#Germline.sample.markdup.javaXmx">Germline.sample.markdup.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.markdup.memory"><a href="#Germline.sample.markdup.memory">Germline.sample.markdup.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.markdup.read_name_regex"><a href="#Germline.sample.markdup.read_name_regex">Germline.sample.markdup.read_name_regex</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the `READ_NAME_REGEX` option of MarkDuplicates.
</dd>
<dt id="Germline.sample.metrics.ampliconIntervalsLists.javaXmx"><a href="#Germline.sample.metrics.ampliconIntervalsLists.javaXmx">Germline.sample.metrics.ampliconIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.metrics.ampliconIntervalsLists.memory"><a href="#Germline.sample.metrics.ampliconIntervalsLists.memory">Germline.sample.metrics.ampliconIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.collectAlignmentSummaryMetrics"><a href="#Germline.sample.metrics.picardMetrics.collectAlignmentSummaryMetrics">Germline.sample.metrics.picardMetrics.collectAlignmentSummaryMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectAlignmentSummaryMetrics` argument.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.collectBaseDistributionByCycle"><a href="#Germline.sample.metrics.picardMetrics.collectBaseDistributionByCycle">Germline.sample.metrics.picardMetrics.collectBaseDistributionByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectBaseDistributionByCycle` argument.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.collectGcBiasMetrics"><a href="#Germline.sample.metrics.picardMetrics.collectGcBiasMetrics">Germline.sample.metrics.picardMetrics.collectGcBiasMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectGcBiasMetrics` argument.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.collectInsertSizeMetrics"><a href="#Germline.sample.metrics.picardMetrics.collectInsertSizeMetrics">Germline.sample.metrics.picardMetrics.collectInsertSizeMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectInsertSizeMetrics` argument.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.collectQualityYieldMetrics"><a href="#Germline.sample.metrics.picardMetrics.collectQualityYieldMetrics">Germline.sample.metrics.picardMetrics.collectQualityYieldMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectQualityYieldMetrics` argument.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.collectSequencingArtifactMetrics"><a href="#Germline.sample.metrics.picardMetrics.collectSequencingArtifactMetrics">Germline.sample.metrics.picardMetrics.collectSequencingArtifactMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectSequencingArtifactMetrics` argument.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.javaXmx"><a href="#Germline.sample.metrics.picardMetrics.javaXmx">Germline.sample.metrics.picardMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.meanQualityByCycle"><a href="#Germline.sample.metrics.picardMetrics.meanQualityByCycle">Germline.sample.metrics.picardMetrics.meanQualityByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=MeanQualityByCycle` argument.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.memory"><a href="#Germline.sample.metrics.picardMetrics.memory">Germline.sample.metrics.picardMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.metrics.picardMetrics.qualityScoreDistribution"><a href="#Germline.sample.metrics.picardMetrics.qualityScoreDistribution">Germline.sample.metrics.picardMetrics.qualityScoreDistribution</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=QualityScoreDistribution` argument.
</dd>
<dt id="Germline.sample.metrics.rnaSeqMetrics.javaXmx"><a href="#Germline.sample.metrics.rnaSeqMetrics.javaXmx">Germline.sample.metrics.rnaSeqMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.metrics.rnaSeqMetrics.memory"><a href="#Germline.sample.metrics.rnaSeqMetrics.memory">Germline.sample.metrics.rnaSeqMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.metrics.targetIntervalsLists.javaXmx"><a href="#Germline.sample.metrics.targetIntervalsLists.javaXmx">Germline.sample.metrics.targetIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.metrics.targetIntervalsLists.memory"><a href="#Germline.sample.metrics.targetIntervalsLists.memory">Germline.sample.metrics.targetIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.metrics.targetMetrics.javaXmx"><a href="#Germline.sample.metrics.targetMetrics.javaXmx">Germline.sample.metrics.targetMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sample.metrics.targetMetrics.memory"><a href="#Germline.sample.metrics.targetMetrics.memory">Germline.sample.metrics.targetMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.qc.Cutadapt.bwa"><a href="#Germline.sample.qc.Cutadapt.bwa">Germline.sample.qc.Cutadapt.bwa</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --bwa flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.colorspace"><a href="#Germline.sample.qc.Cutadapt.colorspace">Germline.sample.qc.Cutadapt.colorspace</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --colorspace flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.compressionLevel"><a href="#Germline.sample.qc.Cutadapt.compressionLevel">Germline.sample.qc.Cutadapt.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level if gzipped output is used.
</dd>
<dt id="Germline.sample.qc.Cutadapt.cores"><a href="#Germline.sample.qc.Cutadapt.cores">Germline.sample.qc.Cutadapt.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sample.qc.Cutadapt.cut"><a href="#Germline.sample.qc.Cutadapt.cut">Germline.sample.qc.Cutadapt.cut</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --cut option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.discardTrimmed"><a href="#Germline.sample.qc.Cutadapt.discardTrimmed">Germline.sample.qc.Cutadapt.discardTrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.discardUntrimmed"><a href="#Germline.sample.qc.Cutadapt.discardUntrimmed">Germline.sample.qc.Cutadapt.discardUntrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --discard-untrimmed option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.doubleEncode"><a href="#Germline.sample.qc.Cutadapt.doubleEncode">Germline.sample.qc.Cutadapt.doubleEncode</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --double-encode flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.errorRate"><a href="#Germline.sample.qc.Cutadapt.errorRate">Germline.sample.qc.Cutadapt.errorRate</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to cutadapt's --error-rate option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.front"><a href="#Germline.sample.qc.Cutadapt.front">Germline.sample.qc.Cutadapt.front</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given first or single end fastq file.
</dd>
<dt id="Germline.sample.qc.Cutadapt.frontRead2"><a href="#Germline.sample.qc.Cutadapt.frontRead2">Germline.sample.qc.Cutadapt.frontRead2</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given second end fastq file.
</dd>
<dt id="Germline.sample.qc.Cutadapt.infoFilePath"><a href="#Germline.sample.qc.Cutadapt.infoFilePath">Germline.sample.qc.Cutadapt.infoFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --info-file option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.interleaved"><a href="#Germline.sample.qc.Cutadapt.interleaved">Germline.sample.qc.Cutadapt.interleaved</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --interleaved flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.length"><a href="#Germline.sample.qc.Cutadapt.length">Germline.sample.qc.Cutadapt.length</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --length option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.lengthTag"><a href="#Germline.sample.qc.Cutadapt.lengthTag">Germline.sample.qc.Cutadapt.lengthTag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --length-tag option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.maq"><a href="#Germline.sample.qc.Cutadapt.maq">Germline.sample.qc.Cutadapt.maq</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --maq flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.maskAdapter"><a href="#Germline.sample.qc.Cutadapt.maskAdapter">Germline.sample.qc.Cutadapt.maskAdapter</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --mask-adapter flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.matchReadWildcards"><a href="#Germline.sample.qc.Cutadapt.matchReadWildcards">Germline.sample.qc.Cutadapt.matchReadWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --match-read-wildcards flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.maximumLength"><a href="#Germline.sample.qc.Cutadapt.maximumLength">Germline.sample.qc.Cutadapt.maximumLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --maximum-length option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.maxN"><a href="#Germline.sample.qc.Cutadapt.maxN">Germline.sample.qc.Cutadapt.maxN</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --max-n option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.memory"><a href="#Germline.sample.qc.Cutadapt.memory">Germline.sample.qc.Cutadapt.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.qc.Cutadapt.minimumLength"><a href="#Germline.sample.qc.Cutadapt.minimumLength">Germline.sample.qc.Cutadapt.minimumLength</a></dt>
<dd>
    <i>Int? </i><i>&mdash; Default:</i> <code>2</code><br />
    Equivalent to cutadapt's --minimum-length option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.nextseqTrim"><a href="#Germline.sample.qc.Cutadapt.nextseqTrim">Germline.sample.qc.Cutadapt.nextseqTrim</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --nextseq-trim option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.noIndels"><a href="#Germline.sample.qc.Cutadapt.noIndels">Germline.sample.qc.Cutadapt.noIndels</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-indels flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.noMatchAdapterWildcards"><a href="#Germline.sample.qc.Cutadapt.noMatchAdapterWildcards">Germline.sample.qc.Cutadapt.noMatchAdapterWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-match-adapter-wildcards flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.noTrim"><a href="#Germline.sample.qc.Cutadapt.noTrim">Germline.sample.qc.Cutadapt.noTrim</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-trim flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.noZeroCap"><a href="#Germline.sample.qc.Cutadapt.noZeroCap">Germline.sample.qc.Cutadapt.noZeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-zero-cap flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.overlap"><a href="#Germline.sample.qc.Cutadapt.overlap">Germline.sample.qc.Cutadapt.overlap</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --overlap option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.pairFilter"><a href="#Germline.sample.qc.Cutadapt.pairFilter">Germline.sample.qc.Cutadapt.pairFilter</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --pair-filter option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.prefix"><a href="#Germline.sample.qc.Cutadapt.prefix">Germline.sample.qc.Cutadapt.prefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --prefix option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.qualityBase"><a href="#Germline.sample.qc.Cutadapt.qualityBase">Germline.sample.qc.Cutadapt.qualityBase</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --quality-base option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.qualityCutoff"><a href="#Germline.sample.qc.Cutadapt.qualityCutoff">Germline.sample.qc.Cutadapt.qualityCutoff</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.restFilePath"><a href="#Germline.sample.qc.Cutadapt.restFilePath">Germline.sample.qc.Cutadapt.restFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --rest-file option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.stripF3"><a href="#Germline.sample.qc.Cutadapt.stripF3">Germline.sample.qc.Cutadapt.stripF3</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --strip-f3 flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.stripSuffix"><a href="#Germline.sample.qc.Cutadapt.stripSuffix">Germline.sample.qc.Cutadapt.stripSuffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --strip-suffix option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.suffix"><a href="#Germline.sample.qc.Cutadapt.suffix">Germline.sample.qc.Cutadapt.suffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --suffix option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.times"><a href="#Germline.sample.qc.Cutadapt.times">Germline.sample.qc.Cutadapt.times</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --times option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.tooLongOutputPath"><a href="#Germline.sample.qc.Cutadapt.tooLongOutputPath">Germline.sample.qc.Cutadapt.tooLongOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-output option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.tooLongPairedOutputPath"><a href="#Germline.sample.qc.Cutadapt.tooLongPairedOutputPath">Germline.sample.qc.Cutadapt.tooLongPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-paired-output option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.tooShortOutputPath"><a href="#Germline.sample.qc.Cutadapt.tooShortOutputPath">Germline.sample.qc.Cutadapt.tooShortOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-output option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.tooShortPairedOutputPath"><a href="#Germline.sample.qc.Cutadapt.tooShortPairedOutputPath">Germline.sample.qc.Cutadapt.tooShortPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-paired-output option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.trimN"><a href="#Germline.sample.qc.Cutadapt.trimN">Germline.sample.qc.Cutadapt.trimN</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --trim-n flag.
</dd>
<dt id="Germline.sample.qc.Cutadapt.untrimmedOutputPath"><a href="#Germline.sample.qc.Cutadapt.untrimmedOutputPath">Germline.sample.qc.Cutadapt.untrimmedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-output option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.untrimmedPairedOutputPath"><a href="#Germline.sample.qc.Cutadapt.untrimmedPairedOutputPath">Germline.sample.qc.Cutadapt.untrimmedPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-paired-output option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.wildcardFilePath"><a href="#Germline.sample.qc.Cutadapt.wildcardFilePath">Germline.sample.qc.Cutadapt.wildcardFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --wildcard-file option.
</dd>
<dt id="Germline.sample.qc.Cutadapt.zeroCap"><a href="#Germline.sample.qc.Cutadapt.zeroCap">Germline.sample.qc.Cutadapt.zeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --zero-cap flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.adapters"><a href="#Germline.sample.qc.FastqcRead1.adapters">Germline.sample.qc.FastqcRead1.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.casava"><a href="#Germline.sample.qc.FastqcRead1.casava">Germline.sample.qc.FastqcRead1.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.contaminants"><a href="#Germline.sample.qc.FastqcRead1.contaminants">Germline.sample.qc.FastqcRead1.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.dir"><a href="#Germline.sample.qc.FastqcRead1.dir">Germline.sample.qc.FastqcRead1.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.extract"><a href="#Germline.sample.qc.FastqcRead1.extract">Germline.sample.qc.FastqcRead1.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.format"><a href="#Germline.sample.qc.FastqcRead1.format">Germline.sample.qc.FastqcRead1.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.kmers"><a href="#Germline.sample.qc.FastqcRead1.kmers">Germline.sample.qc.FastqcRead1.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.limits"><a href="#Germline.sample.qc.FastqcRead1.limits">Germline.sample.qc.FastqcRead1.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.memory"><a href="#Germline.sample.qc.FastqcRead1.memory">Germline.sample.qc.FastqcRead1.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.minLength"><a href="#Germline.sample.qc.FastqcRead1.minLength">Germline.sample.qc.FastqcRead1.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.nano"><a href="#Germline.sample.qc.FastqcRead1.nano">Germline.sample.qc.FastqcRead1.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.noFilter"><a href="#Germline.sample.qc.FastqcRead1.noFilter">Germline.sample.qc.FastqcRead1.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.nogroup"><a href="#Germline.sample.qc.FastqcRead1.nogroup">Germline.sample.qc.FastqcRead1.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1.threads"><a href="#Germline.sample.qc.FastqcRead1.threads">Germline.sample.qc.FastqcRead1.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.adapters"><a href="#Germline.sample.qc.FastqcRead1After.adapters">Germline.sample.qc.FastqcRead1After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.casava"><a href="#Germline.sample.qc.FastqcRead1After.casava">Germline.sample.qc.FastqcRead1After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.contaminants"><a href="#Germline.sample.qc.FastqcRead1After.contaminants">Germline.sample.qc.FastqcRead1After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.dir"><a href="#Germline.sample.qc.FastqcRead1After.dir">Germline.sample.qc.FastqcRead1After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.extract"><a href="#Germline.sample.qc.FastqcRead1After.extract">Germline.sample.qc.FastqcRead1After.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.format"><a href="#Germline.sample.qc.FastqcRead1After.format">Germline.sample.qc.FastqcRead1After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.kmers"><a href="#Germline.sample.qc.FastqcRead1After.kmers">Germline.sample.qc.FastqcRead1After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.limits"><a href="#Germline.sample.qc.FastqcRead1After.limits">Germline.sample.qc.FastqcRead1After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.memory"><a href="#Germline.sample.qc.FastqcRead1After.memory">Germline.sample.qc.FastqcRead1After.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.minLength"><a href="#Germline.sample.qc.FastqcRead1After.minLength">Germline.sample.qc.FastqcRead1After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.nano"><a href="#Germline.sample.qc.FastqcRead1After.nano">Germline.sample.qc.FastqcRead1After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.noFilter"><a href="#Germline.sample.qc.FastqcRead1After.noFilter">Germline.sample.qc.FastqcRead1After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.nogroup"><a href="#Germline.sample.qc.FastqcRead1After.nogroup">Germline.sample.qc.FastqcRead1After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead1After.threads"><a href="#Germline.sample.qc.FastqcRead1After.threads">Germline.sample.qc.FastqcRead1After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.adapters"><a href="#Germline.sample.qc.FastqcRead2.adapters">Germline.sample.qc.FastqcRead2.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.casava"><a href="#Germline.sample.qc.FastqcRead2.casava">Germline.sample.qc.FastqcRead2.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.contaminants"><a href="#Germline.sample.qc.FastqcRead2.contaminants">Germline.sample.qc.FastqcRead2.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.dir"><a href="#Germline.sample.qc.FastqcRead2.dir">Germline.sample.qc.FastqcRead2.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.extract"><a href="#Germline.sample.qc.FastqcRead2.extract">Germline.sample.qc.FastqcRead2.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.format"><a href="#Germline.sample.qc.FastqcRead2.format">Germline.sample.qc.FastqcRead2.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.kmers"><a href="#Germline.sample.qc.FastqcRead2.kmers">Germline.sample.qc.FastqcRead2.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.limits"><a href="#Germline.sample.qc.FastqcRead2.limits">Germline.sample.qc.FastqcRead2.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.memory"><a href="#Germline.sample.qc.FastqcRead2.memory">Germline.sample.qc.FastqcRead2.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.minLength"><a href="#Germline.sample.qc.FastqcRead2.minLength">Germline.sample.qc.FastqcRead2.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.nano"><a href="#Germline.sample.qc.FastqcRead2.nano">Germline.sample.qc.FastqcRead2.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.noFilter"><a href="#Germline.sample.qc.FastqcRead2.noFilter">Germline.sample.qc.FastqcRead2.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.nogroup"><a href="#Germline.sample.qc.FastqcRead2.nogroup">Germline.sample.qc.FastqcRead2.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2.threads"><a href="#Germline.sample.qc.FastqcRead2.threads">Germline.sample.qc.FastqcRead2.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.adapters"><a href="#Germline.sample.qc.FastqcRead2After.adapters">Germline.sample.qc.FastqcRead2After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.casava"><a href="#Germline.sample.qc.FastqcRead2After.casava">Germline.sample.qc.FastqcRead2After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.contaminants"><a href="#Germline.sample.qc.FastqcRead2After.contaminants">Germline.sample.qc.FastqcRead2After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.dir"><a href="#Germline.sample.qc.FastqcRead2After.dir">Germline.sample.qc.FastqcRead2After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.extract"><a href="#Germline.sample.qc.FastqcRead2After.extract">Germline.sample.qc.FastqcRead2After.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.format"><a href="#Germline.sample.qc.FastqcRead2After.format">Germline.sample.qc.FastqcRead2After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.kmers"><a href="#Germline.sample.qc.FastqcRead2After.kmers">Germline.sample.qc.FastqcRead2After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.limits"><a href="#Germline.sample.qc.FastqcRead2After.limits">Germline.sample.qc.FastqcRead2After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.memory"><a href="#Germline.sample.qc.FastqcRead2After.memory">Germline.sample.qc.FastqcRead2After.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.minLength"><a href="#Germline.sample.qc.FastqcRead2After.minLength">Germline.sample.qc.FastqcRead2After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.nano"><a href="#Germline.sample.qc.FastqcRead2After.nano">Germline.sample.qc.FastqcRead2After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.noFilter"><a href="#Germline.sample.qc.FastqcRead2After.noFilter">Germline.sample.qc.FastqcRead2After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.nogroup"><a href="#Germline.sample.qc.FastqcRead2After.nogroup">Germline.sample.qc.FastqcRead2After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sample.qc.FastqcRead2After.threads"><a href="#Germline.sample.qc.FastqcRead2After.threads">Germline.sample.qc.FastqcRead2After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sample.qc.runAdapterClipping"><a href="#Germline.sample.qc.runAdapterClipping">Germline.sample.qc.runAdapterClipping</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>defined(adapterForward) || defined(adapterReverse) || length(select_first([contaminations, []])) > 0</code><br />
    Whether or not adapters should be removed from the reads.
</dd>
<dt id="Germline.scatterSize"><a href="#Germline.scatterSize">Germline.scatterSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>scatterSizeMillions * 1000000</code><br />
    The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
<dt id="Germline.scatterSizeMillions"><a href="#Germline.scatterSizeMillions">Germline.scatterSizeMillions</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.
</dd>
<dt id="Germline.svCalling.clever.memory"><a href="#Germline.svCalling.clever.memory">Germline.svCalling.clever.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"15G"</code><br />
    The memory required to run the programs
</dd>
<dt id="Germline.svCalling.clever.threads"><a href="#Germline.svCalling.clever.threads">Germline.svCalling.clever.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The the number of threads required to run a program
</dd>
<dt id="Germline.svCalling.delly.memory"><a href="#Germline.svCalling.delly.memory">Germline.svCalling.delly.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"15G"</code><br />
    The memory required to run the programs
</dd>
<dt id="Germline.svCalling.mateclever.cleverMaxDelLength"><a href="#Germline.svCalling.mateclever.cleverMaxDelLength">Germline.svCalling.mateclever.cleverMaxDelLength</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>100000</code><br />
    The maximum deletion length to look for in Clever predictions.
</dd>
<dt id="Germline.svCalling.mateclever.maxLengthDiff"><a href="#Germline.svCalling.mateclever.maxLengthDiff">Germline.svCalling.mateclever.maxLengthDiff</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>30</code><br />
    The maximum length difference between split-read and read-pair deletion to be considered identical.
</dd>
<dt id="Germline.svCalling.mateclever.maxOffset"><a href="#Germline.svCalling.mateclever.maxOffset">Germline.svCalling.mateclever.maxOffset</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>150</code><br />
    The maximum center distance between split-read and read-pair deletion to be considered identical.
</dd>
<dt id="Germline.svCalling.mateclever.memory"><a href="#Germline.svCalling.mateclever.memory">Germline.svCalling.mateclever.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"15G"</code><br />
    The memory required to run the programs
</dd>
<dt id="Germline.svCalling.mateclever.threads"><a href="#Germline.svCalling.mateclever.threads">Germline.svCalling.mateclever.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The the number of threads required to run a program
</dd>
<dt id="Germline.svCalling.renameSample.javaXmx"><a href="#Germline.svCalling.renameSample.javaXmx">Germline.svCalling.renameSample.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The max. memory allocated for JAVA
</dd>
<dt id="Germline.svCalling.renameSample.memory"><a href="#Germline.svCalling.renameSample.memory">Germline.svCalling.renameSample.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The memory required to run the programs
</dd>
<dt id="Germline.svCalling.survivor.breakpointDistance"><a href="#Germline.svCalling.survivor.breakpointDistance">Germline.svCalling.survivor.breakpointDistance</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    The distance between pairwise breakpoints between SVs
</dd>
<dt id="Germline.svCalling.survivor.distanceBySvSize"><a href="#Germline.svCalling.survivor.distanceBySvSize">Germline.svCalling.survivor.distanceBySvSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>0</code><br />
    A boolean to predict the pairwise distance between the SVs based on their size
</dd>
<dt id="Germline.svCalling.survivor.memory"><a href="#Germline.svCalling.survivor.memory">Germline.svCalling.survivor.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The memory required to run the programs
</dd>
<dt id="Germline.svCalling.survivor.minSize"><a href="#Germline.svCalling.survivor.minSize">Germline.svCalling.survivor.minSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>30</code><br />
    The mimimum size of SV to be merged
</dd>
<dt id="Germline.svCalling.survivor.strandType"><a href="#Germline.svCalling.survivor.strandType">Germline.svCalling.survivor.strandType</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    A boolean to include strand type of an SV to be merged
</dd>
<dt id="Germline.svCalling.survivor.suppVecs"><a href="#Germline.svCalling.survivor.suppVecs">Germline.svCalling.survivor.suppVecs</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The minimum number of SV callers to support the merging
</dd>
<dt id="Germline.svCalling.survivor.svType"><a href="#Germline.svCalling.survivor.svType">Germline.svCalling.survivor.svType</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    A boolean to include the type SV to be merged
</dd>
<dt id="Germline.useBwaKit"><a href="#Germline.useBwaKit">Germline.useBwaKit</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not BWA kit should be used. If false BWA mem will be used.
</dd>
<dt id="Germline.variantcalling.calculateRegions.mergeBeds.outputBed"><a href="#Germline.variantcalling.calculateRegions.mergeBeds.outputBed">Germline.variantcalling.calculateRegions.mergeBeds.outputBed</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"merged.bed"</code><br />
    The path to write the output to
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.contamination"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.contamination">Germline.variantcalling.callAutosomal.haplotypeCaller.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.emitRefConfidence"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.emitRefConfidence">Germline.variantcalling.callAutosomal.haplotypeCaller.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.javaXmx"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.javaXmx">Germline.variantcalling.callAutosomal.haplotypeCaller.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.memory"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.memory">Germline.variantcalling.callAutosomal.haplotypeCaller.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.callAutosomal.haplotypeCaller.outputMode"><a href="#Germline.variantcalling.callAutosomal.haplotypeCaller.outputMode">Germline.variantcalling.callAutosomal.haplotypeCaller.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="Germline.variantcalling.callX.contamination"><a href="#Germline.variantcalling.callX.contamination">Germline.variantcalling.callX.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="Germline.variantcalling.callX.emitRefConfidence"><a href="#Germline.variantcalling.callX.emitRefConfidence">Germline.variantcalling.callX.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'
</dd>
<dt id="Germline.variantcalling.callX.javaXmx"><a href="#Germline.variantcalling.callX.javaXmx">Germline.variantcalling.callX.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.callX.memory"><a href="#Germline.variantcalling.callX.memory">Germline.variantcalling.callX.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.callX.outputMode"><a href="#Germline.variantcalling.callX.outputMode">Germline.variantcalling.callX.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="Germline.variantcalling.callY.contamination"><a href="#Germline.variantcalling.callY.contamination">Germline.variantcalling.callY.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="Germline.variantcalling.callY.emitRefConfidence"><a href="#Germline.variantcalling.callY.emitRefConfidence">Germline.variantcalling.callY.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'
</dd>
<dt id="Germline.variantcalling.callY.javaXmx"><a href="#Germline.variantcalling.callY.javaXmx">Germline.variantcalling.callY.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.callY.memory"><a href="#Germline.variantcalling.callY.memory">Germline.variantcalling.callY.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.callY.outputMode"><a href="#Germline.variantcalling.callY.outputMode">Germline.variantcalling.callY.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="Germline.variantcalling.gatherGvcfs.intervals"><a href="#Germline.variantcalling.gatherGvcfs.intervals">Germline.variantcalling.gatherGvcfs.intervals</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Bed files or interval lists describing the regions to operate on.
</dd>
<dt id="Germline.variantcalling.gatherGvcfs.javaXmx"><a href="#Germline.variantcalling.gatherGvcfs.javaXmx">Germline.variantcalling.gatherGvcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.gatherGvcfs.memory"><a href="#Germline.variantcalling.gatherGvcfs.memory">Germline.variantcalling.gatherGvcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.gatherVcfs.javaXmx"><a href="#Germline.variantcalling.gatherVcfs.javaXmx">Germline.variantcalling.gatherVcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.gatherVcfs.memory"><a href="#Germline.variantcalling.gatherVcfs.memory">Germline.variantcalling.gatherVcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.genotypeGvcfs.annotationGroups"><a href="#Germline.variantcalling.genotypeGvcfs.annotationGroups">Germline.variantcalling.genotypeGvcfs.annotationGroups</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>["StandardAnnotation"]</code><br />
    Which annotation groups will be used for the annotation
</dd>
<dt id="Germline.variantcalling.genotypeGvcfs.javaXmx"><a href="#Germline.variantcalling.genotypeGvcfs.javaXmx">Germline.variantcalling.genotypeGvcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"6G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.genotypeGvcfs.memory"><a href="#Germline.variantcalling.genotypeGvcfs.memory">Germline.variantcalling.genotypeGvcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"18G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.mergeSingleSampleGvcf.intervals"><a href="#Germline.variantcalling.mergeSingleSampleGvcf.intervals">Germline.variantcalling.mergeSingleSampleGvcf.intervals</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Bed files or interval lists describing the regions to operate on.
</dd>
<dt id="Germline.variantcalling.mergeSingleSampleGvcf.javaXmx"><a href="#Germline.variantcalling.mergeSingleSampleGvcf.javaXmx">Germline.variantcalling.mergeSingleSampleGvcf.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.mergeSingleSampleGvcf.memory"><a href="#Germline.variantcalling.mergeSingleSampleGvcf.memory">Germline.variantcalling.mergeSingleSampleGvcf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.mergeSingleSampleVcf.javaXmx"><a href="#Germline.variantcalling.mergeSingleSampleVcf.javaXmx">Germline.variantcalling.mergeSingleSampleVcf.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.mergeSingleSampleVcf.memory"><a href="#Germline.variantcalling.mergeSingleSampleVcf.memory">Germline.variantcalling.mergeSingleSampleVcf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.scatterAllRegions.bamFile"><a href="#Germline.variantcalling.scatterAllRegions.bamFile">Germline.variantcalling.scatterAllRegions.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="Germline.variantcalling.scatterAllRegions.bamIndex"><a href="#Germline.variantcalling.scatterAllRegions.bamIndex">Germline.variantcalling.scatterAllRegions.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="Germline.variantcalling.scatterAllRegions.javaXmx"><a href="#Germline.variantcalling.scatterAllRegions.javaXmx">Germline.variantcalling.scatterAllRegions.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.scatterAllRegions.memory"><a href="#Germline.variantcalling.scatterAllRegions.memory">Germline.variantcalling.scatterAllRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.scatterAllRegions.notSplitContigs"><a href="#Germline.variantcalling.scatterAllRegions.notSplitContigs">Germline.variantcalling.scatterAllRegions.notSplitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to biopet scatterregions' `--notSplitContigs` flag.
</dd>
<dt id="Germline.variantcalling.scatterAutosomalRegions.bamFile"><a href="#Germline.variantcalling.scatterAutosomalRegions.bamFile">Germline.variantcalling.scatterAutosomalRegions.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="Germline.variantcalling.scatterAutosomalRegions.bamIndex"><a href="#Germline.variantcalling.scatterAutosomalRegions.bamIndex">Germline.variantcalling.scatterAutosomalRegions.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="Germline.variantcalling.scatterAutosomalRegions.javaXmx"><a href="#Germline.variantcalling.scatterAutosomalRegions.javaXmx">Germline.variantcalling.scatterAutosomalRegions.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.variantcalling.scatterAutosomalRegions.memory"><a href="#Germline.variantcalling.scatterAutosomalRegions.memory">Germline.variantcalling.scatterAutosomalRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.variantcalling.scatterAutosomalRegions.notSplitContigs"><a href="#Germline.variantcalling.scatterAutosomalRegions.notSplitContigs">Germline.variantcalling.scatterAutosomalRegions.notSplitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to biopet scatterregions' `--notSplitContigs` flag.
</dd>
<dt id="Germline.variantcalling.scatterSizeMillions"><a href="#Germline.variantcalling.scatterSizeMillions">Germline.variantcalling.scatterSizeMillions</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily
</dd>
</dl>
</details>





## Do not set these inputs!
The following inputs should ***not*** be set, even though womtool may
show them as being available inputs.

* Germline.sample.qc.FastqcRead1.NoneFile
* Germline.sample.qc.FastqcRead1.NoneArray
* Germline.sample.qc.FastqcRead2.NoneFile
* Germline.sample.qc.FastqcRead2.NoneArray
* Germline.sample.qc.FastqcRead1After.NoneFile
* Germline.sample.qc.FastqcRead1After.NoneArray
* Germline.sample.qc.FastqcRead2After.NoneFile
* Germline.sample.qc.FastqcRead2After.NoneArray
* Germline.multiqcTask.finished
* Germline.multiqcTask.dependencies
