---
layout: default
title: "Inputs: Germline"
---

# Inputs for Germline

The following is an overview of all available inputs in
Germline.


## Required inputs
<dl>
<dt id="Germline.dbsnpVCF"><a href="#Germline.dbsnpVCF">Germline.dbsnpVCF</a></dt>
<dd>
    <i>File </i><br />
    dbsnp VCF file used for checking known sites.
</dd>
<dt id="Germline.dockerImagesFile"><a href="#Germline.dockerImagesFile">Germline.dockerImagesFile</a></dt>
<dd>
    <i>File </i><br />
    A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.
</dd>
<dt id="Germline.referenceFasta"><a href="#Germline.referenceFasta">Germline.referenceFasta</a></dt>
<dd>
    <i>File </i><br />
    The reference fasta file.
</dd>
<dt id="Germline.sampleConfigFile"><a href="#Germline.sampleConfigFile">Germline.sampleConfigFile</a></dt>
<dd>
    <i>File </i><br />
    The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.outputPathMetrics"><a href="#Germline.sampleWorkflow.umiDedup.outputPathMetrics">Germline.sampleWorkflow.umiDedup.outputPathMetrics</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>outputPath + ".metrics"</code><br />
    The location the output metrics file should be written to.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.outputPathUmiMetrics"><a href="#Germline.sampleWorkflow.umiDedup.outputPathUmiMetrics">Germline.sampleWorkflow.umiDedup.outputPathUmiMetrics</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>outputPath + ".umi-metrics"</code><br />
    The location the output UMI metrics file should be written to.
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
    <i>String? </i><br />
    The adapter to be removed from the reads first or single end reads.
</dd>
<dt id="Germline.adapterReverse"><a href="#Germline.adapterReverse">Germline.adapterReverse</a></dt>
<dd>
    <i>String? </i><br />
    The adapter to be removed from the reads second end reads.
</dd>
<dt id="Germline.bwaIndex"><a href="#Germline.bwaIndex">Germline.bwaIndex</a></dt>
<dd>
    <i>BwaIndex? </i><br />
    The BWA index files. When these are provided BWA will be used. Will be created automatically if both bwaIndex and bwaMem2Index are not present.
</dd>
<dt id="Germline.bwaMem2Index"><a href="#Germline.bwaMem2Index">Germline.bwaMem2Index</a></dt>
<dd>
    <i>BwaIndex? </i><br />
    The bwa-mem2 index files. When these are provided bwa-mem2 will be used.
</dd>
<dt id="Germline.dbsnpVCFIndex"><a href="#Germline.dbsnpVCFIndex">Germline.dbsnpVCFIndex</a></dt>
<dd>
    <i>File? </i><br />
    Index (.tbi) file for the dbsnp VCF. Will be created automatically if not present.
</dd>
<dt id="Germline.jointgenotyping"><a href="#Germline.jointgenotyping">Germline.jointgenotyping</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether to perform jointgenotyping (using HaplotypeCaller to call GVCFs and merge them with GenotypeGVCFs) or not.
</dd>
<dt id="Germline.JointGenotyping.genotypeGvcfs.pedigree"><a href="#Germline.JointGenotyping.genotypeGvcfs.pedigree">Germline.JointGenotyping.genotypeGvcfs.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders".
</dd>
<dt id="Germline.JointGenotyping.Stats.compareVcf"><a href="#Germline.JointGenotyping.Stats.compareVcf">Germline.JointGenotyping.Stats.compareVcf</a></dt>
<dd>
    <i>File? </i><br />
    When inputVcf and compareVCF are given, the program generates separate stats for intersection and the complements. By default only sites are compared, samples must be given to include also sample columns.
</dd>
<dt id="Germline.JointGenotyping.Stats.compareVcfIndex"><a href="#Germline.JointGenotyping.Stats.compareVcfIndex">Germline.JointGenotyping.Stats.compareVcfIndex</a></dt>
<dd>
    <i>File? </i><br />
    Index for the compareVcf.
</dd>
<dt id="Germline.outputDir"><a href="#Germline.outputDir">Germline.outputDir</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"."</code><br />
    The directory the output should be written to.
</dd>
<dt id="Germline.referenceFastaDict"><a href="#Germline.referenceFastaDict">Germline.referenceFastaDict</a></dt>
<dd>
    <i>File? </i><br />
    Sequence dictionary (.dict) file of the reference.
</dd>
<dt id="Germline.referenceFastaFai"><a href="#Germline.referenceFastaFai">Germline.referenceFastaFai</a></dt>
<dd>
    <i>File? </i><br />
    Fasta index (.fai) file of the reference. Will be created automatically if not present.
</dd>
<dt id="Germline.regions"><a href="#Germline.regions">Germline.regions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to call variants for.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.splitSplicedReads"><a href="#Germline.sampleWorkflow.bqsr.splitSplicedReads">Germline.sampleWorkflow.bqsr.splitSplicedReads</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not gatk's SplitNCgarReads should be run to split spliced reads. This should be enabled for RNAseq samples.
</dd>
<dt id="Germline.sampleWorkflow.bwaMem.sixtyFour"><a href="#Germline.sampleWorkflow.bwaMem.sixtyFour">Germline.sampleWorkflow.bwaMem.sixtyFour</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the index uses the '.64' suffixes.
</dd>
<dt id="Germline.sampleWorkflow.bwaMem.useSoftclippingForSupplementary"><a href="#Germline.sampleWorkflow.bwaMem.useSoftclippingForSupplementary">Germline.sampleWorkflow.bwaMem.useSoftclippingForSupplementary</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Use soft-clipping for supplementary alignments instead of hard-clipping
</dd>
<dt id="Germline.sampleWorkflow.bwamem2Mem.sixtyFour"><a href="#Germline.sampleWorkflow.bwamem2Mem.sixtyFour">Germline.sampleWorkflow.bwamem2Mem.sixtyFour</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the index uses the '.64' suffixes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.ampliconIntervals"><a href="#Germline.sampleWorkflow.metrics.ampliconIntervals">Germline.sampleWorkflow.metrics.ampliconIntervals</a></dt>
<dd>
    <i>File? </i><br />
    An interval list describinig the coordinates of the amplicons sequenced. This should only be used for targeted sequencing or WES. Required if `ampliconIntervals` is defined.
</dd>
<dt id="Germline.sampleWorkflow.metrics.refRefflat"><a href="#Germline.sampleWorkflow.metrics.refRefflat">Germline.sampleWorkflow.metrics.refRefflat</a></dt>
<dd>
    <i>File? </i><br />
    A refflat file containing gene annotations. If defined RNA sequencing metrics will be collected.
</dd>
<dt id="Germline.sampleWorkflow.metrics.strandedness"><a href="#Germline.sampleWorkflow.metrics.strandedness">Germline.sampleWorkflow.metrics.strandedness</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"None"</code><br />
    The strandedness of the RNA sequencing library preparation. One of "None" (unstranded), "FR" (forward-reverse: first read equal transcript) or "RF" (reverse-forward: second read equals transcript).
</dd>
<dt id="Germline.sampleWorkflow.metrics.targetIntervals"><a href="#Germline.sampleWorkflow.metrics.targetIntervals">Germline.sampleWorkflow.metrics.targetIntervals</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    An interval list describing the coordinates of the targets sequenced. This should only be used for targeted sequencing or WES. If defined targeted PCR metrics will be collected. Requires `ampliconIntervals` to also be defined.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.contaminations"><a href="#Germline.sampleWorkflow.qualityControl.contaminations">Germline.sampleWorkflow.qualityControl.contaminations</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Contaminants/adapters to be removed from the reads.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.readgroupName"><a href="#Germline.sampleWorkflow.qualityControl.readgroupName">Germline.sampleWorkflow.qualityControl.readgroupName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>sub(basename(read1),"(\.fq)?(\.fastq)?(\.gz)?","")</code><br />
    The name of the readgroup.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.assumeSortOrder"><a href="#Germline.sampleWorkflow.umiDedup.assumeSortOrder">Germline.sampleWorkflow.umiDedup.assumeSortOrder</a></dt>
<dd>
    <i>String? </i><br />
    Assume a certain sort order even though the header might say otherwise.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.removeDuplicates"><a href="#Germline.sampleWorkflow.umiDedup.removeDuplicates">Germline.sampleWorkflow.umiDedup.removeDuplicates</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether the duplicate reads should be removed instead of marked.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.umiTagName"><a href="#Germline.sampleWorkflow.umiDedup.umiTagName">Germline.sampleWorkflow.umiDedup.umiTagName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"RX"</code><br />
    Which tag in the BAM file holds the UMI.
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.excludeIntervalList"><a href="#Germline.singleSampleCalling.callAutosomal.excludeIntervalList">Germline.singleSampleCalling.callAutosomal.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.pedigree"><a href="#Germline.singleSampleCalling.callAutosomal.pedigree">Germline.singleSampleCalling.callAutosomal.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders".
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.ploidy"><a href="#Germline.singleSampleCalling.callAutosomal.ploidy">Germline.singleSampleCalling.callAutosomal.ploidy</a></dt>
<dd>
    <i>Int? </i><br />
    The ploidy with which the variants should be called.
</dd>
<dt id="Germline.singleSampleCalling.callX.excludeIntervalList"><a href="#Germline.singleSampleCalling.callX.excludeIntervalList">Germline.singleSampleCalling.callX.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="Germline.singleSampleCalling.callX.pedigree"><a href="#Germline.singleSampleCalling.callX.pedigree">Germline.singleSampleCalling.callX.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders".
</dd>
<dt id="Germline.singleSampleCalling.callY.excludeIntervalList"><a href="#Germline.singleSampleCalling.callY.excludeIntervalList">Germline.singleSampleCalling.callY.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="Germline.singleSampleCalling.callY.pedigree"><a href="#Germline.singleSampleCalling.callY.pedigree">Germline.singleSampleCalling.callY.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders".
</dd>
<dt id="Germline.singleSampleCalling.dontUseSoftClippedBases"><a href="#Germline.singleSampleCalling.dontUseSoftClippedBases">Germline.singleSampleCalling.dontUseSoftClippedBases</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether soft-clipped bases should be excluded from the haplotype caller analysis (should be set to 'true' for RNA).
</dd>
<dt id="Germline.singleSampleCalling.Stats.compareVcf"><a href="#Germline.singleSampleCalling.Stats.compareVcf">Germline.singleSampleCalling.Stats.compareVcf</a></dt>
<dd>
    <i>File? </i><br />
    When inputVcf and compareVCF are given, the program generates separate stats for intersection and the complements. By default only sites are compared, samples must be given to include also sample columns.
</dd>
<dt id="Germline.singleSampleCalling.Stats.compareVcfIndex"><a href="#Germline.singleSampleCalling.Stats.compareVcfIndex">Germline.singleSampleCalling.Stats.compareVcfIndex</a></dt>
<dd>
    <i>File? </i><br />
    Index for the compareVcf.
