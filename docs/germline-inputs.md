# Germline


## Inputs


### Required inputs
<p name="Germline.dbsnpVCF">
        <b>Germline.dbsnpVCF</b><br />
        <i>File &mdash; Default: None</i><br />
        dbsnp VCF file used for checking known sites.
</p>
<p name="Germline.dbsnpVCFIndex">
        <b>Germline.dbsnpVCFIndex</b><br />
        <i>File &mdash; Default: None</i><br />
        Index (.tbi) file for the dbsnp VCF.
</p>
<p name="Germline.dockerImagesFile">
        <b>Germline.dockerImagesFile</b><br />
        <i>File &mdash; Default: None</i><br />
        A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.
</p>
<p name="Germline.referenceFasta">
        <b>Germline.referenceFasta</b><br />
        <i>File &mdash; Default: None</i><br />
        The reference fasta file.
</p>
<p name="Germline.referenceFastaDict">
        <b>Germline.referenceFastaDict</b><br />
        <i>File &mdash; Default: None</i><br />
        Sequence dictionary (.dict) file of the reference.
</p>
<p name="Germline.referenceFastaFai">
        <b>Germline.referenceFastaFai</b><br />
        <i>File &mdash; Default: None</i><br />
        Fasta index (.fai) file of the reference.
</p>
<p name="Germline.sampleConfigFile">
        <b>Germline.sampleConfigFile</b><br />
        <i>File &mdash; Default: None</i><br />
        The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.
</p>
<p name="Germline.svCalling.manta.cores">
        <b>Germline.svCalling.manta.cores</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The the number of cores required to run a program
</p>
<p name="Germline.svCalling.manta.memoryGb">
        <b>Germline.svCalling.manta.memoryGb</b><br />
        <i>Int &mdash; Default: 4</i><br />
        The memory required to run the manta
</p>

### Other common inputs
<p name="Germline.adapterForward">
        <b>Germline.adapterForward</b><br />
        <i>String? &mdash; Default: "AGATCGGAAGAG"</i><br />
        The adapter to be removed from the reads first or single end reads.
</p>
<p name="Germline.adapterReverse">
        <b>Germline.adapterReverse</b><br />
        <i>String? &mdash; Default: "AGATCGGAAGAG"</i><br />
        The adapter to be removed from the reads second end reads.
</p>
<p name="Germline.bwaIndex">
        <b>Germline.bwaIndex</b><br />
        <i>struct(fastaFile : File, indexFiles : Array[File])? &mdash; Default: None</i><br />
        The BWA index files. When these are provided BWA will be used.
</p>
<p name="Germline.bwaMem2Index">
        <b>Germline.bwaMem2Index</b><br />
        <i>struct(fastaFile : File, indexFiles : Array[File])? &mdash; Default: None</i><br />
        The bwa-mem2 index files. When these are provided bwa-mem2 will be used.
</p>
<p name="Germline.jointgenotyping">
        <b>Germline.jointgenotyping</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Whether to perform jointgenotyping (using HaplotypeCaller to call GVCFs and merge them with GenotypeGVCFs) or not.
</p>
<p name="Germline.JointGenotyping.genotypeGvcfs.pedigree">
        <b>Germline.JointGenotyping.genotypeGvcfs.pedigree</b><br />
        <i>File? &mdash; Default: None</i><br />
        Pedigree file for determining the population "founders".
</p>
<p name="Germline.JointGenotyping.Stats.compareVcf">
        <b>Germline.JointGenotyping.Stats.compareVcf</b><br />
        <i>File? &mdash; Default: None</i><br />
        When inputVcf and compareVCF are given, the program generates separate stats for intersection and the complements. By default only sites are compared, samples must be given to include also sample columns.
</p>
<p name="Germline.JointGenotyping.Stats.compareVcfIndex">
        <b>Germline.JointGenotyping.Stats.compareVcfIndex</b><br />
        <i>File? &mdash; Default: None</i><br />
        Index for the compareVcf.
</p>
<p name="Germline.outputDir">
        <b>Germline.outputDir</b><br />
        <i>String &mdash; Default: "."</i><br />
        The directory the output should be written to.
</p>
<p name="Germline.regions">
        <b>Germline.regions</b><br />
        <i>File? &mdash; Default: None</i><br />
        A bed file describing the regions to call variants for.
</p>
<p name="Germline.sampleWorkflow.bqsr.splitSplicedReads">
        <b>Germline.sampleWorkflow.bqsr.splitSplicedReads</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not gatk's SplitNCgarReads should be run to split spliced reads. This should be enabled for RNAseq samples.
</p>
<p name="Germline.sampleWorkflow.bwaMem.sixtyFour">
        <b>Germline.sampleWorkflow.bwaMem.sixtyFour</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not the index uses the '.64' suffixes.
</p>
<p name="Germline.sampleWorkflow.bwamem2Mem.sixtyFour">
        <b>Germline.sampleWorkflow.bwamem2Mem.sixtyFour</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not the index uses the '.64' suffixes.
</p>
<p name="Germline.sampleWorkflow.metrics.ampliconIntervals">
        <b>Germline.sampleWorkflow.metrics.ampliconIntervals</b><br />
        <i>File? &mdash; Default: None</i><br />
        An interval list describinig the coordinates of the amplicons sequenced. This should only be used for targeted sequencing or WES. Required if `ampliconIntervals` is defined.
</p>
<p name="Germline.sampleWorkflow.metrics.refRefflat">
        <b>Germline.sampleWorkflow.metrics.refRefflat</b><br />
        <i>File? &mdash; Default: None</i><br />
        A refflat file containing gene annotations. If defined RNA sequencing metrics will be collected.
</p>
<p name="Germline.sampleWorkflow.metrics.strandedness">
        <b>Germline.sampleWorkflow.metrics.strandedness</b><br />
        <i>String &mdash; Default: "None"</i><br />
        The strandedness of the RNA sequencing library preparation. One of "None" (unstranded), "FR" (forward-reverse: first read equal transcript) or "RF" (reverse-forward: second read equals transcript).
</p>
<p name="Germline.sampleWorkflow.metrics.targetIntervals">
        <b>Germline.sampleWorkflow.metrics.targetIntervals</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        An interval list describing the coordinates of the targets sequenced. This should only be used for targeted sequencing or WES. If defined targeted PCR metrics will be collected. Requires `ampliconIntervals` to also be defined.
</p>
<p name="Germline.sampleWorkflow.qualityControl.contaminations">
        <b>Germline.sampleWorkflow.qualityControl.contaminations</b><br />
        <i>Array[String]+? &mdash; Default: None</i><br />
        Contaminants/adapters to be removed from the reads.
</p>
<p name="Germline.sampleWorkflow.qualityControl.readgroupName">
        <b>Germline.sampleWorkflow.qualityControl.readgroupName</b><br />
        <i>String &mdash; Default: sub(basename(read1),"(\.fq)?(\.fastq)?(\.gz)?","")</i><br />
        The name of the readgroup.
</p>
<p name="Germline.singleSampleCalling.callAutosomal.excludeIntervalList">
        <b>Germline.singleSampleCalling.callAutosomal.excludeIntervalList</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        Bed files or interval lists describing the regions to NOT operate on.
</p>
<p name="Germline.singleSampleCalling.callAutosomal.pedigree">
        <b>Germline.singleSampleCalling.callAutosomal.pedigree</b><br />
        <i>File? &mdash; Default: None</i><br />
        Pedigree file for determining the population "founders".
</p>
<p name="Germline.singleSampleCalling.callAutosomal.ploidy">
        <b>Germline.singleSampleCalling.callAutosomal.ploidy</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The ploidy with which the variants should be called.
</p>
<p name="Germline.singleSampleCalling.callX.excludeIntervalList">
        <b>Germline.singleSampleCalling.callX.excludeIntervalList</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        Bed files or interval lists describing the regions to NOT operate on.
