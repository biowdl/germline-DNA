---
layout: default
title: "Inputs: Somatic"
---

# Inputs for Somatic

The following is an overview of all available inputs in
Somatic.


## Required inputs
<dl>
<dt id="Somatic.bwaIndex"><a href="#Somatic.bwaIndex">Somatic.bwaIndex</a></dt>
<dd>
    <i>struct(fastaFile : File, indexFiles : Array[File]) </i><br />
    The BWA index files.
</dd>
<dt id="Somatic.dbSNP"><a href="#Somatic.dbSNP">Somatic.dbSNP</a></dt>
<dd>
    <i>struct(file : File, index : File, md5sum : String?) </i><br />
    A dbSNP VCF file and its index.
</dd>
<dt id="Somatic.dockerImagesFile"><a href="#Somatic.dockerImagesFile">Somatic.dockerImagesFile</a></dt>
<dd>
    <i>File </i><br />
    A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.
</dd>
<dt id="Somatic.reference"><a href="#Somatic.reference">Somatic.reference</a></dt>
<dd>
    <i>struct(dict : File, fai : File, fasta : File) </i><br />
    The reference files: a fasta, its index and the associated sequence dictionary.
</dd>
<dt id="Somatic.sampleConfigFile"><a href="#Somatic.sampleConfigFile">Somatic.sampleConfigFile</a></dt>
<dd>
    <i>File </i><br />
    The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.
</dd>
</dl>

## Other common inputs
<dl>
<dt id="Somatic.outputDir"><a href="#Somatic.outputDir">Somatic.outputDir</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"."</code><br />
    The directory the output should be written to.
</dd>
<dt id="Somatic.regions"><a href="#Somatic.regions">Somatic.regions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to call variants for.
</dd>
<dt id="Somatic.sample.bqsr.regions"><a href="#Somatic.sample.bqsr.regions">Somatic.sample.bqsr.regions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to operate on.
</dd>
<dt id="Somatic.sample.bqsr.splitSplicedReads"><a href="#Somatic.sample.bqsr.splitSplicedReads">Somatic.sample.bqsr.splitSplicedReads</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not gatk's SplitNCgarReads should be run to split spliced reads. This should be enabled for RNAseq samples.
</dd>
<dt id="Somatic.sample.bwakit.sixtyFour"><a href="#Somatic.sample.bwakit.sixtyFour">Somatic.sample.bwakit.sixtyFour</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the index uses the '.64' suffixes.
</dd>
<dt id="Somatic.sample.metrics.ampliconIntervals"><a href="#Somatic.sample.metrics.ampliconIntervals">Somatic.sample.metrics.ampliconIntervals</a></dt>
<dd>
    <i>File? </i><br />
    An interval list describinig the coordinates of the amplicons sequenced. This should only be used for targeted sequencing or WES. Required if `ampliconIntervals` is defined.
</dd>
<dt id="Somatic.sample.metrics.refRefflat"><a href="#Somatic.sample.metrics.refRefflat">Somatic.sample.metrics.refRefflat</a></dt>
<dd>
    <i>File? </i><br />
    A refflat file containing gene annotations. If defined RNA sequencing metrics will be collected.
</dd>
<dt id="Somatic.sample.metrics.strandedness"><a href="#Somatic.sample.metrics.strandedness">Somatic.sample.metrics.strandedness</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"None"</code><br />
    The strandedness of the RNA sequencing library preparation. One of "None" (unstranded), "FR" (forward-reverse: first read equal transcript) or "RF" (reverse-forward: second read equals transcript).
</dd>
<dt id="Somatic.sample.metrics.targetIntervals"><a href="#Somatic.sample.metrics.targetIntervals">Somatic.sample.metrics.targetIntervals</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    An interval list describing the coordinates of the targets sequenced. This should only be used for targeted sequencing or WES. If defined targeted PCR metrics will be collected. Requires `ampliconIntervals` to also be defined.
</dd>
<dt id="Somatic.sample.qc.adapterForward"><a href="#Somatic.sample.qc.adapterForward">Somatic.sample.qc.adapterForward</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads first or single end reads.
</dd>
<dt id="Somatic.sample.qc.adapterReverse"><a href="#Somatic.sample.qc.adapterReverse">Somatic.sample.qc.adapterReverse</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads second end reads.
</dd>
<dt id="Somatic.sample.qc.contaminations"><a href="#Somatic.sample.qc.contaminations">Somatic.sample.qc.contaminations</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Contaminants/adapters to be removed from the reads.
</dd>
<dt id="Somatic.sample.qc.readgroupName"><a href="#Somatic.sample.qc.readgroupName">Somatic.sample.qc.readgroupName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>sub(basename(read1),"(\.fq)?(\.fastq)?(\.gz)?","")</code><br />
    The name of the readgroup.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.exclusionRegion"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.exclusionRegion">Somatic.somaticVariantcalling.pairedSomaticSeq.exclusionRegion</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing regions to exclude.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedTraining.exclusionRegion"><a href="#Somatic.somaticVariantcalling.pairedTraining.exclusionRegion">Somatic.somaticVariantcalling.pairedTraining.exclusionRegion</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing regions to exclude.
</dd>
<dt id="Somatic.somaticVariantcalling.runMutect2"><a href="#Somatic.somaticVariantcalling.runMutect2">Somatic.somaticVariantcalling.runMutect2</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not to run Mutect2.
</dd>
<dt id="Somatic.somaticVariantcalling.runStrelka"><a href="#Somatic.somaticVariantcalling.runStrelka">Somatic.somaticVariantcalling.runStrelka</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not to run Strelka.
</dd>
<dt id="Somatic.somaticVariantcalling.runVardict"><a href="#Somatic.somaticVariantcalling.runVardict">Somatic.somaticVariantcalling.runVardict</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not to run VarDict.
</dd>
<dt id="Somatic.somaticVariantcalling.singleSomaticSeq.exclusionRegion"><a href="#Somatic.somaticVariantcalling.singleSomaticSeq.exclusionRegion">Somatic.somaticVariantcalling.singleSomaticSeq.exclusionRegion</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing regions to exclude.
</dd>
<dt id="Somatic.somaticVariantcalling.singleTraining.exclusionRegion"><a href="#Somatic.somaticVariantcalling.singleTraining.exclusionRegion">Somatic.somaticVariantcalling.singleTraining.exclusionRegion</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing regions to exclude.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.exome"><a href="#Somatic.somaticVariantcalling.strelka.exome">Somatic.somaticVariantcalling.strelka.exome</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the data is from exome sequencing.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.rna"><a href="#Somatic.somaticVariantcalling.strelka.rna">Somatic.somaticVariantcalling.strelka.rna</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the data is from RNA sequencing.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.runManta"><a href="#Somatic.somaticVariantcalling.strelka.runManta">Somatic.somaticVariantcalling.strelka.runManta</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not mata should be run.
</dd>
</dl>

## Advanced inputs
<details>
<summary> Show/Hide </summary>
<dl>
<dt id="Somatic.controlPostition.dockerImage"><a href="#Somatic.controlPostition.dockerImage">Somatic.controlPostition.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"python:3.7-slim"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Somatic.ConvertDockerImagesFile.dockerImage"><a href="#Somatic.ConvertDockerImagesFile.dockerImage">Somatic.ConvertDockerImagesFile.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/biowdl-input-converter:0.2.1--py_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Somatic.ConvertDockerImagesFile.outputJson"><a href="#Somatic.ConvertDockerImagesFile.outputJson">Somatic.ConvertDockerImagesFile.outputJson</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>basename(yaml,"\.ya?ml$") + ".json"</code><br />
    The location the output JSON file should be written to.
</dd>
<dt id="Somatic.ConvertSampleConfig.checkFileMd5sums"><a href="#Somatic.ConvertSampleConfig.checkFileMd5sums">Somatic.ConvertSampleConfig.checkFileMd5sums</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the MD5 sums of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="Somatic.ConvertSampleConfig.old"><a href="#Somatic.ConvertSampleConfig.old">Somatic.ConvertSampleConfig.old</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the old samplesheet format should be used.
</dd>
<dt id="Somatic.ConvertSampleConfig.outputFile"><a href="#Somatic.ConvertSampleConfig.outputFile">Somatic.ConvertSampleConfig.outputFile</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"samplesheet.json"</code><br />
    The location the JSON representation of the samplesheet should be written to.