</dd>
<dt id="Germline.singleSampleGvcf"><a href="#Germline.singleSampleGvcf">Germline.singleSampleGvcf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to output single-sample gvcfs.
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
<dt id="Germline.svCalling.setId.annsFile"><a href="#Germline.svCalling.setId.annsFile">Germline.svCalling.setId.annsFile</a></dt>
<dd>
    <i>File? </i><br />
    Bgzip-compressed and tabix-indexed file with annotations (see man page for details).
</dd>
<dt id="Germline.svCalling.setId.annsFileIndex"><a href="#Germline.svCalling.setId.annsFileIndex">Germline.svCalling.setId.annsFileIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for annsFile.
</dd>
<dt id="Germline.svCalling.setId.inputFileIndex"><a href="#Germline.svCalling.setId.inputFileIndex">Germline.svCalling.setId.inputFileIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the input vcf or bcf.
</dd>
<dt id="Germline.tabix.outputFilePath"><a href="#Germline.tabix.outputFilePath">Germline.tabix.outputFilePath</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>basename(inputFile)</code><br />
    The location where the file should be written to. The index will appear alongside this link to the file.
</dd>
<dt id="Germline.umiDeduplication"><a href="#Germline.umiDeduplication">Germline.umiDeduplication</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not UMI based deduplication should be performed.
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
<dt id="Germline.bwaIndexTask.dockerImage"><a href="#Germline.bwaIndexTask.dockerImage">Germline.bwaIndexTask.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/bwa:0.7.17--hed695b0_7"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.bwaIndexTask.timeMinutes"><a href="#Germline.bwaIndexTask.timeMinutes">Germline.bwaIndexTask.timeMinutes</a></dt>
<dd>
    <i>Int? </i><i>&mdash; Default:</i> <code>5 + ceil((size(fasta,"G") * 5))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.bwaThreads"><a href="#Germline.bwaThreads">Germline.bwaThreads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The amount of threads for the alignment process.