</p>
<p name="Germline.singleSampleCalling.callX.pedigree">
        <b>Germline.singleSampleCalling.callX.pedigree</b><br />
        <i>File? &mdash; Default: None</i><br />
        Pedigree file for determining the population "founders".
</p>
<p name="Germline.singleSampleCalling.callY.excludeIntervalList">
        <b>Germline.singleSampleCalling.callY.excludeIntervalList</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        Bed files or interval lists describing the regions to NOT operate on.
</p>
<p name="Germline.singleSampleCalling.callY.pedigree">
        <b>Germline.singleSampleCalling.callY.pedigree</b><br />
        <i>File? &mdash; Default: None</i><br />
        Pedigree file for determining the population "founders".
</p>
<p name="Germline.singleSampleCalling.dontUseSoftClippedBases">
        <b>Germline.singleSampleCalling.dontUseSoftClippedBases</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether soft-clipped bases should be excluded from the haplotype caller analysis (should be set to 'true' for RNA).
</p>
<p name="Germline.singleSampleCalling.Stats.compareVcf">
        <b>Germline.singleSampleCalling.Stats.compareVcf</b><br />
        <i>File? &mdash; Default: None</i><br />
        When inputVcf and compareVCF are given, the program generates separate stats for intersection and the complements. By default only sites are compared, samples must be given to include also sample columns.
</p>
<p name="Germline.singleSampleCalling.Stats.compareVcfIndex">
        <b>Germline.singleSampleCalling.Stats.compareVcfIndex</b><br />
        <i>File? &mdash; Default: None</i><br />
        Index for the compareVcf.
</p>
<p name="Germline.singleSampleGvcf">
        <b>Germline.singleSampleGvcf</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to output single-sample gvcfs.
</p>
<p name="Germline.svCalling.manta.callRegions">
        <b>Germline.svCalling.manta.callRegions</b><br />
        <i>File? &mdash; Default: None</i><br />
        The bed file which indicates the regions to operate on.
</p>
<p name="Germline.svCalling.manta.callRegionsIndex">
        <b>Germline.svCalling.manta.callRegionsIndex</b><br />
        <i>File? &mdash; Default: None</i><br />
        The index of the bed file which indicates the regions to operate on.
</p>
<p name="Germline.svCalling.manta.exome">
        <b>Germline.svCalling.manta.exome</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not the data is from exome sequencing.
</p>
<p name="Germline.XNonParRegions">
        <b>Germline.XNonParRegions</b><br />
        <i>File? &mdash; Default: None</i><br />
        Bed file with the non-PAR regions of X.
</p>
<p name="Germline.YNonParRegions">
        <b>Germline.YNonParRegions</b><br />
        <i>File? &mdash; Default: None</i><br />
        Bed file with the non-PAR regions of Y.
</p>

### Advanced inputs
<details>
<summary> Show/Hide </summary>
<p name="Germline.bwaThreads">
        <b>Germline.bwaThreads</b><br />
        <i>Int &mdash; Default: 4</i><br />
        The amount of threads for the alignment process.