</dd>
<dt id="Somatic.ConvertSampleConfig.skipFileCheck"><a href="#Somatic.ConvertSampleConfig.skipFileCheck">Somatic.ConvertSampleConfig.skipFileCheck</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not the existance of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="Somatic.multiqcTask.clConfig"><a href="#Somatic.multiqcTask.clConfig">Somatic.multiqcTask.clConfig</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--cl-config` option.
</dd>
<dt id="Somatic.multiqcTask.comment"><a href="#Somatic.multiqcTask.comment">Somatic.multiqcTask.comment</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--comment` option.
</dd>
<dt id="Somatic.multiqcTask.config"><a href="#Somatic.multiqcTask.config">Somatic.multiqcTask.config</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--config` option.
</dd>
<dt id="Somatic.multiqcTask.dataDir"><a href="#Somatic.multiqcTask.dataDir">Somatic.multiqcTask.dataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--data-dir` flag.
</dd>
<dt id="Somatic.multiqcTask.dataFormat"><a href="#Somatic.multiqcTask.dataFormat">Somatic.multiqcTask.dataFormat</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--data-format` option.
</dd>
<dt id="Somatic.multiqcTask.dirs"><a href="#Somatic.multiqcTask.dirs">Somatic.multiqcTask.dirs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--dirs` flag.
</dd>
<dt id="Somatic.multiqcTask.dirsDepth"><a href="#Somatic.multiqcTask.dirsDepth">Somatic.multiqcTask.dirsDepth</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to MultiQC's `--dirs-depth` option.
</dd>
<dt id="Somatic.multiqcTask.exclude"><a href="#Somatic.multiqcTask.exclude">Somatic.multiqcTask.exclude</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--exclude` option.
</dd>
<dt id="Somatic.multiqcTask.export"><a href="#Somatic.multiqcTask.export">Somatic.multiqcTask.export</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--export` flag.
</dd>
<dt id="Somatic.multiqcTask.fileList"><a href="#Somatic.multiqcTask.fileList">Somatic.multiqcTask.fileList</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--file-list` option.
</dd>
<dt id="Somatic.multiqcTask.fileName"><a href="#Somatic.multiqcTask.fileName">Somatic.multiqcTask.fileName</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--filename` option.
</dd>
<dt id="Somatic.multiqcTask.flat"><a href="#Somatic.multiqcTask.flat">Somatic.multiqcTask.flat</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--flat` flag.
</dd>
<dt id="Somatic.multiqcTask.force"><a href="#Somatic.multiqcTask.force">Somatic.multiqcTask.force</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--force` flag.
</dd>
<dt id="Somatic.multiqcTask.fullNames"><a href="#Somatic.multiqcTask.fullNames">Somatic.multiqcTask.fullNames</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--fullnames` flag.
</dd>
<dt id="Somatic.multiqcTask.ignore"><a href="#Somatic.multiqcTask.ignore">Somatic.multiqcTask.ignore</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore` option.
</dd>
<dt id="Somatic.multiqcTask.ignoreSamples"><a href="#Somatic.multiqcTask.ignoreSamples">Somatic.multiqcTask.ignoreSamples</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore-samples` option.
</dd>
<dt id="Somatic.multiqcTask.ignoreSymlinks"><a href="#Somatic.multiqcTask.ignoreSymlinks">Somatic.multiqcTask.ignoreSymlinks</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--ignore-symlinks` flag.
</dd>
<dt id="Somatic.multiqcTask.interactive"><a href="#Somatic.multiqcTask.interactive">Somatic.multiqcTask.interactive</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to MultiQC's `--interactive` flag.
</dd>
<dt id="Somatic.multiqcTask.lint"><a href="#Somatic.multiqcTask.lint">Somatic.multiqcTask.lint</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--lint` flag.
</dd>
<dt id="Somatic.multiqcTask.megaQCUpload"><a href="#Somatic.multiqcTask.megaQCUpload">Somatic.multiqcTask.megaQCUpload</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Opposite to MultiQC's `--no-megaqc-upload` flag.
</dd>
<dt id="Somatic.multiqcTask.memory"><a href="#Somatic.multiqcTask.memory">Somatic.multiqcTask.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.multiqcTask.module"><a href="#Somatic.multiqcTask.module">Somatic.multiqcTask.module</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--module` option.
</dd>
<dt id="Somatic.multiqcTask.noDataDir"><a href="#Somatic.multiqcTask.noDataDir">Somatic.multiqcTask.noDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--no-data-dir` flag.
</dd>
<dt id="Somatic.multiqcTask.pdf"><a href="#Somatic.multiqcTask.pdf">Somatic.multiqcTask.pdf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--pdf` flag.
</dd>
<dt id="Somatic.multiqcTask.sampleNames"><a href="#Somatic.multiqcTask.sampleNames">Somatic.multiqcTask.sampleNames</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--sample-names` option.
</dd>
<dt id="Somatic.multiqcTask.tag"><a href="#Somatic.multiqcTask.tag">Somatic.multiqcTask.tag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--tag` option.
</dd>
<dt id="Somatic.multiqcTask.template"><a href="#Somatic.multiqcTask.template">Somatic.multiqcTask.template</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--template` option.
</dd>
<dt id="Somatic.multiqcTask.title"><a href="#Somatic.multiqcTask.title">Somatic.multiqcTask.title</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--title` option.
</dd>
<dt id="Somatic.multiqcTask.zipDataDir"><a href="#Somatic.multiqcTask.zipDataDir">Somatic.multiqcTask.zipDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--zip-data-dir` flag.
</dd>
<dt id="Somatic.runMultiQC"><a href="#Somatic.runMultiQC">Somatic.runMultiQC</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>if outputDir == "." then false else true</code><br />
    Whether or not MultiQC should be run.
</dd>
<dt id="Somatic.sample.bqsr.applyBqsr.javaXmx"><a href="#Somatic.sample.bqsr.applyBqsr.javaXmx">Somatic.sample.bqsr.applyBqsr.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.bqsr.applyBqsr.memory"><a href="#Somatic.sample.bqsr.applyBqsr.memory">Somatic.sample.bqsr.applyBqsr.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bqsr.baseRecalibrator.javaXmx"><a href="#Somatic.sample.bqsr.baseRecalibrator.javaXmx">Somatic.sample.bqsr.baseRecalibrator.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes"><a href="#Somatic.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes">Somatic.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    The indexed for the known variant VCFs.
</dd>
<dt id="Somatic.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFs"><a href="#Somatic.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFs">Somatic.sample.bqsr.baseRecalibrator.knownIndelsSitesVCFs</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    VCf files with known indels.
</dd>
<dt id="Somatic.sample.bqsr.baseRecalibrator.memory"><a href="#Somatic.sample.bqsr.baseRecalibrator.memory">Somatic.sample.bqsr.baseRecalibrator.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bqsr.gatherBamFiles.javaXmx"><a href="#Somatic.sample.bqsr.gatherBamFiles.javaXmx">Somatic.sample.bqsr.gatherBamFiles.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.bqsr.gatherBamFiles.memory"><a href="#Somatic.sample.bqsr.gatherBamFiles.memory">Somatic.sample.bqsr.gatherBamFiles.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bqsr.gatherBqsr.javaXmx"><a href="#Somatic.sample.bqsr.gatherBqsr.javaXmx">Somatic.sample.bqsr.gatherBqsr.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.bqsr.gatherBqsr.memory"><a href="#Somatic.sample.bqsr.gatherBqsr.memory">Somatic.sample.bqsr.gatherBqsr.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bqsr.orderedScatters.dockerImage"><a href="#Somatic.sample.bqsr.orderedScatters.dockerImage">Somatic.sample.bqsr.orderedScatters.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"python:3.7-slim"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Somatic.sample.bqsr.scatterList.bamFile"><a href="#Somatic.sample.bqsr.scatterList.bamFile">Somatic.sample.bqsr.scatterList.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="Somatic.sample.bqsr.scatterList.bamIndex"><a href="#Somatic.sample.bqsr.scatterList.bamIndex">Somatic.sample.bqsr.scatterList.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="Somatic.sample.bqsr.scatterList.javaXmx"><a href="#Somatic.sample.bqsr.scatterList.javaXmx">Somatic.sample.bqsr.scatterList.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.bqsr.scatterList.memory"><a href="#Somatic.sample.bqsr.scatterList.memory">Somatic.sample.bqsr.scatterList.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bqsr.scatterSize"><a href="#Somatic.sample.bqsr.scatterSize">Somatic.sample.bqsr.scatterSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000000000</code><br />
    The size of the scattered regions in bases. Scattering is used to speed up certain processes. The genome will be sseperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
<dt id="Somatic.sample.bqsr.splitNCigarReads.javaXmx"><a href="#Somatic.sample.bqsr.splitNCigarReads.javaXmx">Somatic.sample.bqsr.splitNCigarReads.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.bqsr.splitNCigarReads.memory"><a href="#Somatic.sample.bqsr.splitNCigarReads.memory">Somatic.sample.bqsr.splitNCigarReads.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"16G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bwakit.memory"><a href="#Somatic.sample.bwakit.memory">Somatic.sample.bwakit.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"10G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bwakit.sortThreads"><a href="#Somatic.sample.bwakit.sortThreads">Somatic.sample.bwakit.sortThreads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The number of threads to use for sorting.
</dd>
<dt id="Somatic.sample.bwakit.threads"><a href="#Somatic.sample.bwakit.threads">Somatic.sample.bwakit.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The number of threads to use for alignment.
</dd>
<dt id="Somatic.sample.bwaMem.memory"><a href="#Somatic.sample.bwaMem.memory">Somatic.sample.bwaMem.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"16G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.bwaMem.picardXmx"><a href="#Somatic.sample.bwaMem.picardXmx">Somatic.sample.bwaMem.picardXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to picard SortSam. Should be lower than `memory` to accommodate JVM overhead and BWA mem's memory usage.
</dd>
<dt id="Somatic.sample.bwaMem.threads"><a href="#Somatic.sample.bwaMem.threads">Somatic.sample.bwaMem.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.sample.markdup.javaXmx"><a href="#Somatic.sample.markdup.javaXmx">Somatic.sample.markdup.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.markdup.memory"><a href="#Somatic.sample.markdup.memory">Somatic.sample.markdup.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.markdup.read_name_regex"><a href="#Somatic.sample.markdup.read_name_regex">Somatic.sample.markdup.read_name_regex</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the `READ_NAME_REGEX` option of MarkDuplicates.
</dd>
<dt id="Somatic.sample.metrics.ampliconIntervalsLists.javaXmx"><a href="#Somatic.sample.metrics.ampliconIntervalsLists.javaXmx">Somatic.sample.metrics.ampliconIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. (Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.metrics.ampliconIntervalsLists.memory"><a href="#Somatic.sample.metrics.ampliconIntervalsLists.memory">Somatic.sample.metrics.ampliconIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.collectAlignmentSummaryMetrics"><a href="#Somatic.sample.metrics.picardMetrics.collectAlignmentSummaryMetrics">Somatic.sample.metrics.picardMetrics.collectAlignmentSummaryMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectAlignmentSummaryMetrics` argument.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.collectBaseDistributionByCycle"><a href="#Somatic.sample.metrics.picardMetrics.collectBaseDistributionByCycle">Somatic.sample.metrics.picardMetrics.collectBaseDistributionByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectBaseDistributionByCycle` argument.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.collectGcBiasMetrics"><a href="#Somatic.sample.metrics.picardMetrics.collectGcBiasMetrics">Somatic.sample.metrics.picardMetrics.collectGcBiasMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectGcBiasMetrics` argument.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.collectInsertSizeMetrics"><a href="#Somatic.sample.metrics.picardMetrics.collectInsertSizeMetrics">Somatic.sample.metrics.picardMetrics.collectInsertSizeMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectInsertSizeMetrics` argument.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.collectQualityYieldMetrics"><a href="#Somatic.sample.metrics.picardMetrics.collectQualityYieldMetrics">Somatic.sample.metrics.picardMetrics.collectQualityYieldMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectQualityYieldMetrics` argument.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.collectSequencingArtifactMetrics"><a href="#Somatic.sample.metrics.picardMetrics.collectSequencingArtifactMetrics">Somatic.sample.metrics.picardMetrics.collectSequencingArtifactMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectSequencingArtifactMetrics` argument.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.javaXmx"><a href="#Somatic.sample.metrics.picardMetrics.javaXmx">Somatic.sample.metrics.picardMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. (Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.meanQualityByCycle"><a href="#Somatic.sample.metrics.picardMetrics.meanQualityByCycle">Somatic.sample.metrics.picardMetrics.meanQualityByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=MeanQualityByCycle` argument.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.memory"><a href="#Somatic.sample.metrics.picardMetrics.memory">Somatic.sample.metrics.picardMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.metrics.picardMetrics.qualityScoreDistribution"><a href="#Somatic.sample.metrics.picardMetrics.qualityScoreDistribution">Somatic.sample.metrics.picardMetrics.qualityScoreDistribution</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=QualityScoreDistribution` argument.
</dd>
<dt id="Somatic.sample.metrics.rnaSeqMetrics.javaXmx"><a href="#Somatic.sample.metrics.rnaSeqMetrics.javaXmx">Somatic.sample.metrics.rnaSeqMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. (Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.metrics.rnaSeqMetrics.memory"><a href="#Somatic.sample.metrics.rnaSeqMetrics.memory">Somatic.sample.metrics.rnaSeqMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.metrics.targetIntervalsLists.javaXmx"><a href="#Somatic.sample.metrics.targetIntervalsLists.javaXmx">Somatic.sample.metrics.targetIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. (Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.metrics.targetIntervalsLists.memory"><a href="#Somatic.sample.metrics.targetIntervalsLists.memory">Somatic.sample.metrics.targetIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.metrics.targetMetrics.javaXmx"><a href="#Somatic.sample.metrics.targetMetrics.javaXmx">Somatic.sample.metrics.targetMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. (Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.sample.metrics.targetMetrics.memory"><a href="#Somatic.sample.metrics.targetMetrics.memory">Somatic.sample.metrics.targetMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.platform"><a href="#Somatic.sample.platform">Somatic.sample.platform</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"illumina"</code><br />
    The platform used for sequencing.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.bwa"><a href="#Somatic.sample.qc.Cutadapt.bwa">Somatic.sample.qc.Cutadapt.bwa</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --bwa flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.colorspace"><a href="#Somatic.sample.qc.Cutadapt.colorspace">Somatic.sample.qc.Cutadapt.colorspace</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --colorspace flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.cores"><a href="#Somatic.sample.qc.Cutadapt.cores">Somatic.sample.qc.Cutadapt.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.cut"><a href="#Somatic.sample.qc.Cutadapt.cut">Somatic.sample.qc.Cutadapt.cut</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --cut option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.discardTrimmed"><a href="#Somatic.sample.qc.Cutadapt.discardTrimmed">Somatic.sample.qc.Cutadapt.discardTrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.discardUntrimmed"><a href="#Somatic.sample.qc.Cutadapt.discardUntrimmed">Somatic.sample.qc.Cutadapt.discardUntrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --discard-untrimmed option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.doubleEncode"><a href="#Somatic.sample.qc.Cutadapt.doubleEncode">Somatic.sample.qc.Cutadapt.doubleEncode</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --double-encode flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.errorRate"><a href="#Somatic.sample.qc.Cutadapt.errorRate">Somatic.sample.qc.Cutadapt.errorRate</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to cutadapt's --error-rate option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.front"><a href="#Somatic.sample.qc.Cutadapt.front">Somatic.sample.qc.Cutadapt.front</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given first or single end fastq file.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.frontRead2"><a href="#Somatic.sample.qc.Cutadapt.frontRead2">Somatic.sample.qc.Cutadapt.frontRead2</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given second end fastq file.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.infoFilePath"><a href="#Somatic.sample.qc.Cutadapt.infoFilePath">Somatic.sample.qc.Cutadapt.infoFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --info-file option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.interleaved"><a href="#Somatic.sample.qc.Cutadapt.interleaved">Somatic.sample.qc.Cutadapt.interleaved</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --interleaved flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.length"><a href="#Somatic.sample.qc.Cutadapt.length">Somatic.sample.qc.Cutadapt.length</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --length option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.lengthTag"><a href="#Somatic.sample.qc.Cutadapt.lengthTag">Somatic.sample.qc.Cutadapt.lengthTag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --length-tag option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.maq"><a href="#Somatic.sample.qc.Cutadapt.maq">Somatic.sample.qc.Cutadapt.maq</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --maq flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.maskAdapter"><a href="#Somatic.sample.qc.Cutadapt.maskAdapter">Somatic.sample.qc.Cutadapt.maskAdapter</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --mask-adapter flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.matchReadWildcards"><a href="#Somatic.sample.qc.Cutadapt.matchReadWildcards">Somatic.sample.qc.Cutadapt.matchReadWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --match-read-wildcards flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.maximumLength"><a href="#Somatic.sample.qc.Cutadapt.maximumLength">Somatic.sample.qc.Cutadapt.maximumLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --maximum-length option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.maxN"><a href="#Somatic.sample.qc.Cutadapt.maxN">Somatic.sample.qc.Cutadapt.maxN</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --max-n option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.memory"><a href="#Somatic.sample.qc.Cutadapt.memory">Somatic.sample.qc.Cutadapt.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.minimumLength"><a href="#Somatic.sample.qc.Cutadapt.minimumLength">Somatic.sample.qc.Cutadapt.minimumLength</a></dt>
<dd>
    <i>Int? </i><i>&mdash; Default:</i> <code>2</code><br />
    Equivalent to cutadapt's --minimum-length option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.nextseqTrim"><a href="#Somatic.sample.qc.Cutadapt.nextseqTrim">Somatic.sample.qc.Cutadapt.nextseqTrim</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --nextseq-trim option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.noIndels"><a href="#Somatic.sample.qc.Cutadapt.noIndels">Somatic.sample.qc.Cutadapt.noIndels</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-indels flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.noMatchAdapterWildcards"><a href="#Somatic.sample.qc.Cutadapt.noMatchAdapterWildcards">Somatic.sample.qc.Cutadapt.noMatchAdapterWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-match-adapter-wildcards flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.noTrim"><a href="#Somatic.sample.qc.Cutadapt.noTrim">Somatic.sample.qc.Cutadapt.noTrim</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-trim flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.noZeroCap"><a href="#Somatic.sample.qc.Cutadapt.noZeroCap">Somatic.sample.qc.Cutadapt.noZeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-zero-cap flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.overlap"><a href="#Somatic.sample.qc.Cutadapt.overlap">Somatic.sample.qc.Cutadapt.overlap</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --overlap option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.pairFilter"><a href="#Somatic.sample.qc.Cutadapt.pairFilter">Somatic.sample.qc.Cutadapt.pairFilter</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --pair-filter option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.prefix"><a href="#Somatic.sample.qc.Cutadapt.prefix">Somatic.sample.qc.Cutadapt.prefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --prefix option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.qualityBase"><a href="#Somatic.sample.qc.Cutadapt.qualityBase">Somatic.sample.qc.Cutadapt.qualityBase</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --quality-base option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.qualityCutoff"><a href="#Somatic.sample.qc.Cutadapt.qualityCutoff">Somatic.sample.qc.Cutadapt.qualityCutoff</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.restFilePath"><a href="#Somatic.sample.qc.Cutadapt.restFilePath">Somatic.sample.qc.Cutadapt.restFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --rest-file option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.stripF3"><a href="#Somatic.sample.qc.Cutadapt.stripF3">Somatic.sample.qc.Cutadapt.stripF3</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --strip-f3 flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.stripSuffix"><a href="#Somatic.sample.qc.Cutadapt.stripSuffix">Somatic.sample.qc.Cutadapt.stripSuffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --strip-suffix option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.suffix"><a href="#Somatic.sample.qc.Cutadapt.suffix">Somatic.sample.qc.Cutadapt.suffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --suffix option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.times"><a href="#Somatic.sample.qc.Cutadapt.times">Somatic.sample.qc.Cutadapt.times</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --times option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.tooLongOutputPath"><a href="#Somatic.sample.qc.Cutadapt.tooLongOutputPath">Somatic.sample.qc.Cutadapt.tooLongOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-output option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.tooLongPairedOutputPath"><a href="#Somatic.sample.qc.Cutadapt.tooLongPairedOutputPath">Somatic.sample.qc.Cutadapt.tooLongPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-paired-output option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.tooShortOutputPath"><a href="#Somatic.sample.qc.Cutadapt.tooShortOutputPath">Somatic.sample.qc.Cutadapt.tooShortOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-output option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.tooShortPairedOutputPath"><a href="#Somatic.sample.qc.Cutadapt.tooShortPairedOutputPath">Somatic.sample.qc.Cutadapt.tooShortPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-paired-output option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.trimN"><a href="#Somatic.sample.qc.Cutadapt.trimN">Somatic.sample.qc.Cutadapt.trimN</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --trim-n flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.untrimmedOutputPath"><a href="#Somatic.sample.qc.Cutadapt.untrimmedOutputPath">Somatic.sample.qc.Cutadapt.untrimmedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-output option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.untrimmedPairedOutputPath"><a href="#Somatic.sample.qc.Cutadapt.untrimmedPairedOutputPath">Somatic.sample.qc.Cutadapt.untrimmedPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-paired-output option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.wildcardFilePath"><a href="#Somatic.sample.qc.Cutadapt.wildcardFilePath">Somatic.sample.qc.Cutadapt.wildcardFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --wildcard-file option.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.Z"><a href="#Somatic.sample.qc.Cutadapt.Z">Somatic.sample.qc.Cutadapt.Z</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to cutadapt's -Z flag.
</dd>
<dt id="Somatic.sample.qc.Cutadapt.zeroCap"><a href="#Somatic.sample.qc.Cutadapt.zeroCap">Somatic.sample.qc.Cutadapt.zeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --zero-cap flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.adapters"><a href="#Somatic.sample.qc.FastqcRead1.adapters">Somatic.sample.qc.FastqcRead1.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.casava"><a href="#Somatic.sample.qc.FastqcRead1.casava">Somatic.sample.qc.FastqcRead1.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.contaminants"><a href="#Somatic.sample.qc.FastqcRead1.contaminants">Somatic.sample.qc.FastqcRead1.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.dir"><a href="#Somatic.sample.qc.FastqcRead1.dir">Somatic.sample.qc.FastqcRead1.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.extract"><a href="#Somatic.sample.qc.FastqcRead1.extract">Somatic.sample.qc.FastqcRead1.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.format"><a href="#Somatic.sample.qc.FastqcRead1.format">Somatic.sample.qc.FastqcRead1.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.kmers"><a href="#Somatic.sample.qc.FastqcRead1.kmers">Somatic.sample.qc.FastqcRead1.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.limits"><a href="#Somatic.sample.qc.FastqcRead1.limits">Somatic.sample.qc.FastqcRead1.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.minLength"><a href="#Somatic.sample.qc.FastqcRead1.minLength">Somatic.sample.qc.FastqcRead1.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.nano"><a href="#Somatic.sample.qc.FastqcRead1.nano">Somatic.sample.qc.FastqcRead1.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.noFilter"><a href="#Somatic.sample.qc.FastqcRead1.noFilter">Somatic.sample.qc.FastqcRead1.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.nogroup"><a href="#Somatic.sample.qc.FastqcRead1.nogroup">Somatic.sample.qc.FastqcRead1.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1.threads"><a href="#Somatic.sample.qc.FastqcRead1.threads">Somatic.sample.qc.FastqcRead1.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.adapters"><a href="#Somatic.sample.qc.FastqcRead1After.adapters">Somatic.sample.qc.FastqcRead1After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.casava"><a href="#Somatic.sample.qc.FastqcRead1After.casava">Somatic.sample.qc.FastqcRead1After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.contaminants"><a href="#Somatic.sample.qc.FastqcRead1After.contaminants">Somatic.sample.qc.FastqcRead1After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.dir"><a href="#Somatic.sample.qc.FastqcRead1After.dir">Somatic.sample.qc.FastqcRead1After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.extract"><a href="#Somatic.sample.qc.FastqcRead1After.extract">Somatic.sample.qc.FastqcRead1After.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.format"><a href="#Somatic.sample.qc.FastqcRead1After.format">Somatic.sample.qc.FastqcRead1After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.kmers"><a href="#Somatic.sample.qc.FastqcRead1After.kmers">Somatic.sample.qc.FastqcRead1After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.limits"><a href="#Somatic.sample.qc.FastqcRead1After.limits">Somatic.sample.qc.FastqcRead1After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.minLength"><a href="#Somatic.sample.qc.FastqcRead1After.minLength">Somatic.sample.qc.FastqcRead1After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.nano"><a href="#Somatic.sample.qc.FastqcRead1After.nano">Somatic.sample.qc.FastqcRead1After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.noFilter"><a href="#Somatic.sample.qc.FastqcRead1After.noFilter">Somatic.sample.qc.FastqcRead1After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.nogroup"><a href="#Somatic.sample.qc.FastqcRead1After.nogroup">Somatic.sample.qc.FastqcRead1After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead1After.threads"><a href="#Somatic.sample.qc.FastqcRead1After.threads">Somatic.sample.qc.FastqcRead1After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.adapters"><a href="#Somatic.sample.qc.FastqcRead2.adapters">Somatic.sample.qc.FastqcRead2.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.casava"><a href="#Somatic.sample.qc.FastqcRead2.casava">Somatic.sample.qc.FastqcRead2.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.contaminants"><a href="#Somatic.sample.qc.FastqcRead2.contaminants">Somatic.sample.qc.FastqcRead2.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.dir"><a href="#Somatic.sample.qc.FastqcRead2.dir">Somatic.sample.qc.FastqcRead2.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.extract"><a href="#Somatic.sample.qc.FastqcRead2.extract">Somatic.sample.qc.FastqcRead2.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.format"><a href="#Somatic.sample.qc.FastqcRead2.format">Somatic.sample.qc.FastqcRead2.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.kmers"><a href="#Somatic.sample.qc.FastqcRead2.kmers">Somatic.sample.qc.FastqcRead2.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.limits"><a href="#Somatic.sample.qc.FastqcRead2.limits">Somatic.sample.qc.FastqcRead2.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.minLength"><a href="#Somatic.sample.qc.FastqcRead2.minLength">Somatic.sample.qc.FastqcRead2.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.nano"><a href="#Somatic.sample.qc.FastqcRead2.nano">Somatic.sample.qc.FastqcRead2.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.noFilter"><a href="#Somatic.sample.qc.FastqcRead2.noFilter">Somatic.sample.qc.FastqcRead2.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.nogroup"><a href="#Somatic.sample.qc.FastqcRead2.nogroup">Somatic.sample.qc.FastqcRead2.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2.threads"><a href="#Somatic.sample.qc.FastqcRead2.threads">Somatic.sample.qc.FastqcRead2.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.adapters"><a href="#Somatic.sample.qc.FastqcRead2After.adapters">Somatic.sample.qc.FastqcRead2After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.casava"><a href="#Somatic.sample.qc.FastqcRead2After.casava">Somatic.sample.qc.FastqcRead2After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.contaminants"><a href="#Somatic.sample.qc.FastqcRead2After.contaminants">Somatic.sample.qc.FastqcRead2After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.dir"><a href="#Somatic.sample.qc.FastqcRead2After.dir">Somatic.sample.qc.FastqcRead2After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.extract"><a href="#Somatic.sample.qc.FastqcRead2After.extract">Somatic.sample.qc.FastqcRead2After.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.format"><a href="#Somatic.sample.qc.FastqcRead2After.format">Somatic.sample.qc.FastqcRead2After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.kmers"><a href="#Somatic.sample.qc.FastqcRead2After.kmers">Somatic.sample.qc.FastqcRead2After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.limits"><a href="#Somatic.sample.qc.FastqcRead2After.limits">Somatic.sample.qc.FastqcRead2After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.minLength"><a href="#Somatic.sample.qc.FastqcRead2After.minLength">Somatic.sample.qc.FastqcRead2After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.nano"><a href="#Somatic.sample.qc.FastqcRead2After.nano">Somatic.sample.qc.FastqcRead2After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.noFilter"><a href="#Somatic.sample.qc.FastqcRead2After.noFilter">Somatic.sample.qc.FastqcRead2After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.nogroup"><a href="#Somatic.sample.qc.FastqcRead2After.nogroup">Somatic.sample.qc.FastqcRead2After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Somatic.sample.qc.FastqcRead2After.threads"><a href="#Somatic.sample.qc.FastqcRead2After.threads">Somatic.sample.qc.FastqcRead2After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.sample.qc.runAdapterClipping"><a href="#Somatic.sample.qc.runAdapterClipping">Somatic.sample.qc.runAdapterClipping</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>defined(adapterForward) || defined(adapterReverse) || length(select_first([contaminations, []])) > 0</code><br />
    Whether or not adapters should be removed from the reads.
</dd>
<dt id="Somatic.sample.useBwaKit"><a href="#Somatic.sample.useBwaKit">Somatic.sample.useBwaKit</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not BWA kit should be used. If false BWA mem will be used.
</dd>
<dt id="Somatic.somaticVariantcalling.combineVariants.dockerImage"><a href="#Somatic.somaticVariantcalling.combineVariants.dockerImage">Somatic.somaticVariantcalling.combineVariants.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"broadinstitute/gatk3:3.8-1"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Somatic.somaticVariantcalling.combineVariants.filteredRecordsMergeType"><a href="#Somatic.somaticVariantcalling.combineVariants.filteredRecordsMergeType">Somatic.somaticVariantcalling.combineVariants.filteredRecordsMergeType</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"KEEP_IF_ANY_UNFILTERED"</code><br />
    Equivalent to CombineVariants' `--filteredrecordsmergetype` option.
</dd>
<dt id="Somatic.somaticVariantcalling.combineVariants.genotypeMergeOption"><a href="#Somatic.somaticVariantcalling.combineVariants.genotypeMergeOption">Somatic.somaticVariantcalling.combineVariants.genotypeMergeOption</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"UNIQUIFY"</code><br />
    Equivalent to CombineVariants' `--genotypemergeoption` option.
</dd>
<dt id="Somatic.somaticVariantcalling.combineVariants.javaXmx"><a href="#Somatic.somaticVariantcalling.combineVariants.javaXmx">Somatic.somaticVariantcalling.combineVariants.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.combineVariants.memory"><a href="#Somatic.somaticVariantcalling.combineVariants.memory">Somatic.somaticVariantcalling.combineVariants.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.calculateContamination.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.calculateContamination.javaXmx">Somatic.somaticVariantcalling.mutect2.calculateContamination.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.calculateContamination.memory"><a href="#Somatic.somaticVariantcalling.mutect2.calculateContamination.memory">Somatic.somaticVariantcalling.mutect2.calculateContamination.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.filterMutectCalls.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.filterMutectCalls.javaXmx">Somatic.somaticVariantcalling.mutect2.filterMutectCalls.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.filterMutectCalls.memory"><a href="#Somatic.somaticVariantcalling.mutect2.filterMutectCalls.memory">Somatic.somaticVariantcalling.mutect2.filterMutectCalls.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.filterMutectCalls.uniqueAltReadCount"><a href="#Somatic.somaticVariantcalling.mutect2.filterMutectCalls.uniqueAltReadCount">Somatic.somaticVariantcalling.mutect2.filterMutectCalls.uniqueAltReadCount</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    Equivalent to FilterMutectCalls' `--unique-alt-read-count` option.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.gatherVcfs.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.gatherVcfs.javaXmx">Somatic.somaticVariantcalling.mutect2.gatherVcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.gatherVcfs.memory"><a href="#Somatic.somaticVariantcalling.mutect2.gatherVcfs.memory">Somatic.somaticVariantcalling.mutect2.gatherVcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.getPileupSummariesNormal.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.getPileupSummariesNormal.javaXmx">Somatic.somaticVariantcalling.mutect2.getPileupSummariesNormal.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.getPileupSummariesNormal.memory"><a href="#Somatic.somaticVariantcalling.mutect2.getPileupSummariesNormal.memory">Somatic.somaticVariantcalling.mutect2.getPileupSummariesNormal.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.getPileupSummariesTumor.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.getPileupSummariesTumor.javaXmx">Somatic.somaticVariantcalling.mutect2.getPileupSummariesTumor.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.getPileupSummariesTumor.memory"><a href="#Somatic.somaticVariantcalling.mutect2.getPileupSummariesTumor.memory">Somatic.somaticVariantcalling.mutect2.getPileupSummariesTumor.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.learnReadOrientationModel.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.learnReadOrientationModel.javaXmx">Somatic.somaticVariantcalling.mutect2.learnReadOrientationModel.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.learnReadOrientationModel.memory"><a href="#Somatic.somaticVariantcalling.mutect2.learnReadOrientationModel.memory">Somatic.somaticVariantcalling.mutect2.learnReadOrientationModel.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mergeStats.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.mergeStats.javaXmx">Somatic.somaticVariantcalling.mutect2.mergeStats.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"14G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mergeStats.memory"><a href="#Somatic.somaticVariantcalling.mutect2.mergeStats.memory">Somatic.somaticVariantcalling.mutect2.mergeStats.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"28G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.f1r2TarGz"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.f1r2TarGz">Somatic.somaticVariantcalling.mutect2.mutect2.f1r2TarGz</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"f1r2.tar.gz"</code><br />
    Equivalent to Mutect2's `--f1r2-tar-gz` option.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.germlineResource"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.germlineResource">Somatic.somaticVariantcalling.mutect2.mutect2.germlineResource</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to Mutect2's `--germline-resource` option.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.germlineResourceIndex"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.germlineResourceIndex">Somatic.somaticVariantcalling.mutect2.mutect2.germlineResourceIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the germline resource.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.javaXmx">Somatic.somaticVariantcalling.mutect2.mutect2.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.memory"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.memory">Somatic.somaticVariantcalling.mutect2.mutect2.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"16G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.outputStats"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.outputStats">Somatic.somaticVariantcalling.mutect2.mutect2.outputStats</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>outputVcf + ".stats"</code><br />
    The location the output statistics should be written to.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.panelOfNormals"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.panelOfNormals">Somatic.somaticVariantcalling.mutect2.mutect2.panelOfNormals</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to Mutect2's `--panel-of-normals` option.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.mutect2.panelOfNormalsIndex"><a href="#Somatic.somaticVariantcalling.mutect2.mutect2.panelOfNormalsIndex">Somatic.somaticVariantcalling.mutect2.mutect2.panelOfNormalsIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the panel of normals.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.scatterList.bamFile"><a href="#Somatic.somaticVariantcalling.mutect2.scatterList.bamFile">Somatic.somaticVariantcalling.mutect2.scatterList.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.scatterList.bamIndex"><a href="#Somatic.somaticVariantcalling.mutect2.scatterList.bamIndex">Somatic.somaticVariantcalling.mutect2.scatterList.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.scatterList.javaXmx"><a href="#Somatic.somaticVariantcalling.mutect2.scatterList.javaXmx">Somatic.somaticVariantcalling.mutect2.scatterList.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.scatterList.memory"><a href="#Somatic.somaticVariantcalling.mutect2.scatterList.memory">Somatic.somaticVariantcalling.mutect2.scatterList.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.mutect2.scatterSize"><a href="#Somatic.somaticVariantcalling.mutect2.scatterSize">Somatic.somaticVariantcalling.mutect2.scatterSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000000000</code><br />
    The size of the scattered regions in bases. Scattering is used to speed up certain processes. The genome will be sseperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.jsmVCF"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.jsmVCF">Somatic.somaticVariantcalling.pairedSomaticSeq.jsmVCF</a></dt>
<dd>
    <i>File? </i><br />
    A VCF as produced by jsm.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.lofreqIndel"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.lofreqIndel">Somatic.somaticVariantcalling.pairedSomaticSeq.lofreqIndel</a></dt>
<dd>
    <i>File? </i><br />
    An indel VCF as produced by lofreq.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.lofreqSNV"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.lofreqSNV">Somatic.somaticVariantcalling.pairedSomaticSeq.lofreqSNV</a></dt>
<dd>
    <i>File? </i><br />
    An SNV VCF as produced by lofreq.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.museVCF"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.museVCF">Somatic.somaticVariantcalling.pairedSomaticSeq.museVCF</a></dt>
<dd>
    <i>File? </i><br />
    A VCF as produced by muse.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.scalpelVCF"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.scalpelVCF">Somatic.somaticVariantcalling.pairedSomaticSeq.scalpelVCF</a></dt>
<dd>
    <i>File? </i><br />
    A VCF as produced by scalpel.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.somaticsniperVCF"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.somaticsniperVCF">Somatic.somaticVariantcalling.pairedSomaticSeq.somaticsniperVCF</a></dt>
<dd>
    <i>File? </i><br />
    A VCF as produced by somaticsniper.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.threads"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.threads">Somatic.somaticVariantcalling.pairedSomaticSeq.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.varscanIndel"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.varscanIndel">Somatic.somaticVariantcalling.pairedSomaticSeq.varscanIndel</a></dt>
<dd>
    <i>File? </i><br />
    An indel VCF as produced by varscan.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedSomaticSeq.varscanSNV"><a href="#Somatic.somaticVariantcalling.pairedSomaticSeq.varscanSNV">Somatic.somaticVariantcalling.pairedSomaticSeq.varscanSNV</a></dt>
<dd>
    <i>File? </i><br />
    An SNV VCF as produced by varscan.
</dd>
<dt id="Somatic.somaticVariantcalling.pairedTraining.threads"><a href="#Somatic.somaticVariantcalling.pairedTraining.threads">Somatic.somaticVariantcalling.pairedTraining.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.somaticVariantcalling.runCombineVariants"><a href="#Somatic.somaticVariantcalling.runCombineVariants">Somatic.somaticVariantcalling.runCombineVariants</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not to combine the variant calling results into one VCF file.
</dd>
<dt id="Somatic.somaticVariantcalling.singleSomaticSeq.lofreqVCF"><a href="#Somatic.somaticVariantcalling.singleSomaticSeq.lofreqVCF">Somatic.somaticVariantcalling.singleSomaticSeq.lofreqVCF</a></dt>
<dd>
    <i>File? </i><br />
    A VCF as produced by lofreq.
</dd>
<dt id="Somatic.somaticVariantcalling.singleSomaticSeq.scalpelVCF"><a href="#Somatic.somaticVariantcalling.singleSomaticSeq.scalpelVCF">Somatic.somaticVariantcalling.singleSomaticSeq.scalpelVCF</a></dt>
<dd>
    <i>File? </i><br />
    A VCF as produced by scalpel.
</dd>
<dt id="Somatic.somaticVariantcalling.singleSomaticSeq.threads"><a href="#Somatic.somaticVariantcalling.singleSomaticSeq.threads">Somatic.somaticVariantcalling.singleSomaticSeq.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.somaticVariantcalling.singleSomaticSeq.varscanVCF"><a href="#Somatic.somaticVariantcalling.singleSomaticSeq.varscanVCF">Somatic.somaticVariantcalling.singleSomaticSeq.varscanVCF</a></dt>
<dd>
    <i>File? </i><br />
    A VCF as produced by varscan.
</dd>
<dt id="Somatic.somaticVariantcalling.singleTraining.threads"><a href="#Somatic.somaticVariantcalling.singleTraining.threads">Somatic.somaticVariantcalling.singleTraining.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.somaticVariantcalling.sitesForContamination"><a href="#Somatic.somaticVariantcalling.sitesForContamination">Somatic.somaticVariantcalling.sitesForContamination</a></dt>
<dd>
    <i>File? </i><br />
    A bed file, vcf file or interval list with regions for GetPileupSummaries to operate on.
</dd>
<dt id="Somatic.somaticVariantcalling.sitesForContaminationIndex"><a href="#Somatic.somaticVariantcalling.sitesForContaminationIndex">Somatic.somaticVariantcalling.sitesForContaminationIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the vcf file provided to sitesForContamination.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.addGTFieldIndels.outputVCFName"><a href="#Somatic.somaticVariantcalling.strelka.addGTFieldIndels.outputVCFName">Somatic.somaticVariantcalling.strelka.addGTFieldIndels.outputVCFName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>basename(strelkaVCF,".gz")</code><br />
    The location the output VCF file should be written to.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.addGTFieldSVs.outputVCFName"><a href="#Somatic.somaticVariantcalling.strelka.addGTFieldSVs.outputVCFName">Somatic.somaticVariantcalling.strelka.addGTFieldSVs.outputVCFName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>basename(strelkaVCF,".gz")</code><br />
    The location the output VCF file should be written to.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.addGTFieldVariants.outputVCFName"><a href="#Somatic.somaticVariantcalling.strelka.addGTFieldVariants.outputVCFName">Somatic.somaticVariantcalling.strelka.addGTFieldVariants.outputVCFName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>basename(strelkaVCF,".gz")</code><br />
    The location the output VCF file should be written to.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.combineVariants.dockerImage"><a href="#Somatic.somaticVariantcalling.strelka.combineVariants.dockerImage">Somatic.somaticVariantcalling.strelka.combineVariants.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"broadinstitute/gatk3:3.8-1"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.combineVariants.filteredRecordsMergeType"><a href="#Somatic.somaticVariantcalling.strelka.combineVariants.filteredRecordsMergeType">Somatic.somaticVariantcalling.strelka.combineVariants.filteredRecordsMergeType</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"KEEP_IF_ANY_UNFILTERED"</code><br />
    Equivalent to CombineVariants' `--filteredrecordsmergetype` option.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.combineVariants.genotypeMergeOption"><a href="#Somatic.somaticVariantcalling.strelka.combineVariants.genotypeMergeOption">Somatic.somaticVariantcalling.strelka.combineVariants.genotypeMergeOption</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"UNIQUIFY"</code><br />
    Equivalent to CombineVariants' `--genotypemergeoption` option.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.combineVariants.javaXmx"><a href="#Somatic.somaticVariantcalling.strelka.combineVariants.javaXmx">Somatic.somaticVariantcalling.strelka.combineVariants.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.combineVariants.memory"><a href="#Somatic.somaticVariantcalling.strelka.combineVariants.memory">Somatic.somaticVariantcalling.strelka.combineVariants.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.gatherIndels.javaXmx"><a href="#Somatic.somaticVariantcalling.strelka.gatherIndels.javaXmx">Somatic.somaticVariantcalling.strelka.gatherIndels.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.gatherIndels.memory"><a href="#Somatic.somaticVariantcalling.strelka.gatherIndels.memory">Somatic.somaticVariantcalling.strelka.gatherIndels.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.gatherSVs.javaXmx"><a href="#Somatic.somaticVariantcalling.strelka.gatherSVs.javaXmx">Somatic.somaticVariantcalling.strelka.gatherSVs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.gatherSVs.memory"><a href="#Somatic.somaticVariantcalling.strelka.gatherSVs.memory">Somatic.somaticVariantcalling.strelka.gatherSVs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.gatherVariants.javaXmx"><a href="#Somatic.somaticVariantcalling.strelka.gatherVariants.javaXmx">Somatic.somaticVariantcalling.strelka.gatherVariants.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.gatherVariants.memory"><a href="#Somatic.somaticVariantcalling.strelka.gatherVariants.memory">Somatic.somaticVariantcalling.strelka.gatherVariants.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.mantaSomatic.cores"><a href="#Somatic.somaticVariantcalling.strelka.mantaSomatic.cores">Somatic.somaticVariantcalling.strelka.mantaSomatic.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.mantaSomatic.memoryGb"><a href="#Somatic.somaticVariantcalling.strelka.mantaSomatic.memoryGb">Somatic.somaticVariantcalling.strelka.mantaSomatic.memoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The amount of memory this job will use in Gigabytes.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.scatterList.bamFile"><a href="#Somatic.somaticVariantcalling.strelka.scatterList.bamFile">Somatic.somaticVariantcalling.strelka.scatterList.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.scatterList.bamIndex"><a href="#Somatic.somaticVariantcalling.strelka.scatterList.bamIndex">Somatic.somaticVariantcalling.strelka.scatterList.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.scatterList.javaXmx"><a href="#Somatic.somaticVariantcalling.strelka.scatterList.javaXmx">Somatic.somaticVariantcalling.strelka.scatterList.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.scatterList.memory"><a href="#Somatic.somaticVariantcalling.strelka.scatterList.memory">Somatic.somaticVariantcalling.strelka.scatterList.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.scatterSize"><a href="#Somatic.somaticVariantcalling.strelka.scatterSize">Somatic.somaticVariantcalling.strelka.scatterSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000000000</code><br />
    The size of the scattered regions in bases. Scattering is used to speed up certain processes. The genome will be sseperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.strelkaGermline.cores"><a href="#Somatic.somaticVariantcalling.strelka.strelkaGermline.cores">Somatic.somaticVariantcalling.strelka.strelkaGermline.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.strelkaGermline.memoryGb"><a href="#Somatic.somaticVariantcalling.strelka.strelkaGermline.memoryGb">Somatic.somaticVariantcalling.strelka.strelkaGermline.memoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The amount of memory this job will use in Gigabytes.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.strelkaSomatic.cores"><a href="#Somatic.somaticVariantcalling.strelka.strelkaSomatic.cores">Somatic.somaticVariantcalling.strelka.strelkaSomatic.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Somatic.somaticVariantcalling.strelka.strelkaSomatic.memoryGb"><a href="#Somatic.somaticVariantcalling.strelka.strelkaSomatic.memoryGb">Somatic.somaticVariantcalling.strelka.strelkaSomatic.memoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The amount of memory this job will use in Gigabytes.
</dd>
<dt id="Somatic.somaticVariantcalling.trainingSet"><a href="#Somatic.somaticVariantcalling.trainingSet">Somatic.somaticVariantcalling.trainingSet</a></dt>
<dd>
    <i>struct(jsmVCF : File?, lofreqIndel : File?, lofreqSNV : File?, museVCF : File?, mutect2VCF : File?, normalBam : File?, normalBamIndex : File?, scalpelVCF : File?, somaticsniperVCF : File?, strelkaIndel : File?, strelkaSNV : File?, truthIndel : File, truthSNV : File, tumorBam : File, tumorBamIndex : File, vardictVCF : File?, varscanIndel : File?, varscanSNV : File?)? </i><br />
    VCF files used to train somaticseq.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryAlignments"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryAlignments">Somatic.somaticVariantcalling.vardict.filterSupplementaryAlignments</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not supplementary reads should be filtered before vardict is run.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.excludeSpecificFilter"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.excludeSpecificFilter">Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.excludeSpecificFilter</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to samtools view's `-G` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.includeFilter"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.includeFilter">Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.includeFilter</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to samtools view's `-f` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.MAPQthreshold"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.MAPQthreshold">Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.MAPQthreshold</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to samtools view's `-q` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.memory"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.memory">Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.referenceFasta"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.referenceFasta">Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.referenceFasta</a></dt>
<dd>
    <i>File? </i><br />
    The reference fasta file also used for mapping.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.threads"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.threads">Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.uncompressedBamOutput"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.uncompressedBamOutput">Somatic.somaticVariantcalling.vardict.filterSupplementaryControl.uncompressedBamOutput</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to samtools view's `-u` flag.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.excludeSpecificFilter"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.excludeSpecificFilter">Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.excludeSpecificFilter</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to samtools view's `-G` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.includeFilter"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.includeFilter">Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.includeFilter</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to samtools view's `-f` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.MAPQthreshold"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.MAPQthreshold">Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.MAPQthreshold</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to samtools view's `-q` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.memory"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.memory">Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.referenceFasta"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.referenceFasta">Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.referenceFasta</a></dt>
<dd>
    <i>File? </i><br />
    The reference fasta file also used for mapping.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.threads"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.threads">Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.uncompressedBamOutput"><a href="#Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.uncompressedBamOutput">Somatic.somaticVariantcalling.vardict.filterSupplementaryTumor.uncompressedBamOutput</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to samtools view's `-u` flag.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.gatherVcfs.javaXmx"><a href="#Somatic.somaticVariantcalling.vardict.gatherVcfs.javaXmx">Somatic.somaticVariantcalling.vardict.gatherVcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.gatherVcfs.memory"><a href="#Somatic.somaticVariantcalling.vardict.gatherVcfs.memory">Somatic.somaticVariantcalling.vardict.gatherVcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.scatterList.chunkSize"><a href="#Somatic.somaticVariantcalling.vardict.scatterList.chunkSize">Somatic.somaticVariantcalling.vardict.scatterList.chunkSize</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to chunked-scatter's `-c` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.scatterList.dockerImage"><a href="#Somatic.somaticVariantcalling.vardict.scatterList.dockerImage">Somatic.somaticVariantcalling.vardict.scatterList.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/chunked-scatter:0.1.0--py_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.scatterList.minimumBasesPerFile"><a href="#Somatic.somaticVariantcalling.vardict.scatterList.minimumBasesPerFile">Somatic.somaticVariantcalling.vardict.scatterList.minimumBasesPerFile</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to chunked-scatter's `-m` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.scatterList.overlap"><a href="#Somatic.somaticVariantcalling.vardict.scatterList.overlap">Somatic.somaticVariantcalling.vardict.scatterList.overlap</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to chunked-scatter's `-o` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.scatterList.prefix"><a href="#Somatic.somaticVariantcalling.vardict.scatterList.prefix">Somatic.somaticVariantcalling.vardict.scatterList.prefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"./scatter"</code><br />
    The prefix for the output files.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.chromosomeColumn"><a href="#Somatic.somaticVariantcalling.vardict.varDict.chromosomeColumn">Somatic.somaticVariantcalling.vardict.varDict.chromosomeColumn</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    Equivalent to vardict-java's `-c` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.endColumn"><a href="#Somatic.somaticVariantcalling.vardict.varDict.endColumn">Somatic.somaticVariantcalling.vardict.varDict.endColumn</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>3</code><br />
    Equivalent to vardict-java's `-E` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.geneColumn"><a href="#Somatic.somaticVariantcalling.vardict.varDict.geneColumn">Somatic.somaticVariantcalling.vardict.varDict.geneColumn</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    Equivalent to vardict-java's `-g` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.javaXmx"><a href="#Somatic.somaticVariantcalling.vardict.varDict.javaXmx">Somatic.somaticVariantcalling.vardict.varDict.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"16G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.mappingQuality"><a href="#Somatic.somaticVariantcalling.vardict.varDict.mappingQuality">Somatic.somaticVariantcalling.vardict.varDict.mappingQuality</a></dt>
<dd>
    <i>Float </i><i>&mdash; Default:</i> <code>20</code><br />
    Equivalent to var2vcf_paired.pl or var2vcf_valid.pl's `-Q` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.memory"><a href="#Somatic.somaticVariantcalling.vardict.varDict.memory">Somatic.somaticVariantcalling.vardict.varDict.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"40G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.minimumAlleleFrequency"><a href="#Somatic.somaticVariantcalling.vardict.varDict.minimumAlleleFrequency">Somatic.somaticVariantcalling.vardict.varDict.minimumAlleleFrequency</a></dt>
<dd>
    <i>Float </i><i>&mdash; Default:</i> <code>0.02</code><br />
    Equivalent to var2vcf_paired.pl or var2vcf_valid.pl's `-f` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.minimumTotalDepth"><a href="#Somatic.somaticVariantcalling.vardict.varDict.minimumTotalDepth">Somatic.somaticVariantcalling.vardict.varDict.minimumTotalDepth</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>8</code><br />
    Equivalent to var2vcf_paired.pl or var2vcf_valid.pl's `-d` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.minimumVariantDepth"><a href="#Somatic.somaticVariantcalling.vardict.varDict.minimumVariantDepth">Somatic.somaticVariantcalling.vardict.varDict.minimumVariantDepth</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    Equivalent to var2vcf_paired.pl or var2vcf_valid.pl's `-v` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.outputAllVariantsAtSamePosition"><a href="#Somatic.somaticVariantcalling.vardict.varDict.outputAllVariantsAtSamePosition">Somatic.somaticVariantcalling.vardict.varDict.outputAllVariantsAtSamePosition</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to var2vcf_paired.pl or var2vcf_valid.pl's `-A` flag.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.outputCandidateSomaticOnly"><a href="#Somatic.somaticVariantcalling.vardict.varDict.outputCandidateSomaticOnly">Somatic.somaticVariantcalling.vardict.varDict.outputCandidateSomaticOnly</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to var2vcf_paired.pl or var2vcf_valid.pl's `-M` flag.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.startColumn"><a href="#Somatic.somaticVariantcalling.vardict.varDict.startColumn">Somatic.somaticVariantcalling.vardict.varDict.startColumn</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    Equivalent to vardict-java's `-S` option.
</dd>
<dt id="Somatic.somaticVariantcalling.vardict.varDict.threads"><a href="#Somatic.somaticVariantcalling.vardict.varDict.threads">Somatic.somaticVariantcalling.vardict.varDict.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="Somatic.somaticVariantcalling.variantsForContamination"><a href="#Somatic.somaticVariantcalling.variantsForContamination">Somatic.somaticVariantcalling.variantsForContamination</a></dt>
<dd>
    <i>File? </i><br />
    A VCF file with common variants.
</dd>
<dt id="Somatic.somaticVariantcalling.variantsForContaminationIndex"><a href="#Somatic.somaticVariantcalling.variantsForContaminationIndex">Somatic.somaticVariantcalling.variantsForContaminationIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index of the common variants VCF file.
</dd>
</dl>
</details>





## Do not set these inputs!
The following inputs should ***not*** be set, even though womtool may
show them as being available inputs.

* Somatic.sample.qc.FastqcRead1.NoneFile
* Somatic.sample.qc.FastqcRead1.NoneArray
* Somatic.sample.qc.FastqcRead2.NoneFile
* Somatic.sample.qc.FastqcRead2.NoneArray
* Somatic.sample.qc.FastqcRead1After.NoneFile
* Somatic.sample.qc.FastqcRead1After.NoneArray
* Somatic.sample.qc.FastqcRead2After.NoneFile
* Somatic.sample.qc.FastqcRead2After.NoneArray
* Somatic.somaticVariantcalling.DONOTDEFINETHIS
* Somatic.somaticVariantcalling.indelIndex.type
* Somatic.somaticVariantcalling.snvIndex.type
* Somatic.somaticVariantcalling.strelka.indelsIndex.type
* Somatic.somaticVariantcalling.strelka.svsIndex.type
* Somatic.somaticVariantcalling.strelka.variantsIndex.type
* Somatic.somaticVariantcalling.strelka.strelkaSomatic.doNotDefineThis
* Somatic.multiqcTask.finished
* Somatic.multiqcTask.dependencies