</dd>
<dt id="Germline.calculateRegions.intersectAutosomalRegions.memory"><a href="#Germline.calculateRegions.intersectAutosomalRegions.memory">Germline.calculateRegions.intersectAutosomalRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([regionsA, regionsB],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="Germline.calculateRegions.intersectAutosomalRegions.timeMinutes"><a href="#Germline.calculateRegions.intersectAutosomalRegions.timeMinutes">Germline.calculateRegions.intersectAutosomalRegions.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([regionsA, regionsB],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.calculateRegions.intersectX.memory"><a href="#Germline.calculateRegions.intersectX.memory">Germline.calculateRegions.intersectX.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([regionsA, regionsB],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="Germline.calculateRegions.intersectX.timeMinutes"><a href="#Germline.calculateRegions.intersectX.timeMinutes">Germline.calculateRegions.intersectX.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([regionsA, regionsB],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.calculateRegions.intersectY.memory"><a href="#Germline.calculateRegions.intersectY.memory">Germline.calculateRegions.intersectY.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([regionsA, regionsB],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="Germline.calculateRegions.intersectY.timeMinutes"><a href="#Germline.calculateRegions.intersectY.timeMinutes">Germline.calculateRegions.intersectY.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([regionsA, regionsB],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.calculateRegions.inverseBed.memory"><a href="#Germline.calculateRegions.inverseBed.memory">Germline.calculateRegions.inverseBed.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([inputBed, faidx],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="Germline.calculateRegions.inverseBed.timeMinutes"><a href="#Germline.calculateRegions.inverseBed.timeMinutes">Germline.calculateRegions.inverseBed.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([inputBed, faidx],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.calculateRegions.mergeBeds.memory"><a href="#Germline.calculateRegions.mergeBeds.memory">Germline.calculateRegions.mergeBeds.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size(bedFiles,"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="Germline.calculateRegions.mergeBeds.outputBed"><a href="#Germline.calculateRegions.mergeBeds.outputBed">Germline.calculateRegions.mergeBeds.outputBed</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"merged.bed"</code><br />
    The path to write the output to.
</dd>
<dt id="Germline.calculateRegions.mergeBeds.timeMinutes"><a href="#Germline.calculateRegions.mergeBeds.timeMinutes">Germline.calculateRegions.mergeBeds.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(bedFiles,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.calculateRegions.scatterAutosomalRegions.memory"><a href="#Germline.calculateRegions.scatterAutosomalRegions.memory">Germline.calculateRegions.scatterAutosomalRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.calculateRegions.scatterAutosomalRegions.prefix"><a href="#Germline.calculateRegions.scatterAutosomalRegions.prefix">Germline.calculateRegions.scatterAutosomalRegions.prefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"scatters/scatter-"</code><br />
    The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</dd>
<dt id="Germline.calculateRegions.scatterAutosomalRegions.splitContigs"><a href="#Germline.calculateRegions.scatterAutosomalRegions.splitContigs">Germline.calculateRegions.scatterAutosomalRegions.splitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    If set, contigs are allowed to be split up over multiple files.
</dd>
<dt id="Germline.calculateRegions.scatterAutosomalRegions.timeMinutes"><a href="#Germline.calculateRegions.scatterAutosomalRegions.timeMinutes">Germline.calculateRegions.scatterAutosomalRegions.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.collectUmiStats"><a href="#Germline.collectUmiStats">Germline.collectUmiStats</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not UMI deduplication stats should be collected. This will potentially cause a massive increase in memory usage of the deduplication step.
</dd>
<dt id="Germline.convertDockerImagesFile.dockerImage"><a href="#Germline.convertDockerImagesFile.dockerImage">Germline.convertDockerImagesFile.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/biowdl-input-converter:0.3.0--pyhdfd78af_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.convertDockerImagesFile.memory"><a href="#Germline.convertDockerImagesFile.memory">Germline.convertDockerImagesFile.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"128MiB"</code><br />
    The maximum amount of memory the job will need.
</dd>
<dt id="Germline.convertDockerImagesFile.timeMinutes"><a href="#Germline.convertDockerImagesFile.timeMinutes">Germline.convertDockerImagesFile.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.convertSampleConfig.checkFileMd5sums"><a href="#Germline.convertSampleConfig.checkFileMd5sums">Germline.convertSampleConfig.checkFileMd5sums</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the MD5 sums of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="Germline.convertSampleConfig.memory"><a href="#Germline.convertSampleConfig.memory">Germline.convertSampleConfig.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"128MiB"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="Germline.convertSampleConfig.old"><a href="#Germline.convertSampleConfig.old">Germline.convertSampleConfig.old</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the old samplesheet format should be used.
</dd>
<dt id="Germline.convertSampleConfig.outputFile"><a href="#Germline.convertSampleConfig.outputFile">Germline.convertSampleConfig.outputFile</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"samplesheet.json"</code><br />
    The location the JSON representation of the samplesheet should be written to.
</dd>
<dt id="Germline.convertSampleConfig.skipFileCheck"><a href="#Germline.convertSampleConfig.skipFileCheck">Germline.convertSampleConfig.skipFileCheck</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not the existance of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="Germline.convertSampleConfig.timeMinutes"><a href="#Germline.convertSampleConfig.timeMinutes">Germline.convertSampleConfig.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.fidx.dockerImage"><a href="#Germline.fidx.dockerImage">Germline.fidx.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/samtools:1.16.1--h6899075_1"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.fidx.javaXmx"><a href="#Germline.fidx.javaXmx">Germline.fidx.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.fidx.memory"><a href="#Germline.fidx.memory">Germline.fidx.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"3GiB"</code><br />
    The amount of memory available to the job.
</dd>
<dt id="Germline.fidx.timeMinutes"><a href="#Germline.fidx.timeMinutes">Germline.fidx.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>5 + ceil((size(inputFile,"GiB") * 5))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.JointGenotyping.gatherGvcfs.intervals"><a href="#Germline.JointGenotyping.gatherGvcfs.intervals">Germline.JointGenotyping.gatherGvcfs.intervals</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Bed files or interval lists describing the regions to operate on.
</dd>
<dt id="Germline.JointGenotyping.gatherGvcfs.javaXmx"><a href="#Germline.JointGenotyping.gatherGvcfs.javaXmx">Germline.JointGenotyping.gatherGvcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.JointGenotyping.gatherGvcfs.memory"><a href="#Germline.JointGenotyping.gatherGvcfs.memory">Germline.JointGenotyping.gatherGvcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.JointGenotyping.gatherGvcfs.timeMinutes"><a href="#Germline.JointGenotyping.gatherGvcfs.timeMinutes">Germline.JointGenotyping.gatherGvcfs.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(gvcfFiles,"G") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.JointGenotyping.gatherVcfs.compressionLevel"><a href="#Germline.JointGenotyping.gatherVcfs.compressionLevel">Germline.JointGenotyping.gatherVcfs.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level at which the BAM files are written.
</dd>
<dt id="Germline.JointGenotyping.gatherVcfs.javaXmx"><a href="#Germline.JointGenotyping.gatherVcfs.javaXmx">Germline.JointGenotyping.gatherVcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.JointGenotyping.gatherVcfs.memory"><a href="#Germline.JointGenotyping.gatherVcfs.memory">Germline.JointGenotyping.gatherVcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.JointGenotyping.gatherVcfs.timeMinutes"><a href="#Germline.JointGenotyping.gatherVcfs.timeMinutes">Germline.JointGenotyping.gatherVcfs.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputVCFs,"G")) * 2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.JointGenotyping.gatherVcfs.useJdkDeflater"><a href="#Germline.JointGenotyping.gatherVcfs.useJdkDeflater">Germline.JointGenotyping.gatherVcfs.useJdkDeflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</dd>
<dt id="Germline.JointGenotyping.gatherVcfs.useJdkInflater"><a href="#Germline.JointGenotyping.gatherVcfs.useJdkInflater">Germline.JointGenotyping.gatherVcfs.useJdkInflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java inflater. False, uses the optimized intel inflater.
</dd>
<dt id="Germline.JointGenotyping.genotypeGvcfs.annotationGroups"><a href="#Germline.JointGenotyping.genotypeGvcfs.annotationGroups">Germline.JointGenotyping.genotypeGvcfs.annotationGroups</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>["StandardAnnotation"]</code><br />
    Which annotation groups will be used for the annotation.
</dd>
<dt id="Germline.JointGenotyping.genotypeGvcfs.javaXmx"><a href="#Germline.JointGenotyping.genotypeGvcfs.javaXmx">Germline.JointGenotyping.genotypeGvcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"6G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.JointGenotyping.genotypeGvcfs.memory"><a href="#Germline.JointGenotyping.genotypeGvcfs.memory">Germline.JointGenotyping.genotypeGvcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"7G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.JointGenotyping.genotypeGvcfs.timeMinutes"><a href="#Germline.JointGenotyping.genotypeGvcfs.timeMinutes">Germline.JointGenotyping.genotypeGvcfs.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>120</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.JointGenotyping.scatterRegions.memory"><a href="#Germline.JointGenotyping.scatterRegions.memory">Germline.JointGenotyping.scatterRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.JointGenotyping.scatterRegions.prefix"><a href="#Germline.JointGenotyping.scatterRegions.prefix">Germline.JointGenotyping.scatterRegions.prefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"scatters/scatter-"</code><br />
    The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</dd>
<dt id="Germline.JointGenotyping.scatterRegions.splitContigs"><a href="#Germline.JointGenotyping.scatterRegions.splitContigs">Germline.JointGenotyping.scatterRegions.splitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    If set, contigs are allowed to be split up over multiple files.
</dd>
<dt id="Germline.JointGenotyping.scatterRegions.timeMinutes"><a href="#Germline.JointGenotyping.scatterRegions.timeMinutes">Germline.JointGenotyping.scatterRegions.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.JointGenotyping.scatterSizeMillions"><a href="#Germline.JointGenotyping.scatterSizeMillions">Germline.JointGenotyping.scatterSizeMillions</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily
</dd>
<dt id="Germline.JointGenotyping.Stats.afBins"><a href="#Germline.JointGenotyping.Stats.afBins">Germline.JointGenotyping.Stats.afBins</a></dt>
<dd>
    <i>String? </i><br />
    Allele frequency bins, a list (0.1,0.5,1) or a file (0.1
0.5
1).
</dd>
<dt id="Germline.JointGenotyping.Stats.applyFilters"><a href="#Germline.JointGenotyping.Stats.applyFilters">Germline.JointGenotyping.Stats.applyFilters</a></dt>
<dd>
    <i>String? </i><br />
    Require at least one of the listed FILTER strings (e.g. "PASS,.").
</dd>
<dt id="Germline.JointGenotyping.Stats.collapse"><a href="#Germline.JointGenotyping.Stats.collapse">Germline.JointGenotyping.Stats.collapse</a></dt>
<dd>
    <i>String? </i><br />
    Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</dd>
<dt id="Germline.JointGenotyping.Stats.depth"><a href="#Germline.JointGenotyping.Stats.depth">Germline.JointGenotyping.Stats.depth</a></dt>
<dd>
    <i>String? </i><br />
    Depth distribution: min,max,bin size [0,500,1].
</dd>
<dt id="Germline.JointGenotyping.Stats.exclude"><a href="#Germline.JointGenotyping.Stats.exclude">Germline.JointGenotyping.Stats.exclude</a></dt>
<dd>
    <i>String? </i><br />
    Exclude sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.JointGenotyping.Stats.exons"><a href="#Germline.JointGenotyping.Stats.exons">Germline.JointGenotyping.Stats.exons</a></dt>
<dd>
    <i>File? </i><br />
    Tab-delimited file with exons for indel frameshifts (chr,from,to; 1-based, inclusive, bgzip compressed).
</dd>
<dt id="Germline.JointGenotyping.Stats.firstAlleleOnly"><a href="#Germline.JointGenotyping.Stats.firstAlleleOnly">Germline.JointGenotyping.Stats.firstAlleleOnly</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Include only 1st allele at multiallelic sites.
</dd>
<dt id="Germline.JointGenotyping.Stats.include"><a href="#Germline.JointGenotyping.Stats.include">Germline.JointGenotyping.Stats.include</a></dt>
<dd>
    <i>String? </i><br />
    Select sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.JointGenotyping.Stats.memory"><a href="#Germline.JointGenotyping.Stats.memory">Germline.JointGenotyping.Stats.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.JointGenotyping.Stats.regions"><a href="#Germline.JointGenotyping.Stats.regions">Germline.JointGenotyping.Stats.regions</a></dt>
<dd>
    <i>String? </i><br />
    Restrict to comma-separated list of regions.
</dd>
<dt id="Germline.JointGenotyping.Stats.samplesFile"><a href="#Germline.JointGenotyping.Stats.samplesFile">Germline.JointGenotyping.Stats.samplesFile</a></dt>
<dd>
    <i>File? </i><br />
    File of samples to include.
</dd>
<dt id="Germline.JointGenotyping.Stats.splitByID"><a href="#Germline.JointGenotyping.Stats.splitByID">Germline.JointGenotyping.Stats.splitByID</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Collect stats for sites with ID separately (known vs novel).
</dd>
<dt id="Germline.JointGenotyping.Stats.targets"><a href="#Germline.JointGenotyping.Stats.targets">Germline.JointGenotyping.Stats.targets</a></dt>
<dd>
    <i>String? </i><br />
    Similar to regions but streams rather than index-jumps.
</dd>
<dt id="Germline.JointGenotyping.Stats.targetsFile"><a href="#Germline.JointGenotyping.Stats.targetsFile">Germline.JointGenotyping.Stats.targetsFile</a></dt>
<dd>
    <i>File? </i><br />
    Similar to regionsFile but streams rather than index-jumps.
</dd>
<dt id="Germline.JointGenotyping.Stats.threads"><a href="#Germline.JointGenotyping.Stats.threads">Germline.JointGenotyping.Stats.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>0</code><br />
    Number of extra decompression threads [0].
</dd>
<dt id="Germline.JointGenotyping.Stats.timeMinutes"><a href="#Germline.JointGenotyping.Stats.timeMinutes">Germline.JointGenotyping.Stats.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + 2 * ceil(size(select_all([inputVcf, compareVcf]),"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.JointGenotyping.Stats.userTsTv"><a href="#Germline.JointGenotyping.Stats.userTsTv">Germline.JointGenotyping.Stats.userTsTv</a></dt>
<dd>
    <i>String? </i><br />
    <TAG[:min:max:n]>. Collect Ts/Tv stats for any tag using the given binning [0:1:100].
</dd>
<dt id="Germline.JointGenotyping.Stats.verbose"><a href="#Germline.JointGenotyping.Stats.verbose">Germline.JointGenotyping.Stats.verbose</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Produce verbose per-site and per-sample output.
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
    Whether to output a data dir. Sets `--data-dir` or `--no-data-dir` flag.
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
    <i>String? </i><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.multiqcTask.module"><a href="#Germline.multiqcTask.module">Germline.multiqcTask.module</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--module` option.
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
<dt id="Germline.multiqcTask.timeMinutes"><a href="#Germline.multiqcTask.timeMinutes">Germline.multiqcTask.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10 + ceil((size(reports,"GiB") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.multiqcTask.title"><a href="#Germline.multiqcTask.title">Germline.multiqcTask.title</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--title` option.
</dd>
<dt id="Germline.multiqcTask.zipDataDir"><a href="#Germline.multiqcTask.zipDataDir">Germline.multiqcTask.zipDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to MultiQC's `--zip-data-dir` flag.
</dd>
<dt id="Germline.platform"><a href="#Germline.platform">Germline.platform</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"illumina"</code><br />
    The platform used for sequencing.
</dd>
<dt id="Germline.runSVcalling"><a href="#Germline.runSVcalling">Germline.runSVcalling</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not Structural-variantcalling should be run.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.applyBqsr.javaXmxMb"><a href="#Germline.sampleWorkflow.bqsr.applyBqsr.javaXmxMb">Germline.sampleWorkflow.bqsr.applyBqsr.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2048</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.applyBqsr.memoryMb"><a href="#Germline.sampleWorkflow.bqsr.applyBqsr.memoryMb">Germline.sampleWorkflow.bqsr.applyBqsr.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.baseRecalibrator.javaXmxMb"><a href="#Germline.sampleWorkflow.bqsr.baseRecalibrator.javaXmxMb">Germline.sampleWorkflow.bqsr.baseRecalibrator.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1024</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes"><a href="#Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes">Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    The indexed for the known variant VCFs.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFs"><a href="#Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFs">Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFs</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    VCF files with known indels.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.baseRecalibrator.memoryMb"><a href="#Germline.sampleWorkflow.bqsr.baseRecalibrator.memoryMb">Germline.sampleWorkflow.bqsr.baseRecalibrator.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBamFiles.compressionLevel"><a href="#Germline.sampleWorkflow.bqsr.gatherBamFiles.compressionLevel">Germline.sampleWorkflow.bqsr.gatherBamFiles.compressionLevel</a></dt>
<dd>
    <i>Int? </i><br />
    The compression level of the output BAM.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBamFiles.createMd5File"><a href="#Germline.sampleWorkflow.bqsr.gatherBamFiles.createMd5File">Germline.sampleWorkflow.bqsr.gatherBamFiles.createMd5File</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    ???
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBamFiles.javaXmxMb"><a href="#Germline.sampleWorkflow.bqsr.gatherBamFiles.javaXmxMb">Germline.sampleWorkflow.bqsr.gatherBamFiles.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1024</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBamFiles.memoryMb"><a href="#Germline.sampleWorkflow.bqsr.gatherBamFiles.memoryMb">Germline.sampleWorkflow.bqsr.gatherBamFiles.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBamFiles.timeMinutes"><a href="#Germline.sampleWorkflow.bqsr.gatherBamFiles.timeMinutes">Germline.sampleWorkflow.bqsr.gatherBamFiles.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBams,"G") * 1))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBqsr.javaXmxMb"><a href="#Germline.sampleWorkflow.bqsr.gatherBqsr.javaXmxMb">Germline.sampleWorkflow.bqsr.gatherBqsr.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>256</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBqsr.memoryMb"><a href="#Germline.sampleWorkflow.bqsr.gatherBqsr.memoryMb">Germline.sampleWorkflow.bqsr.gatherBqsr.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>256 + javaXmxMb</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.gatherBqsr.timeMinutes"><a href="#Germline.sampleWorkflow.bqsr.gatherBqsr.timeMinutes">Germline.sampleWorkflow.bqsr.gatherBqsr.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.splitNCigarReads.javaXmx"><a href="#Germline.sampleWorkflow.bqsr.splitNCigarReads.javaXmx">Germline.sampleWorkflow.bqsr.splitNCigarReads.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.bqsr.splitNCigarReads.memory"><a href="#Germline.sampleWorkflow.bqsr.splitNCigarReads.memory">Germline.sampleWorkflow.bqsr.splitNCigarReads.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.bwaMem.compressionLevel"><a href="#Germline.sampleWorkflow.bwaMem.compressionLevel">Germline.sampleWorkflow.bwaMem.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level of the output BAM.
</dd>
<dt id="Germline.sampleWorkflow.bwaMem.memoryGb"><a href="#Germline.sampleWorkflow.bwaMem.memoryGb">Germline.sampleWorkflow.bwaMem.memoryGb</a></dt>
<dd>
    <i>Int? </i><br />
    The amount of memory this job will use in gigabytes.
</dd>
<dt id="Germline.sampleWorkflow.bwaMem.sortMemoryPerThreadGb"><a href="#Germline.sampleWorkflow.bwaMem.sortMemoryPerThreadGb">Germline.sampleWorkflow.bwaMem.sortMemoryPerThreadGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The amount of memory for each sorting thread in gigabytes.
</dd>
<dt id="Germline.sampleWorkflow.bwaMem.sortThreads"><a href="#Germline.sampleWorkflow.bwaMem.sortThreads">Germline.sampleWorkflow.bwaMem.sortThreads</a></dt>
<dd>
    <i>Int? </i><br />
    The number of threads to use for sorting.
</dd>
<dt id="Germline.sampleWorkflow.bwaMem.timeMinutes"><a href="#Germline.sampleWorkflow.bwaMem.timeMinutes">Germline.sampleWorkflow.bwaMem.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10 + ceil((size([read1, read2],"GiB") * 300 / threads))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.bwamem2Mem.compressionLevel"><a href="#Germline.sampleWorkflow.bwamem2Mem.compressionLevel">Germline.sampleWorkflow.bwamem2Mem.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level of the output BAM.
</dd>
<dt id="Germline.sampleWorkflow.bwamem2Mem.memoryGb"><a href="#Germline.sampleWorkflow.bwamem2Mem.memoryGb">Germline.sampleWorkflow.bwamem2Mem.memoryGb</a></dt>
<dd>
    <i>Int? </i><br />
    The amount of memory this job will use in gigabytes.
</dd>
<dt id="Germline.sampleWorkflow.bwamem2Mem.sortMemoryPerThreadGb"><a href="#Germline.sampleWorkflow.bwamem2Mem.sortMemoryPerThreadGb">Germline.sampleWorkflow.bwamem2Mem.sortMemoryPerThreadGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The amount of memory for each sorting thread in gigabytes.
</dd>
<dt id="Germline.sampleWorkflow.bwamem2Mem.sortThreads"><a href="#Germline.sampleWorkflow.bwamem2Mem.sortThreads">Germline.sampleWorkflow.bwamem2Mem.sortThreads</a></dt>
<dd>
    <i>Int? </i><br />
    The number of threads to use for sorting.
</dd>
<dt id="Germline.sampleWorkflow.bwamem2Mem.timeMinutes"><a href="#Germline.sampleWorkflow.bwamem2Mem.timeMinutes">Germline.sampleWorkflow.bwamem2Mem.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size([read1, read2],"GiB") * 220 / threads))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.markdup.compressionLevel"><a href="#Germline.sampleWorkflow.markdup.compressionLevel">Germline.sampleWorkflow.markdup.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    Compression level from 0 (uncompressed) to 9 (best).
</dd>
<dt id="Germline.sampleWorkflow.markdup.hashTableSize"><a href="#Germline.sampleWorkflow.markdup.hashTableSize">Germline.sampleWorkflow.markdup.hashTableSize</a></dt>
<dd>
    <i>Int? </i><br />
    Sets sambamba's hash table size.
</dd>
<dt id="Germline.sampleWorkflow.markdup.ioBufferSize"><a href="#Germline.sampleWorkflow.markdup.ioBufferSize">Germline.sampleWorkflow.markdup.ioBufferSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>128</code><br />
    The amount of mb allocated to each IO buffer. Sambamba uses two IO buffers.
</dd>
<dt id="Germline.sampleWorkflow.markdup.memoryMb"><a href="#Germline.sampleWorkflow.markdup.memoryMb">Germline.sampleWorkflow.markdup.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>8192 + sortBufferSize + 2 * ioBufferSize</code><br />
    The amount of memory available to the job in megabytes.
</dd>
<dt id="Germline.sampleWorkflow.markdup.overFlowListSize"><a href="#Germline.sampleWorkflow.markdup.overFlowListSize">Germline.sampleWorkflow.markdup.overFlowListSize</a></dt>
<dd>
    <i>Int? </i><br />
    Sets sambamba's overflow list size.
</dd>
<dt id="Germline.sampleWorkflow.markdup.removeDuplicates"><a href="#Germline.sampleWorkflow.markdup.removeDuplicates">Germline.sampleWorkflow.markdup.removeDuplicates</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to remove the duplicates (instead of only marking them).
</dd>
<dt id="Germline.sampleWorkflow.markdup.sortBufferSize"><a href="#Germline.sampleWorkflow.markdup.sortBufferSize">Germline.sampleWorkflow.markdup.sortBufferSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4096</code><br />
    The amount of mb allocated to the sort buffer.
</dd>
<dt id="Germline.sampleWorkflow.markdup.threads"><a href="#Germline.sampleWorkflow.markdup.threads">Germline.sampleWorkflow.markdup.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The number of threads that will be used for this task.
</dd>
<dt id="Germline.sampleWorkflow.markdup.timeMinutes"><a href="#Germline.sampleWorkflow.markdup.timeMinutes">Germline.sampleWorkflow.markdup.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBams,"GiB") * 25)) / threads</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.ampliconIntervalsLists.javaXmx"><a href="#Germline.sampleWorkflow.metrics.ampliconIntervalsLists.javaXmx">Germline.sampleWorkflow.metrics.ampliconIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"3G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.metrics.ampliconIntervalsLists.memory"><a href="#Germline.sampleWorkflow.metrics.ampliconIntervalsLists.memory">Germline.sampleWorkflow.metrics.ampliconIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.metrics.ampliconIntervalsLists.timeMinutes"><a href="#Germline.sampleWorkflow.metrics.ampliconIntervalsLists.timeMinutes">Germline.sampleWorkflow.metrics.ampliconIntervalsLists.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>5</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.collectAlignmentSummaryMetrics"><a href="#Germline.sampleWorkflow.metrics.collectAlignmentSummaryMetrics">Germline.sampleWorkflow.metrics.collectAlignmentSummaryMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectAlignmentSummaryMetrics` argument in Picard.
</dd>
<dt id="Germline.sampleWorkflow.metrics.Flagstat.memory"><a href="#Germline.sampleWorkflow.metrics.Flagstat.memory">Germline.sampleWorkflow.metrics.Flagstat.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="Germline.sampleWorkflow.metrics.Flagstat.timeMinutes"><a href="#Germline.sampleWorkflow.metrics.Flagstat.timeMinutes">Germline.sampleWorkflow.metrics.Flagstat.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputBam,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.meanQualityByCycle"><a href="#Germline.sampleWorkflow.metrics.meanQualityByCycle">Germline.sampleWorkflow.metrics.meanQualityByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=MeanQualityByCycle` argument in Picard.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.collectBaseDistributionByCycle"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.collectBaseDistributionByCycle">Germline.sampleWorkflow.metrics.picardMetrics.collectBaseDistributionByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectBaseDistributionByCycle` argument.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.collectGcBiasMetrics"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.collectGcBiasMetrics">Germline.sampleWorkflow.metrics.picardMetrics.collectGcBiasMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectGcBiasMetrics` argument.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.collectInsertSizeMetrics"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.collectInsertSizeMetrics">Germline.sampleWorkflow.metrics.picardMetrics.collectInsertSizeMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectInsertSizeMetrics` argument.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.collectQualityYieldMetrics"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.collectQualityYieldMetrics">Germline.sampleWorkflow.metrics.picardMetrics.collectQualityYieldMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectQualityYieldMetrics` argument.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.collectSequencingArtifactMetrics"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.collectSequencingArtifactMetrics">Germline.sampleWorkflow.metrics.picardMetrics.collectSequencingArtifactMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectSequencingArtifactMetrics` argument.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.javaXmxMb"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.javaXmxMb">Germline.sampleWorkflow.metrics.picardMetrics.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>3072</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.memoryMb"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.memoryMb">Germline.sampleWorkflow.metrics.picardMetrics.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.qualityScoreDistribution"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.qualityScoreDistribution">Germline.sampleWorkflow.metrics.picardMetrics.qualityScoreDistribution</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=QualityScoreDistribution` argument.
</dd>
<dt id="Germline.sampleWorkflow.metrics.picardMetrics.timeMinutes"><a href="#Germline.sampleWorkflow.metrics.picardMetrics.timeMinutes">Germline.sampleWorkflow.metrics.picardMetrics.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(referenceFasta,"G") * 3 * 2)) + ceil((size(inputBam,"G") * 6))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.rnaSeqMetrics.javaXmx"><a href="#Germline.sampleWorkflow.metrics.rnaSeqMetrics.javaXmx">Germline.sampleWorkflow.metrics.rnaSeqMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.metrics.rnaSeqMetrics.memory"><a href="#Germline.sampleWorkflow.metrics.rnaSeqMetrics.memory">Germline.sampleWorkflow.metrics.rnaSeqMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"9G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.metrics.rnaSeqMetrics.timeMinutes"><a href="#Germline.sampleWorkflow.metrics.rnaSeqMetrics.timeMinutes">Germline.sampleWorkflow.metrics.rnaSeqMetrics.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBam,"G") * 12))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.targetIntervalsLists.javaXmx"><a href="#Germline.sampleWorkflow.metrics.targetIntervalsLists.javaXmx">Germline.sampleWorkflow.metrics.targetIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"3G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.metrics.targetIntervalsLists.memory"><a href="#Germline.sampleWorkflow.metrics.targetIntervalsLists.memory">Germline.sampleWorkflow.metrics.targetIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.metrics.targetIntervalsLists.timeMinutes"><a href="#Germline.sampleWorkflow.metrics.targetIntervalsLists.timeMinutes">Germline.sampleWorkflow.metrics.targetIntervalsLists.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>5</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.metrics.targetMetrics.javaXmx"><a href="#Germline.sampleWorkflow.metrics.targetMetrics.javaXmx">Germline.sampleWorkflow.metrics.targetMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"3G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.metrics.targetMetrics.memory"><a href="#Germline.sampleWorkflow.metrics.targetMetrics.memory">Germline.sampleWorkflow.metrics.targetMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.metrics.targetMetrics.timeMinutes"><a href="#Germline.sampleWorkflow.metrics.targetMetrics.timeMinutes">Germline.sampleWorkflow.metrics.targetMetrics.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBam,"G") * 6))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.bwa"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.bwa">Germline.sampleWorkflow.qualityControl.Cutadapt.bwa</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --bwa flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.colorspace"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.colorspace">Germline.sampleWorkflow.qualityControl.Cutadapt.colorspace</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --colorspace flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.compressionLevel"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.compressionLevel">Germline.sampleWorkflow.qualityControl.Cutadapt.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level if gzipped output is used.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.cores"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.cores">Germline.sampleWorkflow.qualityControl.Cutadapt.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.cut"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.cut">Germline.sampleWorkflow.qualityControl.Cutadapt.cut</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --cut option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.discardTrimmed"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.discardTrimmed">Germline.sampleWorkflow.qualityControl.Cutadapt.discardTrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.discardUntrimmed"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.discardUntrimmed">Germline.sampleWorkflow.qualityControl.Cutadapt.discardUntrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --discard-untrimmed option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.doubleEncode"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.doubleEncode">Germline.sampleWorkflow.qualityControl.Cutadapt.doubleEncode</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --double-encode flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.errorRate"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.errorRate">Germline.sampleWorkflow.qualityControl.Cutadapt.errorRate</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to cutadapt's --error-rate option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.front"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.front">Germline.sampleWorkflow.qualityControl.Cutadapt.front</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given first or single end fastq file.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.frontRead2"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.frontRead2">Germline.sampleWorkflow.qualityControl.Cutadapt.frontRead2</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given second end fastq file.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.infoFilePath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.infoFilePath">Germline.sampleWorkflow.qualityControl.Cutadapt.infoFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --info-file option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.interleaved"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.interleaved">Germline.sampleWorkflow.qualityControl.Cutadapt.interleaved</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --interleaved flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.length"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.length">Germline.sampleWorkflow.qualityControl.Cutadapt.length</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --length option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.lengthTag"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.lengthTag">Germline.sampleWorkflow.qualityControl.Cutadapt.lengthTag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --length-tag option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.maq"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.maq">Germline.sampleWorkflow.qualityControl.Cutadapt.maq</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --maq flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.maskAdapter"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.maskAdapter">Germline.sampleWorkflow.qualityControl.Cutadapt.maskAdapter</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --mask-adapter flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.matchReadWildcards"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.matchReadWildcards">Germline.sampleWorkflow.qualityControl.Cutadapt.matchReadWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --match-read-wildcards flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.maximumLength"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.maximumLength">Germline.sampleWorkflow.qualityControl.Cutadapt.maximumLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --maximum-length option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.maxN"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.maxN">Germline.sampleWorkflow.qualityControl.Cutadapt.maxN</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --max-n option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.memory"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.memory">Germline.sampleWorkflow.qualityControl.Cutadapt.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.minimumLength"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.minimumLength">Germline.sampleWorkflow.qualityControl.Cutadapt.minimumLength</a></dt>
<dd>
    <i>Int? </i><i>&mdash; Default:</i> <code>2</code><br />
    Equivalent to cutadapt's --minimum-length option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.nextseqTrim"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.nextseqTrim">Germline.sampleWorkflow.qualityControl.Cutadapt.nextseqTrim</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --nextseq-trim option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.noIndels"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.noIndels">Germline.sampleWorkflow.qualityControl.Cutadapt.noIndels</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-indels flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.noMatchAdapterWildcards"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.noMatchAdapterWildcards">Germline.sampleWorkflow.qualityControl.Cutadapt.noMatchAdapterWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-match-adapter-wildcards flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.noTrim"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.noTrim">Germline.sampleWorkflow.qualityControl.Cutadapt.noTrim</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-trim flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.noZeroCap"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.noZeroCap">Germline.sampleWorkflow.qualityControl.Cutadapt.noZeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-zero-cap flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.overlap"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.overlap">Germline.sampleWorkflow.qualityControl.Cutadapt.overlap</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --overlap option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.pairFilter"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.pairFilter">Germline.sampleWorkflow.qualityControl.Cutadapt.pairFilter</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --pair-filter option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.prefix"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.prefix">Germline.sampleWorkflow.qualityControl.Cutadapt.prefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --prefix option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.qualityBase"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.qualityBase">Germline.sampleWorkflow.qualityControl.Cutadapt.qualityBase</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --quality-base option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.qualityCutoff"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.qualityCutoff">Germline.sampleWorkflow.qualityControl.Cutadapt.qualityCutoff</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.restFilePath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.restFilePath">Germline.sampleWorkflow.qualityControl.Cutadapt.restFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --rest-file option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.stripF3"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.stripF3">Germline.sampleWorkflow.qualityControl.Cutadapt.stripF3</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --strip-f3 flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.stripSuffix"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.stripSuffix">Germline.sampleWorkflow.qualityControl.Cutadapt.stripSuffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --strip-suffix option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.suffix"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.suffix">Germline.sampleWorkflow.qualityControl.Cutadapt.suffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --suffix option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.timeMinutes"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.timeMinutes">Germline.sampleWorkflow.qualityControl.Cutadapt.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size([read1, read2],"G") * 12.0 / cores))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.times"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.times">Germline.sampleWorkflow.qualityControl.Cutadapt.times</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --times option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongOutputPath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongOutputPath">Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-output option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongPairedOutputPath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongPairedOutputPath">Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-paired-output option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortOutputPath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortOutputPath">Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-output option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortPairedOutputPath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortPairedOutputPath">Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-paired-output option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.trimN"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.trimN">Germline.sampleWorkflow.qualityControl.Cutadapt.trimN</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --trim-n flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedOutputPath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedOutputPath">Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-output option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedPairedOutputPath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedPairedOutputPath">Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-paired-output option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.wildcardFilePath"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.wildcardFilePath">Germline.sampleWorkflow.qualityControl.Cutadapt.wildcardFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --wildcard-file option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.Cutadapt.zeroCap"><a href="#Germline.sampleWorkflow.qualityControl.Cutadapt.zeroCap">Germline.sampleWorkflow.qualityControl.Cutadapt.zeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --zero-cap flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.extractFastqcZip"><a href="#Germline.sampleWorkflow.qualityControl.extractFastqcZip">Germline.sampleWorkflow.qualityControl.extractFastqcZip</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to extract Fastqc's report zip files.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.adapters"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.adapters">Germline.sampleWorkflow.qualityControl.FastqcRead1.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.casava"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.casava">Germline.sampleWorkflow.qualityControl.FastqcRead1.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.contaminants"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.contaminants">Germline.sampleWorkflow.qualityControl.FastqcRead1.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.dir"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.dir">Germline.sampleWorkflow.qualityControl.FastqcRead1.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.format"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.format">Germline.sampleWorkflow.qualityControl.FastqcRead1.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.javaXmx"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.javaXmx">Germline.sampleWorkflow.qualityControl.FastqcRead1.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.kmers"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.kmers">Germline.sampleWorkflow.qualityControl.FastqcRead1.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.limits"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.limits">Germline.sampleWorkflow.qualityControl.FastqcRead1.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.memory"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.memory">Germline.sampleWorkflow.qualityControl.FastqcRead1.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.minLength"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.minLength">Germline.sampleWorkflow.qualityControl.FastqcRead1.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.nano"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.nano">Germline.sampleWorkflow.qualityControl.FastqcRead1.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.noFilter"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.noFilter">Germline.sampleWorkflow.qualityControl.FastqcRead1.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.nogroup"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.nogroup">Germline.sampleWorkflow.qualityControl.FastqcRead1.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.threads"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.threads">Germline.sampleWorkflow.qualityControl.FastqcRead1.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1.timeMinutes"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1.timeMinutes">Germline.sampleWorkflow.qualityControl.FastqcRead1.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.adapters"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.adapters">Germline.sampleWorkflow.qualityControl.FastqcRead1After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.casava"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.casava">Germline.sampleWorkflow.qualityControl.FastqcRead1After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.contaminants"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.contaminants">Germline.sampleWorkflow.qualityControl.FastqcRead1After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.dir"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.dir">Germline.sampleWorkflow.qualityControl.FastqcRead1After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.format"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.format">Germline.sampleWorkflow.qualityControl.FastqcRead1After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.javaXmx"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.javaXmx">Germline.sampleWorkflow.qualityControl.FastqcRead1After.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.kmers"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.kmers">Germline.sampleWorkflow.qualityControl.FastqcRead1After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.limits"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.limits">Germline.sampleWorkflow.qualityControl.FastqcRead1After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.memory"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.memory">Germline.sampleWorkflow.qualityControl.FastqcRead1After.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.minLength"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.minLength">Germline.sampleWorkflow.qualityControl.FastqcRead1After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.nano"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.nano">Germline.sampleWorkflow.qualityControl.FastqcRead1After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.noFilter"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.noFilter">Germline.sampleWorkflow.qualityControl.FastqcRead1After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.nogroup"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.nogroup">Germline.sampleWorkflow.qualityControl.FastqcRead1After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.threads"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.threads">Germline.sampleWorkflow.qualityControl.FastqcRead1After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead1After.timeMinutes"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead1After.timeMinutes">Germline.sampleWorkflow.qualityControl.FastqcRead1After.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.adapters"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.adapters">Germline.sampleWorkflow.qualityControl.FastqcRead2.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.casava"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.casava">Germline.sampleWorkflow.qualityControl.FastqcRead2.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.contaminants"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.contaminants">Germline.sampleWorkflow.qualityControl.FastqcRead2.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.dir"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.dir">Germline.sampleWorkflow.qualityControl.FastqcRead2.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.format"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.format">Germline.sampleWorkflow.qualityControl.FastqcRead2.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.javaXmx"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.javaXmx">Germline.sampleWorkflow.qualityControl.FastqcRead2.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.kmers"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.kmers">Germline.sampleWorkflow.qualityControl.FastqcRead2.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.limits"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.limits">Germline.sampleWorkflow.qualityControl.FastqcRead2.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.memory"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.memory">Germline.sampleWorkflow.qualityControl.FastqcRead2.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.minLength"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.minLength">Germline.sampleWorkflow.qualityControl.FastqcRead2.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.nano"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.nano">Germline.sampleWorkflow.qualityControl.FastqcRead2.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.noFilter"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.noFilter">Germline.sampleWorkflow.qualityControl.FastqcRead2.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.nogroup"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.nogroup">Germline.sampleWorkflow.qualityControl.FastqcRead2.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.threads"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.threads">Germline.sampleWorkflow.qualityControl.FastqcRead2.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2.timeMinutes"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2.timeMinutes">Germline.sampleWorkflow.qualityControl.FastqcRead2.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.adapters"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.adapters">Germline.sampleWorkflow.qualityControl.FastqcRead2After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.casava"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.casava">Germline.sampleWorkflow.qualityControl.FastqcRead2After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.contaminants"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.contaminants">Germline.sampleWorkflow.qualityControl.FastqcRead2After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.dir"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.dir">Germline.sampleWorkflow.qualityControl.FastqcRead2After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.format"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.format">Germline.sampleWorkflow.qualityControl.FastqcRead2After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.javaXmx"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.javaXmx">Germline.sampleWorkflow.qualityControl.FastqcRead2After.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.kmers"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.kmers">Germline.sampleWorkflow.qualityControl.FastqcRead2After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.limits"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.limits">Germline.sampleWorkflow.qualityControl.FastqcRead2After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.memory"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.memory">Germline.sampleWorkflow.qualityControl.FastqcRead2After.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.minLength"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.minLength">Germline.sampleWorkflow.qualityControl.FastqcRead2After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.nano"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.nano">Germline.sampleWorkflow.qualityControl.FastqcRead2After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.noFilter"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.noFilter">Germline.sampleWorkflow.qualityControl.FastqcRead2After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.nogroup"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.nogroup">Germline.sampleWorkflow.qualityControl.FastqcRead2After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.threads"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.threads">Germline.sampleWorkflow.qualityControl.FastqcRead2After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.FastqcRead2After.timeMinutes"><a href="#Germline.sampleWorkflow.qualityControl.FastqcRead2After.timeMinutes">Germline.sampleWorkflow.qualityControl.FastqcRead2After.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.qualityControl.runAdapterClipping"><a href="#Germline.sampleWorkflow.qualityControl.runAdapterClipping">Germline.sampleWorkflow.qualityControl.runAdapterClipping</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>defined(adapterForward) || defined(adapterReverse) || length(select_first([contaminations, []])) > 0</code><br />
    Whether or not adapters should be removed from the reads.