</p>
<p name="Germline.calculateRegions.intersectAutosomalRegions.memory">
        <b>Germline.calculateRegions.intersectAutosomalRegions.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([regionsA, regionsB],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="Germline.calculateRegions.intersectAutosomalRegions.timeMinutes">
        <b>Germline.calculateRegions.intersectAutosomalRegions.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([regionsA, regionsB],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.calculateRegions.intersectX.memory">
        <b>Germline.calculateRegions.intersectX.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([regionsA, regionsB],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="Germline.calculateRegions.intersectX.timeMinutes">
        <b>Germline.calculateRegions.intersectX.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([regionsA, regionsB],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.calculateRegions.intersectY.memory">
        <b>Germline.calculateRegions.intersectY.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([regionsA, regionsB],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="Germline.calculateRegions.intersectY.timeMinutes">
        <b>Germline.calculateRegions.intersectY.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([regionsA, regionsB],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.calculateRegions.inverseBed.memory">
        <b>Germline.calculateRegions.inverseBed.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([inputBed, faidx],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="Germline.calculateRegions.inverseBed.timeMinutes">
        <b>Germline.calculateRegions.inverseBed.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([inputBed, faidx],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.calculateRegions.mergeBeds.memory">
        <b>Germline.calculateRegions.mergeBeds.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size(bedFiles,"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="Germline.calculateRegions.mergeBeds.outputBed">
        <b>Germline.calculateRegions.mergeBeds.outputBed</b><br />
        <i>String &mdash; Default: "merged.bed"</i><br />
        The path to write the output to.
</p>
<p name="Germline.calculateRegions.mergeBeds.timeMinutes">
        <b>Germline.calculateRegions.mergeBeds.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(bedFiles,"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.calculateRegions.scatterAutosomalRegions.memory">
        <b>Germline.calculateRegions.scatterAutosomalRegions.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.calculateRegions.scatterAutosomalRegions.prefix">
        <b>Germline.calculateRegions.scatterAutosomalRegions.prefix</b><br />
        <i>String &mdash; Default: "scatters/scatter-"</i><br />
        The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</p>
<p name="Germline.calculateRegions.scatterAutosomalRegions.splitContigs">
        <b>Germline.calculateRegions.scatterAutosomalRegions.splitContigs</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        If set, contigs are allowed to be split up over multiple files.
</p>
<p name="Germline.calculateRegions.scatterAutosomalRegions.timeMinutes">
        <b>Germline.calculateRegions.scatterAutosomalRegions.timeMinutes</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.convertDockerImagesFile.dockerImage">
        <b>Germline.convertDockerImagesFile.dockerImage</b><br />
        <i>String &mdash; Default: "quay.io/biocontainers/biowdl-input-converter:0.2.1--py_0"</i><br />
        The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</p>
<p name="Germline.convertDockerImagesFile.memory">
        <b>Germline.convertDockerImagesFile.memory</b><br />
        <i>String &mdash; Default: "128M"</i><br />
        The maximum amount of memory the job will need.
</p>
<p name="Germline.convertDockerImagesFile.outputJson">
        <b>Germline.convertDockerImagesFile.outputJson</b><br />
        <i>String &mdash; Default: basename(yaml,"\.ya?ml$") + ".json"</i><br />
        The location the output JSON file should be written to.
</p>
<p name="Germline.convertDockerImagesFile.timeMinutes">
        <b>Germline.convertDockerImagesFile.timeMinutes</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.convertSampleConfig.checkFileMd5sums">
        <b>Germline.convertSampleConfig.checkFileMd5sums</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not the MD5 sums of the files mentioned in the samplesheet should be checked.
</p>
<p name="Germline.convertSampleConfig.memory">
        <b>Germline.convertSampleConfig.memory</b><br />
        <i>String &mdash; Default: "128M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="Germline.convertSampleConfig.old">
        <b>Germline.convertSampleConfig.old</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not the old samplesheet format should be used.
</p>
<p name="Germline.convertSampleConfig.outputFile">
        <b>Germline.convertSampleConfig.outputFile</b><br />
        <i>String &mdash; Default: "samplesheet.json"</i><br />
        The location the JSON representation of the samplesheet should be written to.
</p>
<p name="Germline.convertSampleConfig.skipFileCheck">
        <b>Germline.convertSampleConfig.skipFileCheck</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Whether or not the existance of the files mentioned in the samplesheet should be checked.
</p>
<p name="Germline.convertSampleConfig.timeMinutes">
        <b>Germline.convertSampleConfig.timeMinutes</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.JointGenotyping.gatherGvcfs.intervals">
        <b>Germline.JointGenotyping.gatherGvcfs.intervals</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        Bed files or interval lists describing the regions to operate on.
</p>
<p name="Germline.JointGenotyping.gatherGvcfs.javaXmx">
        <b>Germline.JointGenotyping.gatherGvcfs.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.JointGenotyping.gatherGvcfs.memory">
        <b>Germline.JointGenotyping.gatherGvcfs.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.JointGenotyping.gatherGvcfs.timeMinutes">
        <b>Germline.JointGenotyping.gatherGvcfs.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(gvcfFiles,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.JointGenotyping.gatherVcfs.compressionLevel">
        <b>Germline.JointGenotyping.gatherVcfs.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level at which the BAM files are written.
</p>
<p name="Germline.JointGenotyping.gatherVcfs.javaXmx">
        <b>Germline.JointGenotyping.gatherVcfs.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.JointGenotyping.gatherVcfs.memory">
        <b>Germline.JointGenotyping.gatherVcfs.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.JointGenotyping.gatherVcfs.timeMinutes">
        <b>Germline.JointGenotyping.gatherVcfs.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputVCFs,"G")) * 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.JointGenotyping.gatherVcfs.useJdkDeflater">
        <b>Germline.JointGenotyping.gatherVcfs.useJdkDeflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</p>
<p name="Germline.JointGenotyping.gatherVcfs.useJdkInflater">
        <b>Germline.JointGenotyping.gatherVcfs.useJdkInflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java inflater. False, uses the optimized intel inflater.
</p>
<p name="Germline.JointGenotyping.genotypeGvcfs.annotationGroups">
        <b>Germline.JointGenotyping.genotypeGvcfs.annotationGroups</b><br />
        <i>Array[String] &mdash; Default: ["StandardAnnotation"]</i><br />
        Which annotation groups will be used for the annotation.
</p>
<p name="Germline.JointGenotyping.genotypeGvcfs.javaXmx">
        <b>Germline.JointGenotyping.genotypeGvcfs.javaXmx</b><br />
        <i>String &mdash; Default: "6G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.JointGenotyping.genotypeGvcfs.memory">
        <b>Germline.JointGenotyping.genotypeGvcfs.memory</b><br />
        <i>String &mdash; Default: "7G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.JointGenotyping.genotypeGvcfs.timeMinutes">
        <b>Germline.JointGenotyping.genotypeGvcfs.timeMinutes</b><br />
        <i>Int &mdash; Default: 120</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.JointGenotyping.scatterRegions.memory">
        <b>Germline.JointGenotyping.scatterRegions.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.JointGenotyping.scatterRegions.prefix">
        <b>Germline.JointGenotyping.scatterRegions.prefix</b><br />
        <i>String &mdash; Default: "scatters/scatter-"</i><br />
        The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</p>
<p name="Germline.JointGenotyping.scatterRegions.splitContigs">
        <b>Germline.JointGenotyping.scatterRegions.splitContigs</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        If set, contigs are allowed to be split up over multiple files.
</p>
<p name="Germline.JointGenotyping.scatterRegions.timeMinutes">
        <b>Germline.JointGenotyping.scatterRegions.timeMinutes</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.JointGenotyping.scatterSizeMillions">
        <b>Germline.JointGenotyping.scatterSizeMillions</b><br />
        <i>Int &mdash; Default: 1000</i><br />
        Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily
</p>
<p name="Germline.JointGenotyping.Stats.afBins">
        <b>Germline.JointGenotyping.Stats.afBins</b><br />
        <i>String? &mdash; Default: None</i><br />
        Allele frequency bins, a list (0.1,0.5,1) or a file (0.1
0.5
1).
</p>
<p name="Germline.JointGenotyping.Stats.applyFilters">
        <b>Germline.JointGenotyping.Stats.applyFilters</b><br />
        <i>String? &mdash; Default: None</i><br />
        Require at least one of the listed FILTER strings (e.g. "PASS,.").
</p>
<p name="Germline.JointGenotyping.Stats.collapse">
        <b>Germline.JointGenotyping.Stats.collapse</b><br />
        <i>String? &mdash; Default: None</i><br />
        Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</p>
<p name="Germline.JointGenotyping.Stats.depth">
        <b>Germline.JointGenotyping.Stats.depth</b><br />
        <i>String? &mdash; Default: None</i><br />
        Depth distribution: min,max,bin size [0,500,1].
</p>
<p name="Germline.JointGenotyping.Stats.exclude">
        <b>Germline.JointGenotyping.Stats.exclude</b><br />
        <i>String? &mdash; Default: None</i><br />
        Exclude sites for which the expression is true (see man page for details).
</p>
<p name="Germline.JointGenotyping.Stats.exons">
        <b>Germline.JointGenotyping.Stats.exons</b><br />
        <i>File? &mdash; Default: None</i><br />
        Tab-delimited file with exons for indel frameshifts (chr,from,to; 1-based, inclusive, bgzip compressed).
</p>
<p name="Germline.JointGenotyping.Stats.firstAlleleOnly">
        <b>Germline.JointGenotyping.Stats.firstAlleleOnly</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Include only 1st allele at multiallelic sites.
</p>
<p name="Germline.JointGenotyping.Stats.include">
        <b>Germline.JointGenotyping.Stats.include</b><br />
        <i>String? &mdash; Default: None</i><br />
        Select sites for which the expression is true (see man page for details).
</p>
<p name="Germline.JointGenotyping.Stats.memory">
        <b>Germline.JointGenotyping.Stats.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.JointGenotyping.Stats.regions">
        <b>Germline.JointGenotyping.Stats.regions</b><br />
        <i>String? &mdash; Default: None</i><br />
        Restrict to comma-separated list of regions.
</p>
<p name="Germline.JointGenotyping.Stats.samplesFile">
        <b>Germline.JointGenotyping.Stats.samplesFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        File of samples to include.
</p>
<p name="Germline.JointGenotyping.Stats.splitByID">
        <b>Germline.JointGenotyping.Stats.splitByID</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Collect stats for sites with ID separately (known vs novel).
</p>
<p name="Germline.JointGenotyping.Stats.targets">
        <b>Germline.JointGenotyping.Stats.targets</b><br />
        <i>String? &mdash; Default: None</i><br />
        Similar to regions but streams rather than index-jumps.
</p>
<p name="Germline.JointGenotyping.Stats.targetsFile">
        <b>Germline.JointGenotyping.Stats.targetsFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        Similar to regionsFile but streams rather than index-jumps.
</p>
<p name="Germline.JointGenotyping.Stats.threads">
        <b>Germline.JointGenotyping.Stats.threads</b><br />
        <i>Int &mdash; Default: 0</i><br />
        Number of extra decompression threads [0].
</p>
<p name="Germline.JointGenotyping.Stats.timeMinutes">
        <b>Germline.JointGenotyping.Stats.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + 2 * ceil(size(select_all([inputVcf, compareVcf]),"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.JointGenotyping.Stats.userTsTv">
        <b>Germline.JointGenotyping.Stats.userTsTv</b><br />
        <i>String? &mdash; Default: None</i><br />
        <TAG[:min:max:n]>. Collect Ts/Tv stats for any tag using the given binning [0:1:100].
</p>
<p name="Germline.JointGenotyping.Stats.verbose">
        <b>Germline.JointGenotyping.Stats.verbose</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Produce verbose per-site and per-sample output.
</p>
<p name="Germline.multiqcTask.clConfig">
        <b>Germline.multiqcTask.clConfig</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--cl-config` option.
</p>
<p name="Germline.multiqcTask.comment">
        <b>Germline.multiqcTask.comment</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--comment` option.
</p>
<p name="Germline.multiqcTask.config">
        <b>Germline.multiqcTask.config</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--config` option.
</p>
<p name="Germline.multiqcTask.dataDir">
        <b>Germline.multiqcTask.dataDir</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to output a data dir. Sets `--data-dir` or `--no-data-dir` flag.
</p>
<p name="Germline.multiqcTask.dataFormat">
        <b>Germline.multiqcTask.dataFormat</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--data-format` option.
</p>
<p name="Germline.multiqcTask.dirs">
        <b>Germline.multiqcTask.dirs</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--dirs` flag.
</p>
<p name="Germline.multiqcTask.dirsDepth">
        <b>Germline.multiqcTask.dirsDepth</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--dirs-depth` option.
</p>
<p name="Germline.multiqcTask.exclude">
        <b>Germline.multiqcTask.exclude</b><br />
        <i>Array[String]+? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--exclude` option.
</p>
<p name="Germline.multiqcTask.export">
        <b>Germline.multiqcTask.export</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--export` flag.
</p>
<p name="Germline.multiqcTask.fileList">
        <b>Germline.multiqcTask.fileList</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--file-list` option.
</p>
<p name="Germline.multiqcTask.fileName">
        <b>Germline.multiqcTask.fileName</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--filename` option.
</p>
<p name="Germline.multiqcTask.flat">
        <b>Germline.multiqcTask.flat</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--flat` flag.
</p>
<p name="Germline.multiqcTask.force">
        <b>Germline.multiqcTask.force</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--force` flag.
</p>
<p name="Germline.multiqcTask.fullNames">
        <b>Germline.multiqcTask.fullNames</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--fullnames` flag.
</p>
<p name="Germline.multiqcTask.ignore">
        <b>Germline.multiqcTask.ignore</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--ignore` option.
</p>
<p name="Germline.multiqcTask.ignoreSamples">
        <b>Germline.multiqcTask.ignoreSamples</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--ignore-samples` option.
</p>
<p name="Germline.multiqcTask.interactive">
        <b>Germline.multiqcTask.interactive</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to MultiQC's `--interactive` flag.
</p>
<p name="Germline.multiqcTask.lint">
        <b>Germline.multiqcTask.lint</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--lint` flag.
</p>
<p name="Germline.multiqcTask.megaQCUpload">
        <b>Germline.multiqcTask.megaQCUpload</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Opposite to MultiQC's `--no-megaqc-upload` flag.
</p>
<p name="Germline.multiqcTask.memory">
        <b>Germline.multiqcTask.memory</b><br />
        <i>String? &mdash; Default: None</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.multiqcTask.module">
        <b>Germline.multiqcTask.module</b><br />
        <i>Array[String]+? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--module` option.
</p>
<p name="Germline.multiqcTask.pdf">
        <b>Germline.multiqcTask.pdf</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--pdf` flag.
</p>
<p name="Germline.multiqcTask.sampleNames">
        <b>Germline.multiqcTask.sampleNames</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--sample-names` option.
</p>
<p name="Germline.multiqcTask.tag">
        <b>Germline.multiqcTask.tag</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--tag` option.
</p>
<p name="Germline.multiqcTask.template">
        <b>Germline.multiqcTask.template</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--template` option.
</p>
<p name="Germline.multiqcTask.timeMinutes">
        <b>Germline.multiqcTask.timeMinutes</b><br />
        <i>Int &mdash; Default: 2 + ceil((size(reports,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.multiqcTask.title">
        <b>Germline.multiqcTask.title</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--title` option.
</p>
<p name="Germline.multiqcTask.zipDataDir">
        <b>Germline.multiqcTask.zipDataDir</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to MultiQC's `--zip-data-dir` flag.
</p>
<p name="Germline.platform">
        <b>Germline.platform</b><br />
        <i>String &mdash; Default: "illumina"</i><br />
        The platform used for sequencing.
</p>
<p name="Germline.runSVcalling">
        <b>Germline.runSVcalling</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not Structural-variantcalling should be run.
</p>
<p name="Germline.sampleWorkflow.bqsr.applyBqsr.javaXmxMb">
        <b>Germline.sampleWorkflow.bqsr.applyBqsr.javaXmxMb</b><br />
        <i>Int &mdash; Default: 2048</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.bqsr.applyBqsr.memoryMb">
        <b>Germline.sampleWorkflow.bqsr.applyBqsr.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.sampleWorkflow.bqsr.baseRecalibrator.javaXmxMb">
        <b>Germline.sampleWorkflow.bqsr.baseRecalibrator.javaXmxMb</b><br />
        <i>Int &mdash; Default: 1024</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes">
        <b>Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFIndexes</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        The indexed for the known variant VCFs.
</p>
<p name="Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFs">
        <b>Germline.sampleWorkflow.bqsr.baseRecalibrator.knownIndelsSitesVCFs</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        VCF files with known indels.
</p>
<p name="Germline.sampleWorkflow.bqsr.baseRecalibrator.memoryMb">
        <b>Germline.sampleWorkflow.bqsr.baseRecalibrator.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBamFiles.compressionLevel">
        <b>Germline.sampleWorkflow.bqsr.gatherBamFiles.compressionLevel</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The compression level of the output BAM.
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBamFiles.createMd5File">
        <b>Germline.sampleWorkflow.bqsr.gatherBamFiles.createMd5File</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBamFiles.javaXmxMb">
        <b>Germline.sampleWorkflow.bqsr.gatherBamFiles.javaXmxMb</b><br />
        <i>Int &mdash; Default: 1024</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBamFiles.memoryMb">
        <b>Germline.sampleWorkflow.bqsr.gatherBamFiles.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBamFiles.timeMinutes">
        <b>Germline.sampleWorkflow.bqsr.gatherBamFiles.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBams,"G") * 1))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBqsr.javaXmxMb">
        <b>Germline.sampleWorkflow.bqsr.gatherBqsr.javaXmxMb</b><br />
        <i>Int &mdash; Default: 256</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBqsr.memoryMb">
        <b>Germline.sampleWorkflow.bqsr.gatherBqsr.memoryMb</b><br />
        <i>Int &mdash; Default: 256 + javaXmxMb</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.sampleWorkflow.bqsr.gatherBqsr.timeMinutes">
        <b>Germline.sampleWorkflow.bqsr.gatherBqsr.timeMinutes</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.bqsr.splitNCigarReads.javaXmx">
        <b>Germline.sampleWorkflow.bqsr.splitNCigarReads.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.bqsr.splitNCigarReads.memory">
        <b>Germline.sampleWorkflow.bqsr.splitNCigarReads.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.bwaMem.compressionLevel">
        <b>Germline.sampleWorkflow.bwaMem.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level of the output BAM.
</p>
<p name="Germline.sampleWorkflow.bwaMem.memoryGb">
        <b>Germline.sampleWorkflow.bwaMem.memoryGb</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The amount of memory this job will use in gigabytes.
</p>
<p name="Germline.sampleWorkflow.bwaMem.sortMemoryPerThreadGb">
        <b>Germline.sampleWorkflow.bwaMem.sortMemoryPerThreadGb</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The amount of memory for each sorting thread in gigabytes.
</p>
<p name="Germline.sampleWorkflow.bwaMem.sortThreads">
        <b>Germline.sampleWorkflow.bwaMem.sortThreads</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The number of threads to use for sorting.
</p>
<p name="Germline.sampleWorkflow.bwaMem.timeMinutes">
        <b>Germline.sampleWorkflow.bwaMem.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size([read1, read2],"G") * 220 / threads))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.bwamem2Mem.compressionLevel">
        <b>Germline.sampleWorkflow.bwamem2Mem.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level of the output BAM.
</p>
<p name="Germline.sampleWorkflow.bwamem2Mem.memoryGb">
        <b>Germline.sampleWorkflow.bwamem2Mem.memoryGb</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The amount of memory this job will use in gigabytes.
</p>
<p name="Germline.sampleWorkflow.bwamem2Mem.sortMemoryPerThreadGb">
        <b>Germline.sampleWorkflow.bwamem2Mem.sortMemoryPerThreadGb</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The amount of memory for each sorting thread in gigabytes.
</p>
<p name="Germline.sampleWorkflow.bwamem2Mem.sortThreads">
        <b>Germline.sampleWorkflow.bwamem2Mem.sortThreads</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The number of threads to use for sorting.
</p>
<p name="Germline.sampleWorkflow.bwamem2Mem.timeMinutes">
        <b>Germline.sampleWorkflow.bwamem2Mem.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size([read1, read2],"G") * 220 / threads))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.markdup.compressionLevel">
        <b>Germline.sampleWorkflow.markdup.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        Compression level from 0 (uncompressed) to 9 (best).
</p>
<p name="Germline.sampleWorkflow.markdup.hashTableSize">
        <b>Germline.sampleWorkflow.markdup.hashTableSize</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Sets sambamba's hash table size.
</p>
<p name="Germline.sampleWorkflow.markdup.ioBufferSize">
        <b>Germline.sampleWorkflow.markdup.ioBufferSize</b><br />
        <i>Int &mdash; Default: 128</i><br />
        The amount of mb allocated to each IO buffer. Sambamba uses two IO buffers.
</p>
<p name="Germline.sampleWorkflow.markdup.memoryMb">
        <b>Germline.sampleWorkflow.markdup.memoryMb</b><br />
        <i>Int &mdash; Default: 1024 + sortBufferSize + 2 * ioBufferSize</i><br />
        The amount of memory available to the job in megabytes.
</p>
<p name="Germline.sampleWorkflow.markdup.overFlowListSize">
        <b>Germline.sampleWorkflow.markdup.overFlowListSize</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Sets sambamba's overflow list size.
</p>
<p name="Germline.sampleWorkflow.markdup.removeDuplicates">
        <b>Germline.sampleWorkflow.markdup.removeDuplicates</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to remove the duplicates (instead of only marking them).
</p>
<p name="Germline.sampleWorkflow.markdup.sortBufferSize">
        <b>Germline.sampleWorkflow.markdup.sortBufferSize</b><br />
        <i>Int &mdash; Default: 2048</i><br />
        The amount of mb allocated to the sort buffer.
</p>
<p name="Germline.sampleWorkflow.markdup.threads">
        <b>Germline.sampleWorkflow.markdup.threads</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The number of threads that will be used for this task.
</p>
<p name="Germline.sampleWorkflow.markdup.timeMinutes">
        <b>Germline.sampleWorkflow.markdup.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBams,"G") * 8)) / threads</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.metrics.ampliconIntervalsLists.javaXmx">
        <b>Germline.sampleWorkflow.metrics.ampliconIntervalsLists.javaXmx</b><br />
        <i>String &mdash; Default: "3G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.metrics.ampliconIntervalsLists.memory">
        <b>Germline.sampleWorkflow.metrics.ampliconIntervalsLists.memory</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.metrics.ampliconIntervalsLists.timeMinutes">
        <b>Germline.sampleWorkflow.metrics.ampliconIntervalsLists.timeMinutes</b><br />
        <i>Int &mdash; Default: 5</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.metrics.collectAlignmentSummaryMetrics">
        <b>Germline.sampleWorkflow.metrics.collectAlignmentSummaryMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectAlignmentSummaryMetrics` argument in Picard.
</p>
<p name="Germline.sampleWorkflow.metrics.Flagstat.memory">
        <b>Germline.sampleWorkflow.metrics.Flagstat.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="Germline.sampleWorkflow.metrics.Flagstat.timeMinutes">
        <b>Germline.sampleWorkflow.metrics.Flagstat.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputBam,"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.metrics.meanQualityByCycle">
        <b>Germline.sampleWorkflow.metrics.meanQualityByCycle</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=MeanQualityByCycle` argument in Picard.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.collectBaseDistributionByCycle">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.collectBaseDistributionByCycle</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectBaseDistributionByCycle` argument.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.collectGcBiasMetrics">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.collectGcBiasMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectGcBiasMetrics` argument.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.collectInsertSizeMetrics">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.collectInsertSizeMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectInsertSizeMetrics` argument.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.collectQualityYieldMetrics">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.collectQualityYieldMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectQualityYieldMetrics` argument.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.collectSequencingArtifactMetrics">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.collectSequencingArtifactMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectSequencingArtifactMetrics` argument.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.javaXmxMb">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.javaXmxMb</b><br />
        <i>Int &mdash; Default: 3072</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.memoryMb">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.qualityScoreDistribution">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.qualityScoreDistribution</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=QualityScoreDistribution` argument.
</p>
<p name="Germline.sampleWorkflow.metrics.picardMetrics.timeMinutes">
        <b>Germline.sampleWorkflow.metrics.picardMetrics.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(referenceFasta,"G") * 3 * 2)) + ceil((size(inputBam,"G") * 6))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.metrics.rnaSeqMetrics.javaXmx">
        <b>Germline.sampleWorkflow.metrics.rnaSeqMetrics.javaXmx</b><br />
        <i>String &mdash; Default: "8G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.metrics.rnaSeqMetrics.memory">
        <b>Germline.sampleWorkflow.metrics.rnaSeqMetrics.memory</b><br />
        <i>String &mdash; Default: "9G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.metrics.rnaSeqMetrics.timeMinutes">
        <b>Germline.sampleWorkflow.metrics.rnaSeqMetrics.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBam,"G") * 12))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.metrics.targetIntervalsLists.javaXmx">
        <b>Germline.sampleWorkflow.metrics.targetIntervalsLists.javaXmx</b><br />
        <i>String &mdash; Default: "3G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.metrics.targetIntervalsLists.memory">
        <b>Germline.sampleWorkflow.metrics.targetIntervalsLists.memory</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.metrics.targetIntervalsLists.timeMinutes">
        <b>Germline.sampleWorkflow.metrics.targetIntervalsLists.timeMinutes</b><br />
        <i>Int &mdash; Default: 5</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.metrics.targetMetrics.javaXmx">
        <b>Germline.sampleWorkflow.metrics.targetMetrics.javaXmx</b><br />
        <i>String &mdash; Default: "3G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.metrics.targetMetrics.memory">
        <b>Germline.sampleWorkflow.metrics.targetMetrics.memory</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.metrics.targetMetrics.timeMinutes">
        <b>Germline.sampleWorkflow.metrics.targetMetrics.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBam,"G") * 6))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.bwa">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.bwa</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --bwa flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.colorspace">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.colorspace</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --colorspace flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.compressionLevel">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level if gzipped output is used.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.cores">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.cores</b><br />
        <i>Int &mdash; Default: 4</i><br />
        The number of cores to use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.cut">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.cut</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --cut option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.discardTrimmed">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.discardTrimmed</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --quality-cutoff option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.discardUntrimmed">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.discardUntrimmed</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --discard-untrimmed option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.doubleEncode">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.doubleEncode</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --double-encode flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.errorRate">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.errorRate</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --error-rate option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.front">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.front</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        A list of 5' ligated adapter sequences to be cut from the given first or single end fastq file.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.frontRead2">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.frontRead2</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        A list of 5' ligated adapter sequences to be cut from the given second end fastq file.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.infoFilePath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.infoFilePath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --info-file option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.interleaved">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.interleaved</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --interleaved flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.length">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.length</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --length option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.lengthTag">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.lengthTag</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --length-tag option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.maq">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.maq</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --maq flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.maskAdapter">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.maskAdapter</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --mask-adapter flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.matchReadWildcards">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.matchReadWildcards</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --match-read-wildcards flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.maximumLength">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.maximumLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --maximum-length option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.maxN">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.maxN</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --max-n option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.memory">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.memory</b><br />
        <i>String &mdash; Default: "~{300 + 100 * cores}M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.minimumLength">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.minimumLength</b><br />
        <i>Int? &mdash; Default: 2</i><br />
        Equivalent to cutadapt's --minimum-length option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.nextseqTrim">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.nextseqTrim</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --nextseq-trim option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.noIndels">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.noIndels</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-indels flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.noMatchAdapterWildcards">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.noMatchAdapterWildcards</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-match-adapter-wildcards flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.noTrim">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.noTrim</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-trim flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.noZeroCap">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.noZeroCap</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-zero-cap flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.overlap">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.overlap</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --overlap option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.pairFilter">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.pairFilter</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --pair-filter option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.prefix">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.prefix</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --prefix option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.qualityBase">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.qualityBase</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --quality-base option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.qualityCutoff">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.qualityCutoff</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --quality-cutoff option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.restFilePath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.restFilePath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --rest-file option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.stripF3">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.stripF3</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --strip-f3 flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.stripSuffix">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.stripSuffix</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --strip-suffix option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.suffix">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.suffix</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --suffix option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.timeMinutes">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size([read1, read2],"G") * 12.0 / cores))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.times">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.times</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --times option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongOutputPath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-long-output option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongPairedOutputPath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.tooLongPairedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-long-paired-output option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortOutputPath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-short-output option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortPairedOutputPath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.tooShortPairedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-short-paired-output option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.trimN">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.trimN</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --trim-n flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedOutputPath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --untrimmed-output option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedPairedOutputPath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.untrimmedPairedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --untrimmed-paired-output option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.wildcardFilePath">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.wildcardFilePath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --wildcard-file option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.Cutadapt.zeroCap">
        <b>Germline.sampleWorkflow.qualityControl.Cutadapt.zeroCap</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --zero-cap flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.extractFastqcZip">
        <b>Germline.sampleWorkflow.qualityControl.extractFastqcZip</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to extract Fastqc's report zip files.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.adapters">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.casava">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.contaminants">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.dir">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.format">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.javaXmx">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.kmers">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.limits">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.memory">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.minLength">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.nano">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.noFilter">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.nogroup">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.threads">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1.timeMinutes">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.adapters">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.casava">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.contaminants">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.dir">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.format">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.javaXmx">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.kmers">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.limits">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.memory">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.minLength">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.nano">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.noFilter">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.nogroup">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.threads">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead1After.timeMinutes">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead1After.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.adapters">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.casava">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.contaminants">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.dir">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.format">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.javaXmx">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.kmers">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.limits">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.memory">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.minLength">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.nano">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.noFilter">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.nogroup">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.threads">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2.timeMinutes">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.adapters">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.casava">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.contaminants">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.dir">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.format">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.javaXmx">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.kmers">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.limits">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.memory">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.minLength">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.nano">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.noFilter">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.nogroup">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.threads">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="Germline.sampleWorkflow.qualityControl.FastqcRead2After.timeMinutes">
        <b>Germline.sampleWorkflow.qualityControl.FastqcRead2After.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.sampleWorkflow.qualityControl.runAdapterClipping">
        <b>Germline.sampleWorkflow.qualityControl.runAdapterClipping</b><br />
        <i>Boolean &mdash; Default: defined(adapterForward) || defined(adapterReverse) || length(select_first([contaminations, []])) > 0</i><br />
        Whether or not adapters should be removed from the reads.