</dd>
<dt id="Germline.sampleWorkflow.tagUmi.dockerImage"><a href="#Germline.sampleWorkflow.tagUmi.dockerImage">Germline.sampleWorkflow.tagUmi.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/pysam:0.17.0--py39h051187c_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.sampleWorkflow.tagUmi.memory"><a href="#Germline.sampleWorkflow.tagUmi.memory">Germline.sampleWorkflow.tagUmi.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2GiB"</code><br />
    The amount of memory available to the job.
</dd>
<dt id="Germline.sampleWorkflow.tagUmi.timeMinutes"><a href="#Germline.sampleWorkflow.tagUmi.timeMinutes">Germline.sampleWorkflow.tagUmi.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size([inputBam],"GiB") * 10))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.compressionLevel"><a href="#Germline.sampleWorkflow.umiDedup.compressionLevel">Germline.sampleWorkflow.umiDedup.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level at which the BAM files are written.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.dockerImage"><a href="#Germline.sampleWorkflow.umiDedup.dockerImage">Germline.sampleWorkflow.umiDedup.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/picard:2.26.10--hdfd78af_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.javaXmx"><a href="#Germline.sampleWorkflow.umiDedup.javaXmx">Germline.sampleWorkflow.umiDedup.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.maxRecordsInRam"><a href="#Germline.sampleWorkflow.umiDedup.maxRecordsInRam">Germline.sampleWorkflow.umiDedup.maxRecordsInRam</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1500000</code><br />
    This will specify the number of records stored in RAM before spilling to disk.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.memory"><a href="#Germline.sampleWorkflow.umiDedup.memory">Germline.sampleWorkflow.umiDedup.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"9GiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.timeMinutes"><a href="#Germline.sampleWorkflow.umiDedup.timeMinutes">Germline.sampleWorkflow.umiDedup.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>360</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.useJdkDeflater"><a href="#Germline.sampleWorkflow.umiDedup.useJdkDeflater">Germline.sampleWorkflow.umiDedup.useJdkDeflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</dd>