</p>
<p name="Germline.scatterList.memory">
        <b>Germline.scatterList.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.scatterList.prefix">
        <b>Germline.scatterList.prefix</b><br />
        <i>String &mdash; Default: "scatters/scatter-"</i><br />
        The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</p>
<p name="Germline.scatterList.splitContigs">
        <b>Germline.scatterList.splitContigs</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        If set, contigs are allowed to be split up over multiple files.
</p>
<p name="Germline.scatterList.timeMinutes">
        <b>Germline.scatterList.timeMinutes</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.scatterSize">
        <b>Germline.scatterSize</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</p>
<p name="Germline.scatterSizeMillions">
        <b>Germline.scatterSizeMillions</b><br />
        <i>Int &mdash; Default: 1000</i><br />
        Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.
</p>
<p name="Germline.singleSampleCalling.callAutosomal.contamination">
        <b>Germline.singleSampleCalling.callAutosomal.contamination</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to HaplotypeCaller's `-contamination` option.
</p>
<p name="Germline.singleSampleCalling.callAutosomal.emitRefConfidence">
        <b>Germline.singleSampleCalling.callAutosomal.emitRefConfidence</b><br />
        <i>String &mdash; Default: if gvcf then "GVCF" else "NONE"</i><br />
        Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</p>
<p name="Germline.singleSampleCalling.callAutosomal.javaXmxMb">
        <b>Germline.singleSampleCalling.callAutosomal.javaXmxMb</b><br />
        <i>Int &mdash; Default: 4096</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="Germline.singleSampleCalling.callAutosomal.memoryMb">
        <b>Germline.singleSampleCalling.callAutosomal.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.singleSampleCalling.callAutosomal.outputMode">
        <b>Germline.singleSampleCalling.callAutosomal.outputMode</b><br />
        <i>String? &mdash; Default: None</i><br />
        Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</p>
<p name="Germline.singleSampleCalling.callX.contamination">
        <b>Germline.singleSampleCalling.callX.contamination</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to HaplotypeCaller's `-contamination` option.
</p>
<p name="Germline.singleSampleCalling.callX.emitRefConfidence">
        <b>Germline.singleSampleCalling.callX.emitRefConfidence</b><br />
        <i>String &mdash; Default: if gvcf then "GVCF" else "NONE"</i><br />
        Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</p>
<p name="Germline.singleSampleCalling.callX.javaXmxMb">
        <b>Germline.singleSampleCalling.callX.javaXmxMb</b><br />
        <i>Int &mdash; Default: 4096</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="Germline.singleSampleCalling.callX.memoryMb">
        <b>Germline.singleSampleCalling.callX.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.singleSampleCalling.callX.outputMode">
        <b>Germline.singleSampleCalling.callX.outputMode</b><br />
        <i>String? &mdash; Default: None</i><br />
        Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</p>
<p name="Germline.singleSampleCalling.callY.contamination">
        <b>Germline.singleSampleCalling.callY.contamination</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to HaplotypeCaller's `-contamination` option.
</p>
<p name="Germline.singleSampleCalling.callY.emitRefConfidence">
        <b>Germline.singleSampleCalling.callY.emitRefConfidence</b><br />
        <i>String &mdash; Default: if gvcf then "GVCF" else "NONE"</i><br />
        Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</p>