<dt id="Germline.sampleWorkflow.umiDedup.useJdkInflater"><a href="#Germline.sampleWorkflow.umiDedup.useJdkInflater">Germline.sampleWorkflow.umiDedup.useJdkInflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    True, uses the java inflater. False, uses the optimized intel inflater.
</dd>
<dt id="Germline.scatterList.memory"><a href="#Germline.scatterList.memory">Germline.scatterList.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256MiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.scatterList.prefix"><a href="#Germline.scatterList.prefix">Germline.scatterList.prefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"scatters/scatter-"</code><br />
    The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</dd>
<dt id="Germline.scatterList.splitContigs"><a href="#Germline.scatterList.splitContigs">Germline.scatterList.splitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    If set, contigs are allowed to be split up over multiple files.
</dd>
<dt id="Germline.scatterList.timeMinutes"><a href="#Germline.scatterList.timeMinutes">Germline.scatterList.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.scatterSize"><a href="#Germline.scatterSize">Germline.scatterSize</a></dt>
<dd>
    <i>Int? </i><br />
    The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
<dt id="Germline.scatterSizeMillions"><a href="#Germline.scatterSizeMillions">Germline.scatterSizeMillions</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.contamination"><a href="#Germline.singleSampleCalling.callAutosomal.contamination">Germline.singleSampleCalling.callAutosomal.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.emitRefConfidence"><a href="#Germline.singleSampleCalling.callAutosomal.emitRefConfidence">Germline.singleSampleCalling.callAutosomal.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.javaXmxMb"><a href="#Germline.singleSampleCalling.callAutosomal.javaXmxMb">Germline.singleSampleCalling.callAutosomal.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4096</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.memoryMb"><a href="#Germline.singleSampleCalling.callAutosomal.memoryMb">Germline.singleSampleCalling.callAutosomal.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.singleSampleCalling.callAutosomal.outputMode"><a href="#Germline.singleSampleCalling.callAutosomal.outputMode">Germline.singleSampleCalling.callAutosomal.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="Germline.singleSampleCalling.callX.contamination"><a href="#Germline.singleSampleCalling.callX.contamination">Germline.singleSampleCalling.callX.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="Germline.singleSampleCalling.callX.emitRefConfidence"><a href="#Germline.singleSampleCalling.callX.emitRefConfidence">Germline.singleSampleCalling.callX.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</dd>
<dt id="Germline.singleSampleCalling.callX.javaXmxMb"><a href="#Germline.singleSampleCalling.callX.javaXmxMb">Germline.singleSampleCalling.callX.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4096</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="Germline.singleSampleCalling.callX.memoryMb"><a href="#Germline.singleSampleCalling.callX.memoryMb">Germline.singleSampleCalling.callX.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.singleSampleCalling.callX.outputMode"><a href="#Germline.singleSampleCalling.callX.outputMode">Germline.singleSampleCalling.callX.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="Germline.singleSampleCalling.callY.contamination"><a href="#Germline.singleSampleCalling.callY.contamination">Germline.singleSampleCalling.callY.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="Germline.singleSampleCalling.callY.emitRefConfidence"><a href="#Germline.singleSampleCalling.callY.emitRefConfidence">Germline.singleSampleCalling.callY.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</dd>
<dt id="Germline.singleSampleCalling.callY.javaXmxMb"><a href="#Germline.singleSampleCalling.callY.javaXmxMb">Germline.singleSampleCalling.callY.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4096</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="Germline.singleSampleCalling.callY.memoryMb"><a href="#Germline.singleSampleCalling.callY.memoryMb">Germline.singleSampleCalling.callY.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="Germline.singleSampleCalling.callY.outputMode"><a href="#Germline.singleSampleCalling.callY.outputMode">Germline.singleSampleCalling.callY.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleGvcf.intervals"><a href="#Germline.singleSampleCalling.mergeSingleSampleGvcf.intervals">Germline.singleSampleCalling.mergeSingleSampleGvcf.intervals</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Bed files or interval lists describing the regions to operate on.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleGvcf.javaXmx"><a href="#Germline.singleSampleCalling.mergeSingleSampleGvcf.javaXmx">Germline.singleSampleCalling.mergeSingleSampleGvcf.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleGvcf.memory"><a href="#Germline.singleSampleCalling.mergeSingleSampleGvcf.memory">Germline.singleSampleCalling.mergeSingleSampleGvcf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleGvcf.timeMinutes"><a href="#Germline.singleSampleCalling.mergeSingleSampleGvcf.timeMinutes">Germline.singleSampleCalling.mergeSingleSampleGvcf.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(gvcfFiles,"G") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleVcf.compressionLevel"><a href="#Germline.singleSampleCalling.mergeSingleSampleVcf.compressionLevel">Germline.singleSampleCalling.mergeSingleSampleVcf.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level at which the BAM files are written.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleVcf.javaXmx"><a href="#Germline.singleSampleCalling.mergeSingleSampleVcf.javaXmx">Germline.singleSampleCalling.mergeSingleSampleVcf.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleVcf.memory"><a href="#Germline.singleSampleCalling.mergeSingleSampleVcf.memory">Germline.singleSampleCalling.mergeSingleSampleVcf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleVcf.timeMinutes"><a href="#Germline.singleSampleCalling.mergeSingleSampleVcf.timeMinutes">Germline.singleSampleCalling.mergeSingleSampleVcf.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputVCFs,"G")) * 2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkDeflater"><a href="#Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkDeflater">Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkDeflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</dd>
<dt id="Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkInflater"><a href="#Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkInflater">Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkInflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java inflater. False, uses the optimized intel inflater.
</dd>
<dt id="Germline.singleSampleCalling.standardMinConfidenceThresholdForCalling"><a href="#Germline.singleSampleCalling.standardMinConfidenceThresholdForCalling">Germline.singleSampleCalling.standardMinConfidenceThresholdForCalling</a></dt>
<dd>
    <i>Float? </i><br />
    Minimum confidence treshold used by haplotype caller.