<p name="Germline.singleSampleCalling.callY.javaXmxMb">
        <b>Germline.singleSampleCalling.callY.javaXmxMb</b><br />
        <i>Int &mdash; Default: 4096</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="Germline.singleSampleCalling.callY.memoryMb">
        <b>Germline.singleSampleCalling.callY.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="Germline.singleSampleCalling.callY.outputMode">
        <b>Germline.singleSampleCalling.callY.outputMode</b><br />
        <i>String? &mdash; Default: None</i><br />
        Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleGvcf.intervals">
        <b>Germline.singleSampleCalling.mergeSingleSampleGvcf.intervals</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        Bed files or interval lists describing the regions to operate on.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleGvcf.javaXmx">
        <b>Germline.singleSampleCalling.mergeSingleSampleGvcf.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleGvcf.memory">
        <b>Germline.singleSampleCalling.mergeSingleSampleGvcf.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleGvcf.timeMinutes">
        <b>Germline.singleSampleCalling.mergeSingleSampleGvcf.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(gvcfFiles,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleVcf.compressionLevel">
        <b>Germline.singleSampleCalling.mergeSingleSampleVcf.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level at which the BAM files are written.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleVcf.javaXmx">
        <b>Germline.singleSampleCalling.mergeSingleSampleVcf.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleVcf.memory">
        <b>Germline.singleSampleCalling.mergeSingleSampleVcf.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleVcf.timeMinutes">
        <b>Germline.singleSampleCalling.mergeSingleSampleVcf.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputVCFs,"G")) * 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkDeflater">
        <b>Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkDeflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</p>
<p name="Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkInflater">
        <b>Germline.singleSampleCalling.mergeSingleSampleVcf.useJdkInflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java inflater. False, uses the optimized intel inflater.
</p>
<p name="Germline.singleSampleCalling.standardMinConfidenceThresholdForCalling">
        <b>Germline.singleSampleCalling.standardMinConfidenceThresholdForCalling</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Minimum confidence treshold used by haplotype caller.
</p>
<p name="Germline.singleSampleCalling.Stats.afBins">
        <b>Germline.singleSampleCalling.Stats.afBins</b><br />
        <i>String? &mdash; Default: None</i><br />
        Allele frequency bins, a list (0.1,0.5,1) or a file (0.1
0.5
1).
</p>
<p name="Germline.singleSampleCalling.Stats.applyFilters">
        <b>Germline.singleSampleCalling.Stats.applyFilters</b><br />
        <i>String? &mdash; Default: None</i><br />
        Require at least one of the listed FILTER strings (e.g. "PASS,.").
</p>
<p name="Germline.singleSampleCalling.Stats.collapse">
        <b>Germline.singleSampleCalling.Stats.collapse</b><br />
        <i>String? &mdash; Default: None</i><br />
        Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</p>
<p name="Germline.singleSampleCalling.Stats.depth">
        <b>Germline.singleSampleCalling.Stats.depth</b><br />
        <i>String? &mdash; Default: None</i><br />
        Depth distribution: min,max,bin size [0,500,1].
</p>
<p name="Germline.singleSampleCalling.Stats.exclude">
        <b>Germline.singleSampleCalling.Stats.exclude</b><br />
        <i>String? &mdash; Default: None</i><br />
        Exclude sites for which the expression is true (see man page for details).
</p>
<p name="Germline.singleSampleCalling.Stats.exons">
        <b>Germline.singleSampleCalling.Stats.exons</b><br />
        <i>File? &mdash; Default: None</i><br />
        Tab-delimited file with exons for indel frameshifts (chr,from,to; 1-based, inclusive, bgzip compressed).
</p>
<p name="Germline.singleSampleCalling.Stats.firstAlleleOnly">
        <b>Germline.singleSampleCalling.Stats.firstAlleleOnly</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Include only 1st allele at multiallelic sites.
</p>
<p name="Germline.singleSampleCalling.Stats.include">
        <b>Germline.singleSampleCalling.Stats.include</b><br />
        <i>String? &mdash; Default: None</i><br />
        Select sites for which the expression is true (see man page for details).
</p>
<p name="Germline.singleSampleCalling.Stats.memory">
        <b>Germline.singleSampleCalling.Stats.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.singleSampleCalling.Stats.regions">
        <b>Germline.singleSampleCalling.Stats.regions</b><br />
        <i>String? &mdash; Default: None</i><br />
        Restrict to comma-separated list of regions.
</p>
<p name="Germline.singleSampleCalling.Stats.samplesFile">
        <b>Germline.singleSampleCalling.Stats.samplesFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        File of samples to include.
</p>
<p name="Germline.singleSampleCalling.Stats.splitByID">
        <b>Germline.singleSampleCalling.Stats.splitByID</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Collect stats for sites with ID separately (known vs novel).
</p>
<p name="Germline.singleSampleCalling.Stats.targets">
        <b>Germline.singleSampleCalling.Stats.targets</b><br />
        <i>String? &mdash; Default: None</i><br />
        Similar to regions but streams rather than index-jumps.
</p>
<p name="Germline.singleSampleCalling.Stats.targetsFile">
        <b>Germline.singleSampleCalling.Stats.targetsFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        Similar to regionsFile but streams rather than index-jumps.
</p>
<p name="Germline.singleSampleCalling.Stats.threads">
        <b>Germline.singleSampleCalling.Stats.threads</b><br />
        <i>Int &mdash; Default: 0</i><br />
        Number of extra decompression threads [0].
</p>
<p name="Germline.singleSampleCalling.Stats.timeMinutes">
        <b>Germline.singleSampleCalling.Stats.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + 2 * ceil(size(select_all([inputVcf, compareVcf]),"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.singleSampleCalling.Stats.userTsTv">
        <b>Germline.singleSampleCalling.Stats.userTsTv</b><br />
        <i>String? &mdash; Default: None</i><br />
        <TAG[:min:max:n]>. Collect Ts/Tv stats for any tag using the given binning [0:1:100].
</p>
<p name="Germline.singleSampleCalling.Stats.verbose">
        <b>Germline.singleSampleCalling.Stats.verbose</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Produce verbose per-site and per-sample output.
</p>
<p name="Germline.singleSampleCalling.timeMinutes">
        <b>Germline.singleSampleCalling.timeMinutes</b><br />
        <i>Int &mdash; Default: ceil((size(bam,"G") * 120))</i><br />
        The time in minutes expected for each haplotype caller task. Will be exposed as the time_minutes runtime attribute.
</p>
<p name="Germline.svCalling.clever.memory">
        <b>Germline.svCalling.clever.memory</b><br />
        <i>String &mdash; Default: "55G"</i><br />
        The memory required to run the programs.
</p>
<p name="Germline.svCalling.clever.threads">
        <b>Germline.svCalling.clever.threads</b><br />
        <i>Int &mdash; Default: 10</i><br />
        The the number of threads required to run a program.
</p>
<p name="Germline.svCalling.clever.timeMinutes">
        <b>Germline.svCalling.clever.timeMinutes</b><br />
        <i>Int &mdash; Default: 480</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.delly.memory">
        <b>Germline.svCalling.delly.memory</b><br />
        <i>String &mdash; Default: "15G"</i><br />
        The memory required to run the programs.
</p>
<p name="Germline.svCalling.delly.timeMinutes">
        <b>Germline.svCalling.delly.timeMinutes</b><br />
        <i>Int &mdash; Default: 300</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.delly2vcf.memory">
        <b>Germline.svCalling.delly2vcf.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.svCalling.delly2vcf.timeMinutes">
        <b>Germline.svCalling.delly2vcf.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputFile,"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.FilterShortReadsBam.memory">
        <b>Germline.svCalling.FilterShortReadsBam.memory</b><br />
        <i>String &mdash; Default: "1G"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.svCalling.FilterShortReadsBam.timeMinutes">
        <b>Germline.svCalling.FilterShortReadsBam.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(bamFile,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.gridss.jvmHeapSizeGb">
        <b>Germline.svCalling.gridss.jvmHeapSizeGb</b><br />
        <i>Int &mdash; Default: 30</i><br />
        The size of JVM heap for assembly and variant calling.
</p>
<p name="Germline.svCalling.gridss.normalBai">
        <b>Germline.svCalling.gridss.normalBai</b><br />
        <i>File? &mdash; Default: None</i><br />
        The index for normalBam.
</p>
<p name="Germline.svCalling.gridss.normalBam">
        <b>Germline.svCalling.gridss.normalBam</b><br />
        <i>File? &mdash; Default: None</i><br />
        The BAM file for the normal/control sample.
</p>
<p name="Germline.svCalling.gridss.normalLabel">
        <b>Germline.svCalling.gridss.normalLabel</b><br />
        <i>String? &mdash; Default: None</i><br />
        The name of the normal sample.
</p>
<p name="Germline.svCalling.gridss.threads">
        <b>Germline.svCalling.gridss.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of the threads to use.
</p>
<p name="Germline.svCalling.manta.timeMinutes">
        <b>Germline.svCalling.manta.timeMinutes</b><br />
        <i>Int &mdash; Default: 60</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.mateclever.cleverMaxDelLength">
        <b>Germline.svCalling.mateclever.cleverMaxDelLength</b><br />
        <i>Int &mdash; Default: 100000</i><br />
        The maximum deletion length to look for in Clever predictions.
</p>
<p name="Germline.svCalling.mateclever.maxLengthDiff">
        <b>Germline.svCalling.mateclever.maxLengthDiff</b><br />
        <i>Int &mdash; Default: 30</i><br />
        The maximum length difference between split-read and read-pair deletion to be considered identical.
</p>
<p name="Germline.svCalling.mateclever.maxOffset">
        <b>Germline.svCalling.mateclever.maxOffset</b><br />
        <i>Int &mdash; Default: 150</i><br />
        The maximum center distance between split-read and read-pair deletion to be considered identical.
</p>
<p name="Germline.svCalling.mateclever.memory">
        <b>Germline.svCalling.mateclever.memory</b><br />
        <i>String &mdash; Default: "15G"</i><br />
        The memory required to run the programs.
</p>
<p name="Germline.svCalling.mateclever.threads">
        <b>Germline.svCalling.mateclever.threads</b><br />
        <i>Int &mdash; Default: 10</i><br />
        The the number of threads required to run a program.
</p>
<p name="Germline.svCalling.mateclever.timeMinutes">
        <b>Germline.svCalling.mateclever.timeMinutes</b><br />
        <i>Int &mdash; Default: 600</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.newId">
        <b>Germline.svCalling.newId</b><br />
        <i>String &mdash; Default: "\'%CHROM\\_%POS\'"</i><br />
        Assign ID on the fly (e.g. --set-id +'%CHROM\_%POS').
</p>
<p name="Germline.svCalling.renameSample.javaXmx">
        <b>Germline.svCalling.renameSample.javaXmx</b><br />
        <i>String &mdash; Default: "8G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="Germline.svCalling.renameSample.memory">
        <b>Germline.svCalling.renameSample.memory</b><br />
        <i>String &mdash; Default: "9G"</i><br />
        The memory required to run the programs.
</p>
<p name="Germline.svCalling.renameSample.timeMinutes">
        <b>Germline.svCalling.renameSample.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputVcf,"G") * 2))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.setId.annsFile">
        <b>Germline.svCalling.setId.annsFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        Bgzip-compressed and tabix-indexed file with annotations (see man page for details).