</dd>
<dt id="Germline.singleSampleCalling.Stats.afBins"><a href="#Germline.singleSampleCalling.Stats.afBins">Germline.singleSampleCalling.Stats.afBins</a></dt>
<dd>
    <i>String? </i><br />
    Allele frequency bins, a list (0.1,0.5,1) or a file (0.1
0.5
1).
</dd>
<dt id="Germline.singleSampleCalling.Stats.applyFilters"><a href="#Germline.singleSampleCalling.Stats.applyFilters">Germline.singleSampleCalling.Stats.applyFilters</a></dt>
<dd>
    <i>String? </i><br />
    Require at least one of the listed FILTER strings (e.g. "PASS,.").
</dd>
<dt id="Germline.singleSampleCalling.Stats.collapse"><a href="#Germline.singleSampleCalling.Stats.collapse">Germline.singleSampleCalling.Stats.collapse</a></dt>
<dd>
    <i>String? </i><br />
    Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</dd>
<dt id="Germline.singleSampleCalling.Stats.depth"><a href="#Germline.singleSampleCalling.Stats.depth">Germline.singleSampleCalling.Stats.depth</a></dt>
<dd>
    <i>String? </i><br />
    Depth distribution: min,max,bin size [0,500,1].
</dd>
<dt id="Germline.singleSampleCalling.Stats.exclude"><a href="#Germline.singleSampleCalling.Stats.exclude">Germline.singleSampleCalling.Stats.exclude</a></dt>
<dd>
    <i>String? </i><br />
    Exclude sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.singleSampleCalling.Stats.exons"><a href="#Germline.singleSampleCalling.Stats.exons">Germline.singleSampleCalling.Stats.exons</a></dt>
<dd>
    <i>File? </i><br />
    Tab-delimited file with exons for indel frameshifts (chr,from,to; 1-based, inclusive, bgzip compressed).
</dd>
<dt id="Germline.singleSampleCalling.Stats.firstAlleleOnly"><a href="#Germline.singleSampleCalling.Stats.firstAlleleOnly">Germline.singleSampleCalling.Stats.firstAlleleOnly</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Include only 1st allele at multiallelic sites.
</dd>
<dt id="Germline.singleSampleCalling.Stats.include"><a href="#Germline.singleSampleCalling.Stats.include">Germline.singleSampleCalling.Stats.include</a></dt>
<dd>
    <i>String? </i><br />
    Select sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.singleSampleCalling.Stats.memory"><a href="#Germline.singleSampleCalling.Stats.memory">Germline.singleSampleCalling.Stats.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.singleSampleCalling.Stats.regions"><a href="#Germline.singleSampleCalling.Stats.regions">Germline.singleSampleCalling.Stats.regions</a></dt>