</p>
<p name="Germline.svCalling.setId.collapse">
        <b>Germline.svCalling.setId.collapse</b><br />
        <i>String? &mdash; Default: None</i><br />
        Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</p>
<p name="Germline.svCalling.setId.columns">
        <b>Germline.svCalling.setId.columns</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        Comma-separated list of columns or tags to carry over from the annotation file (see man page for details).
</p>
<p name="Germline.svCalling.setId.exclude">
        <b>Germline.svCalling.setId.exclude</b><br />
        <i>String? &mdash; Default: None</i><br />
        Exclude sites for which the expression is true (see man page for details).
</p>
<p name="Germline.svCalling.setId.force">
        <b>Germline.svCalling.setId.force</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Continue even when parsing errors, such as undefined tags, are encountered.
</p>
<p name="Germline.svCalling.setId.headerLines">
        <b>Germline.svCalling.setId.headerLines</b><br />
        <i>File? &mdash; Default: None</i><br />
        Lines to append to the VCF header (see man page for details).
</p>
<p name="Germline.svCalling.setId.include">
        <b>Germline.svCalling.setId.include</b><br />
        <i>String? &mdash; Default: None</i><br />
        Select sites for which the expression is true (see man page for details).
</p>
<p name="Germline.svCalling.setId.keepSites">
        <b>Germline.svCalling.setId.keepSites</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Keep sites which do not pass -i and -e expressions instead of discarding them.
</p>
<p name="Germline.svCalling.setId.markSites">
        <b>Germline.svCalling.setId.markSites</b><br />
        <i>String? &mdash; Default: None</i><br />
        Annotate sites which are present ('+') or absent ('-') in the -a file with a new INFO/TAG flag.
</p>
<p name="Germline.svCalling.setId.memory">
        <b>Germline.svCalling.setId.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.svCalling.setId.noVersion">
        <b>Germline.svCalling.setId.noVersion</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Do not append version and command line information to the output VCF header.
</p>
<p name="Germline.svCalling.setId.regions">
        <b>Germline.svCalling.setId.regions</b><br />
        <i>String? &mdash; Default: None</i><br />
        Restrict to comma-separated list of regions.
</p>
<p name="Germline.svCalling.setId.regionsFile">
        <b>Germline.svCalling.setId.regionsFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        Restrict to regions listed in a file.
</p>
<p name="Germline.svCalling.setId.removeAnns">
        <b>Germline.svCalling.setId.removeAnns</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        List of annotations to remove (see man page for details).
</p>
<p name="Germline.svCalling.setId.renameChrs">
        <b>Germline.svCalling.setId.renameChrs</b><br />
        <i>File? &mdash; Default: None</i><br />
        rename chromosomes according to the map in file (see man page for details).
</p>
<p name="Germline.svCalling.setId.samples">
        <b>Germline.svCalling.setId.samples</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        List of samples for sample stats, "-" to include all samples.
</p>
<p name="Germline.svCalling.setId.samplesFile">
        <b>Germline.svCalling.setId.samplesFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        File of samples to include.
</p>
<p name="Germline.svCalling.setId.singleOverlaps">
        <b>Germline.svCalling.setId.singleOverlaps</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        keep memory requirements low with very large annotation files.
</p>
<p name="Germline.svCalling.setId.threads">
        <b>Germline.svCalling.setId.threads</b><br />
        <i>Int &mdash; Default: 0</i><br />
        Number of extra decompression threads [0].
</p>
<p name="Germline.svCalling.setId.timeMinutes">
        <b>Germline.svCalling.setId.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputFile,"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.smoove.memory">
        <b>Germline.svCalling.smoove.memory</b><br />
        <i>String &mdash; Default: "15G"</i><br />
        The memory required to run the programs.
</p>
<p name="Germline.svCalling.smoove.timeMinutes">
        <b>Germline.svCalling.smoove.timeMinutes</b><br />
        <i>Int &mdash; Default: 1440</i><br />
        The maximum duration (in minutes) the tool is allowed to run.
</p>
<p name="Germline.svCalling.sort.memory">
        <b>Germline.svCalling.sort.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="Germline.svCalling.sort.timeMinutes">
        <b>Germline.svCalling.sort.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputFile,"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.svCalling.sort.tmpDir">
        <b>Germline.svCalling.sort.tmpDir</b><br />
        <i>String &mdash; Default: "./sorting-tmp"</i><br />
        The location of the temporary files during the bcftools sorting.
</p>
<p name="Germline.svCalling.survivor.breakpointDistance">
        <b>Germline.svCalling.survivor.breakpointDistance</b><br />
        <i>Int &mdash; Default: 1000</i><br />
        The distance between pairwise breakpoints between SVs.
</p>
<p name="Germline.svCalling.survivor.distanceBySvSize">
        <b>Germline.svCalling.survivor.distanceBySvSize</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        A boolean to predict the pairwise distance between the SVs based on their size.
</p>
<p name="Germline.svCalling.survivor.memory">
        <b>Germline.svCalling.survivor.memory</b><br />
        <i>String &mdash; Default: "24G"</i><br />
        The memory required to run the programs.
</p>
<p name="Germline.svCalling.survivor.minSize">
        <b>Germline.svCalling.survivor.minSize</b><br />
        <i>Int &mdash; Default: 30</i><br />
        The mimimum size of SV to be merged.
</p>
<p name="Germline.svCalling.survivor.strandType">
        <b>Germline.svCalling.survivor.strandType</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        A boolean to include strand type of an SV to be merged.
</p>
<p name="Germline.svCalling.survivor.suppVecs">
        <b>Germline.svCalling.survivor.suppVecs</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The minimum number of SV callers to support the merging.
</p>
<p name="Germline.svCalling.survivor.svType">
        <b>Germline.svCalling.survivor.svType</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        A boolean to include the type SV to be merged.
</p>
<p name="Germline.svCalling.survivor.timeMinutes">
        <b>Germline.svCalling.survivor.timeMinutes</b><br />
        <i>Int &mdash; Default: 60</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="Germline.useBwaKit">
        <b>Germline.useBwaKit</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not BWA kit should be used. If false BWA mem will be used.
</p>
</details>








<hr />

> Generated using WDL AID (0.1.1)