<dd>
    <i>String? </i><br />
    Restrict to comma-separated list of regions.
</dd>
<dt id="Germline.singleSampleCalling.Stats.samplesFile"><a href="#Germline.singleSampleCalling.Stats.samplesFile">Germline.singleSampleCalling.Stats.samplesFile</a></dt>
<dd>
    <i>File? </i><br />
    File of samples to include.
</dd>
<dt id="Germline.singleSampleCalling.Stats.splitByID"><a href="#Germline.singleSampleCalling.Stats.splitByID">Germline.singleSampleCalling.Stats.splitByID</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Collect stats for sites with ID separately (known vs novel).
</dd>
<dt id="Germline.singleSampleCalling.Stats.targets"><a href="#Germline.singleSampleCalling.Stats.targets">Germline.singleSampleCalling.Stats.targets</a></dt>
<dd>
    <i>String? </i><br />
    Similar to regions but streams rather than index-jumps.
</dd>
<dt id="Germline.singleSampleCalling.Stats.targetsFile"><a href="#Germline.singleSampleCalling.Stats.targetsFile">Germline.singleSampleCalling.Stats.targetsFile</a></dt>
<dd>
    <i>File? </i><br />
    Similar to regionsFile but streams rather than index-jumps.
</dd>
<dt id="Germline.singleSampleCalling.Stats.threads"><a href="#Germline.singleSampleCalling.Stats.threads">Germline.singleSampleCalling.Stats.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>0</code><br />
    Number of extra decompression threads [0].
</dd>
<dt id="Germline.singleSampleCalling.Stats.timeMinutes"><a href="#Germline.singleSampleCalling.Stats.timeMinutes">Germline.singleSampleCalling.Stats.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + 2 * ceil(size(select_all([inputVcf, compareVcf]),"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.singleSampleCalling.Stats.userTsTv"><a href="#Germline.singleSampleCalling.Stats.userTsTv">Germline.singleSampleCalling.Stats.userTsTv</a></dt>
<dd>
    <i>String? </i><br />
    <TAG[:min:max:n]>. Collect Ts/Tv stats for any tag using the given binning [0:1:100].
</dd>
<dt id="Germline.singleSampleCalling.Stats.verbose"><a href="#Germline.singleSampleCalling.Stats.verbose">Germline.singleSampleCalling.Stats.verbose</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Produce verbose per-site and per-sample output.
</dd>
<dt id="Germline.singleSampleCalling.timeMinutes"><a href="#Germline.singleSampleCalling.timeMinutes">Germline.singleSampleCalling.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>ceil((size(bam,"G") * 120))</code><br />
    The time in minutes expected for each haplotype caller task. Will be exposed as the time_minutes runtime attribute.
</dd>
<dt id="Germline.svCalling.annotateDH.memory"><a href="#Germline.svCalling.annotateDH.memory">Germline.svCalling.annotateDH.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"15GiB"</code><br />
    The memory required to run the programs.
</dd>
<dt id="Germline.svCalling.annotateDH.timeMinutes"><a href="#Germline.svCalling.annotateDH.timeMinutes">Germline.svCalling.annotateDH.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1440</code><br />
    The maximum duration (in minutes) the tool is allowed to run.
</dd>
<dt id="Germline.svCalling.clever.memory"><a href="#Germline.svCalling.clever.memory">Germline.svCalling.clever.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"80GiB"</code><br />
    The memory required to run the programs.
</dd>
<dt id="Germline.svCalling.clever.threads"><a href="#Germline.svCalling.clever.threads">Germline.svCalling.clever.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The the number of threads required to run a program.
</dd>
<dt id="Germline.svCalling.clever.timeMinutes"><a href="#Germline.svCalling.clever.timeMinutes">Germline.svCalling.clever.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2200</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.delly.genotypeBcf"><a href="#Germline.svCalling.delly.genotypeBcf">Germline.svCalling.delly.genotypeBcf</a></dt>
<dd>
    <i>File? </i><br />
    A BCF with SVs to get genotyped in the samples.
</dd>
<dt id="Germline.svCalling.delly.genotypeBcfIndex"><a href="#Germline.svCalling.delly.genotypeBcfIndex">Germline.svCalling.delly.genotypeBcfIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the genotype BCF file.
</dd>
<dt id="Germline.svCalling.delly.memory"><a href="#Germline.svCalling.delly.memory">Germline.svCalling.delly.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"15GiB"</code><br />
    The memory required to run the programs.
</dd>
<dt id="Germline.svCalling.delly.timeMinutes"><a href="#Germline.svCalling.delly.timeMinutes">Germline.svCalling.delly.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>300</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.delly2vcf.exclude"><a href="#Germline.svCalling.delly2vcf.exclude">Germline.svCalling.delly2vcf.exclude</a></dt>
<dd>
    <i>String? </i><br />
    Exclude sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.delly2vcf.excludeUncalled"><a href="#Germline.svCalling.delly2vcf.excludeUncalled">Germline.svCalling.delly2vcf.excludeUncalled</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Exclude sites without a called genotype (see man page for details).
</dd>
<dt id="Germline.svCalling.delly2vcf.include"><a href="#Germline.svCalling.delly2vcf.include">Germline.svCalling.delly2vcf.include</a></dt>
<dd>
    <i>String? </i><br />
    Select sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.delly2vcf.memory"><a href="#Germline.svCalling.delly2vcf.memory">Germline.svCalling.delly2vcf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256MiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.delly2vcf.timeMinutes"><a href="#Germline.svCalling.delly2vcf.timeMinutes">Germline.svCalling.delly2vcf.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputFile,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.excludeMisHomRef"><a href="#Germline.svCalling.excludeMisHomRef">Germline.svCalling.excludeMisHomRef</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Option to exclude missing and homozygous reference genotypes.
</dd>
<dt id="Germline.svCalling.FilterShortReadsBam.memory"><a href="#Germline.svCalling.FilterShortReadsBam.memory">Germline.svCalling.FilterShortReadsBam.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1GiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.FilterShortReadsBam.timeMinutes"><a href="#Germline.svCalling.FilterShortReadsBam.timeMinutes">Germline.svCalling.FilterShortReadsBam.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(bamFile,"GiB") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.getIntersections.excludeUncalled"><a href="#Germline.svCalling.getIntersections.excludeUncalled">Germline.svCalling.getIntersections.excludeUncalled</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Exclude sites without a called genotype (see man page for details).
</dd>
<dt id="Germline.svCalling.getIntersections.include"><a href="#Germline.svCalling.getIntersections.include">Germline.svCalling.getIntersections.include</a></dt>
<dd>
    <i>String? </i><br />
    Select sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.getIntersections.memory"><a href="#Germline.svCalling.getIntersections.memory">Germline.svCalling.getIntersections.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256MiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.getIntersections.timeMinutes"><a href="#Germline.svCalling.getIntersections.timeMinutes">Germline.svCalling.getIntersections.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputFile,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.getSVtype.exclude"><a href="#Germline.svCalling.getSVtype.exclude">Germline.svCalling.getSVtype.exclude</a></dt>
<dd>
    <i>String? </i><br />
    Exclude sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.getSVtype.excludeUncalled"><a href="#Germline.svCalling.getSVtype.excludeUncalled">Germline.svCalling.getSVtype.excludeUncalled</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Exclude sites without a called genotype (see man page for details).
</dd>
<dt id="Germline.svCalling.getSVtype.memory"><a href="#Germline.svCalling.getSVtype.memory">Germline.svCalling.getSVtype.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256MiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.getSVtype.timeMinutes"><a href="#Germline.svCalling.getSVtype.timeMinutes">Germline.svCalling.getSVtype.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputFile,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.gridss.blacklistBed"><a href="#Germline.svCalling.gridss.blacklistBed">Germline.svCalling.gridss.blacklistBed</a></dt>
<dd>
    <i>File? </i><br />
    A bed file with blaclisted regins.
</dd>
<dt id="Germline.svCalling.gridss.gridssProperties"><a href="#Germline.svCalling.gridss.gridssProperties">Germline.svCalling.gridss.gridssProperties</a></dt>
<dd>
    <i>File? </i><br />
    A properties file for gridss.
</dd>
<dt id="Germline.svCalling.gridss.jvmHeapSizeGb"><a href="#Germline.svCalling.gridss.jvmHeapSizeGb">Germline.svCalling.gridss.jvmHeapSizeGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>64</code><br />
    The size of JVM heap for assembly and variant calling
</dd>
<dt id="Germline.svCalling.gridss.nonJvmMemoryGb"><a href="#Germline.svCalling.gridss.nonJvmMemoryGb">Germline.svCalling.gridss.nonJvmMemoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The amount of memory in Gb to be requested besides JVM memory.
</dd>
<dt id="Germline.svCalling.gridss.normalBai"><a href="#Germline.svCalling.gridss.normalBai">Germline.svCalling.gridss.normalBai</a></dt>
<dd>
    <i>File? </i><br />
    The index for normalBam.
</dd>
<dt id="Germline.svCalling.gridss.normalBam"><a href="#Germline.svCalling.gridss.normalBam">Germline.svCalling.gridss.normalBam</a></dt>
<dd>
    <i>File? </i><br />
    The BAM file for the normal/control sample.
</dd>
<dt id="Germline.svCalling.gridss.normalLabel"><a href="#Germline.svCalling.gridss.normalLabel">Germline.svCalling.gridss.normalLabel</a></dt>
<dd>
    <i>String? </i><br />
    The name of the normal sample.
</dd>
<dt id="Germline.svCalling.gridss.threads"><a href="#Germline.svCalling.gridss.threads">Germline.svCalling.gridss.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>12</code><br />
    The number of the threads to use.
</dd>
<dt id="Germline.svCalling.gridss.timeMinutes"><a href="#Germline.svCalling.gridss.timeMinutes">Germline.svCalling.gridss.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>ceil((7200 / threads)) + 1800</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.gridssSvTyped.dockerImage"><a href="#Germline.svCalling.gridssSvTyped.dockerImage">Germline.svCalling.gridssSvTyped.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/bioconductor-structuralvariantannotation:1.10.0--r41hdfd78af_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.svCalling.gridssSvTyped.memory"><a href="#Germline.svCalling.gridssSvTyped.memory">Germline.svCalling.gridssSvTyped.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32GiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.gridssSvTyped.timeMinutes"><a href="#Germline.svCalling.gridssSvTyped.timeMinutes">Germline.svCalling.gridssSvTyped.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>240</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.manta.timeMinutes"><a href="#Germline.svCalling.manta.timeMinutes">Germline.svCalling.manta.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2880</code><br />
    The maximum amount of time the job will run in minutes.
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
    <i>String </i><i>&mdash; Default:</i> <code>"250GiB"</code><br />
    The memory required to run the programs.
</dd>
<dt id="Germline.svCalling.mateclever.threads"><a href="#Germline.svCalling.mateclever.threads">Germline.svCalling.mateclever.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The the number of threads required to run a program.
</dd>
<dt id="Germline.svCalling.mateclever.timeMinutes"><a href="#Germline.svCalling.mateclever.timeMinutes">Germline.svCalling.mateclever.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2880</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.removeFpDupDel.exclude"><a href="#Germline.svCalling.removeFpDupDel.exclude">Germline.svCalling.removeFpDupDel.exclude</a></dt>
<dd>
    <i>String? </i><br />
    Exclude sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.removeFpDupDel.excludeUncalled"><a href="#Germline.svCalling.removeFpDupDel.excludeUncalled">Germline.svCalling.removeFpDupDel.excludeUncalled</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Exclude sites without a called genotype (see man page for details).
</dd>
<dt id="Germline.svCalling.removeFpDupDel.memory"><a href="#Germline.svCalling.removeFpDupDel.memory">Germline.svCalling.removeFpDupDel.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256MiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.removeFpDupDel.timeMinutes"><a href="#Germline.svCalling.removeFpDupDel.timeMinutes">Germline.svCalling.removeFpDupDel.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputFile,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.removeMisHomRR.include"><a href="#Germline.svCalling.removeMisHomRR.include">Germline.svCalling.removeMisHomRR.include</a></dt>
<dd>
    <i>String? </i><br />
    Select sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.removeMisHomRR.memory"><a href="#Germline.svCalling.removeMisHomRR.memory">Germline.svCalling.removeMisHomRR.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256MiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.removeMisHomRR.timeMinutes"><a href="#Germline.svCalling.removeMisHomRR.timeMinutes">Germline.svCalling.removeMisHomRR.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputFile,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.renameSample.javaXmx"><a href="#Germline.svCalling.renameSample.javaXmx">Germline.svCalling.renameSample.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="Germline.svCalling.renameSample.memory"><a href="#Germline.svCalling.renameSample.memory">Germline.svCalling.renameSample.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"9GiB"</code><br />
    The memory required to run the programs.
</dd>
<dt id="Germline.svCalling.renameSample.timeMinutes"><a href="#Germline.svCalling.renameSample.timeMinutes">Germline.svCalling.renameSample.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputVcf,"GiB") * 2))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.runClever"><a href="#Germline.svCalling.runClever">Germline.svCalling.runClever</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not to run clever.
</dd>
<dt id="Germline.svCalling.runDupHold"><a href="#Germline.svCalling.runDupHold">Germline.svCalling.runDupHold</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Option to run duphold annotation and filter FP deletions and duplications.
</dd>
<dt id="Germline.svCalling.runSmoove"><a href="#Germline.svCalling.runSmoove">Germline.svCalling.runSmoove</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not to run smoove.
</dd>
<dt id="Germline.svCalling.setId.collapse"><a href="#Germline.svCalling.setId.collapse">Germline.svCalling.setId.collapse</a></dt>
<dd>
    <i>String? </i><br />
    Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</dd>
<dt id="Germline.svCalling.setId.columns"><a href="#Germline.svCalling.setId.columns">Germline.svCalling.setId.columns</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Comma-separated list of columns or tags to carry over from the annotation file (see man page for details).
</dd>
<dt id="Germline.svCalling.setId.exclude"><a href="#Germline.svCalling.setId.exclude">Germline.svCalling.setId.exclude</a></dt>
<dd>
    <i>String? </i><br />
    Exclude sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.setId.force"><a href="#Germline.svCalling.setId.force">Germline.svCalling.setId.force</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Continue even when parsing errors, such as undefined tags, are encountered.
</dd>
<dt id="Germline.svCalling.setId.headerLines"><a href="#Germline.svCalling.setId.headerLines">Germline.svCalling.setId.headerLines</a></dt>
<dd>
    <i>File? </i><br />
    Lines to append to the VCF header (see man page for details).
</dd>
<dt id="Germline.svCalling.setId.include"><a href="#Germline.svCalling.setId.include">Germline.svCalling.setId.include</a></dt>
<dd>
    <i>String? </i><br />
    Select sites for which the expression is true (see man page for details).
</dd>
<dt id="Germline.svCalling.setId.keepSites"><a href="#Germline.svCalling.setId.keepSites">Germline.svCalling.setId.keepSites</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Keep sites which do not pass -i and -e expressions instead of discarding them.
</dd>
<dt id="Germline.svCalling.setId.markSites"><a href="#Germline.svCalling.setId.markSites">Germline.svCalling.setId.markSites</a></dt>
<dd>
    <i>String? </i><br />
    Annotate sites which are present ('+') or absent ('-') in the -a file with a new INFO/TAG flag.
</dd>
<dt id="Germline.svCalling.setId.memory"><a href="#Germline.svCalling.setId.memory">Germline.svCalling.setId.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4GiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.setId.noVersion"><a href="#Germline.svCalling.setId.noVersion">Germline.svCalling.setId.noVersion</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Do not append version and command line information to the output VCF header.
</dd>
<dt id="Germline.svCalling.setId.regions"><a href="#Germline.svCalling.setId.regions">Germline.svCalling.setId.regions</a></dt>
<dd>
    <i>String? </i><br />
    Restrict to comma-separated list of regions.
</dd>
<dt id="Germline.svCalling.setId.regionsFile"><a href="#Germline.svCalling.setId.regionsFile">Germline.svCalling.setId.regionsFile</a></dt>
<dd>
    <i>File? </i><br />
    Restrict to regions listed in a file.
</dd>
<dt id="Germline.svCalling.setId.removeAnns"><a href="#Germline.svCalling.setId.removeAnns">Germline.svCalling.setId.removeAnns</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    List of annotations to remove (see man page for details).
</dd>
<dt id="Germline.svCalling.setId.renameChrs"><a href="#Germline.svCalling.setId.renameChrs">Germline.svCalling.setId.renameChrs</a></dt>
<dd>
    <i>File? </i><br />
    rename chromosomes according to the map in file (see man page for details).
</dd>
<dt id="Germline.svCalling.setId.samples"><a href="#Germline.svCalling.setId.samples">Germline.svCalling.setId.samples</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    List of samples for sample stats, "-" to include all samples.
</dd>
<dt id="Germline.svCalling.setId.samplesFile"><a href="#Germline.svCalling.setId.samplesFile">Germline.svCalling.setId.samplesFile</a></dt>
<dd>
    <i>File? </i><br />
    File of samples to include.
</dd>
<dt id="Germline.svCalling.setId.singleOverlaps"><a href="#Germline.svCalling.setId.singleOverlaps">Germline.svCalling.setId.singleOverlaps</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    keep memory requirements low with very large annotation files.
</dd>
<dt id="Germline.svCalling.setId.threads"><a href="#Germline.svCalling.setId.threads">Germline.svCalling.setId.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>0</code><br />
    Number of extra decompression threads [0].
</dd>
<dt id="Germline.svCalling.setId.timeMinutes"><a href="#Germline.svCalling.setId.timeMinutes">Germline.svCalling.setId.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>60 + ceil(size(inputFile,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.smoove.memory"><a href="#Germline.svCalling.smoove.memory">Germline.svCalling.smoove.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"15GiB"</code><br />
    The memory required to run the programs.
</dd>
<dt id="Germline.svCalling.smoove.timeMinutes"><a href="#Germline.svCalling.smoove.timeMinutes">Germline.svCalling.smoove.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1440</code><br />
    The maximum duration (in minutes) the tool is allowed to run.
</dd>
<dt id="Germline.svCalling.sort.memory"><a href="#Germline.svCalling.sort.memory">Germline.svCalling.sort.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5GiB"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="Germline.svCalling.sort.timeMinutes"><a href="#Germline.svCalling.sort.timeMinutes">Germline.svCalling.sort.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputFile,"G")) * 5</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.survivor.breakpointDistance"><a href="#Germline.svCalling.survivor.breakpointDistance">Germline.svCalling.survivor.breakpointDistance</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    The distance between pairwise breakpoints between SVs.
</dd>
<dt id="Germline.svCalling.survivor.distanceBySvSize"><a href="#Germline.svCalling.survivor.distanceBySvSize">Germline.svCalling.survivor.distanceBySvSize</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    A boolean to predict the pairwise distance between the SVs based on their size.
</dd>
<dt id="Germline.svCalling.survivor.memory"><a href="#Germline.svCalling.survivor.memory">Germline.svCalling.survivor.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24GiB"</code><br />
    The memory required to run the programs.
</dd>
<dt id="Germline.svCalling.survivor.minSize"><a href="#Germline.svCalling.survivor.minSize">Germline.svCalling.survivor.minSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>30</code><br />
    The mimimum size of SV to be merged.
</dd>
<dt id="Germline.svCalling.survivor.strandType"><a href="#Germline.svCalling.survivor.strandType">Germline.svCalling.survivor.strandType</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    A boolean to include strand type of an SV to be merged.
</dd>
<dt id="Germline.svCalling.survivor.svType"><a href="#Germline.svCalling.survivor.svType">Germline.svCalling.survivor.svType</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    A boolean to include the type SV to be merged.
</dd>
<dt id="Germline.svCalling.survivor.timeMinutes"><a href="#Germline.svCalling.survivor.timeMinutes">Germline.svCalling.survivor.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>60</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.svCalling.svtypes"><a href="#Germline.svCalling.svtypes">Germline.svCalling.svtypes</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>["DEL", "DUP", "INS", "INV", "BND"]</code><br />
    List of svtypes to be further processed and output by the pipeline.
</dd>
<dt id="Germline.tabix.dockerImage"><a href="#Germline.tabix.dockerImage">Germline.tabix.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/tabix:0.2.6--ha92aebf_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="Germline.tabix.timeMinutes"><a href="#Germline.tabix.timeMinutes">Germline.tabix.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputFile,"GiB") * 2))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="Germline.useBwaKit"><a href="#Germline.useBwaKit">Germline.useBwaKit</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not BWA kit should be used. If false BWA mem will be used.
</dd>
</dl>
</details>





## Do not set these inputs!
The following inputs should ***not*** be set, even though womtool may
show them as being available inputs.

* Germline.sampleWorkflow.DONOTDEFINE
* Germline.sampleWorkflow.qualityControl.FastqcRead1.noneArray
* Germline.sampleWorkflow.qualityControl.FastqcRead1.noneFile
* Germline.sampleWorkflow.qualityControl.FastqcRead2.noneArray
* Germline.sampleWorkflow.qualityControl.FastqcRead2.noneFile
* Germline.sampleWorkflow.qualityControl.FastqcRead1After.noneArray
* Germline.sampleWorkflow.qualityControl.FastqcRead1After.noneFile
* Germline.sampleWorkflow.qualityControl.FastqcRead2After.noneArray
* Germline.sampleWorkflow.qualityControl.FastqcRead2After.noneFile
