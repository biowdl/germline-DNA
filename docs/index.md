---
layout: default
title: Home
version: develop
latest: false
---

This pipeline can be used to process germline-DNA data with read lengths above
70 bp, starting with FastQ files. It will perform adapter clipping (using
cutadapt), mapping (using BWA mem) and variantcalling (based on the
[GATK Best Practice](https://software.broadinstitute.org/gatk/best-practices/)).

This pipeline is part of [BioWDL](https://biowdl.github.io/)
developed by the SASC team at [Leiden University Medical Center](https://www.lumc.nl/).

## Usage
You can run the pipeline using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json pipeline.wdl
```

### Inputs
Inputs are provided through a JSON file. The minimally required inputs are
described below, but additional inputs are available.
A template containing all possible inputs can be generated using
Womtool as described in the
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
See [this page](/inputs.html) for some additional general notes and information
about pipeline inputs.

```json
{
  "pipeline.bwaIndex": {
    "fastaFile": "A path to the fasta file from the bwa index",
    "indexFiles": "A list containing the other bwa index files"
  },
  "pipeline.dbSNP": {
    "file": "A path to a dbSNP VCF file",
    "index": "The path to the index (.tbi) file associated with the dbSNP VCF"
  },
  "pipeline.sampleConfigFiles": "A list of sample configuration files (see below)",
  "pipeline.outputDir": "The path to the output directory",
  "pipeline.reference": {
    "fasta": "A path to a reference fasta",
    "fai": "The path to the index associated with the reference fasta",
    "dict": "The path to the dict file associated with the reference fasta"
  }
}
```

Some additional inputs which may be of interest are:
```json
{
  "pipeline.sample.Sample.library.Library.readgroup.numberChunks":
    "Int (optional, default = 1): The number of chunks each fastq file should be split into for QC and alignment",
  "pipeline.sample.Sample.library.Library.readgroup.Readgroup.mapping.platform":
    "String? (optional, default = \"illumina\"): The sequencing platform used",
  "pipeline.sample.Sample.library.Library.readgroup.Readgroup.mapping.AlignBwaMem.bwaMem.threads":
    "Int (optional, default = 2): Number of threads used for alignment",
  "pipeline.sample.Sample.createGvcf.Gvcf.scatterList.regions":
    "File? (optional): Bed file with regions used for variantcalling",
  "pipeline.sample.Sample.library.Library.bqsr.GatkPreprocess.scatterList.regions":
    "File? (optional): Bed file with regions used for variantcalling",
  "pipeline.genotyping.JointGenotyping.scatterList.regions":
    "File? (optional): Bed file with regions used for variantcalling",
  "pipeline.sample.Sample.library.Library.bqsr.scatterSize":
    "Int (optional, default = 10000000): Size of scatter regions (see explanation of scattering below)",
  "pipeline.genotyping.scatterSize":
    "Int (optional, default = 10000000): Size of scatter regions (see explanation of scattering below)",
  "pipeline.sample.Sample.createGvcf.scatterSize":
    "Int (optional, default = 10000000): Size of scatter regions (see explanation of scattering below)",
  "pipeline.sample.Sample.library.Library.readgroup.Readgroup.qc.adapterForward": "The adapters to be cut from the forward reads. Default: Illumina Universal Adapter",
  "pipeline.sample.Sample.library.Library.readgroup.Readgroup.qc.adapterReverse": "The adapters to be cut from the reverse reads (if paired-end reads are used). Default: Illumina Universal Adapter."  
}
```

#### Sample configuration
The sample configuration should be a YML file which adheres to the following
structure:
```yml
samples: #Biological replicates
  - id: <sample>
    control: <sample id for associated control>
    libraries: #Technical replicates
      - id: <library>
        readgroups: #Sequencing lanes
          - id: <readgroup>
            reads:
              R1: <Path to first-end FastQ file.>
              R1_md5: <Path to MD5 checksum file of first-end FastQ file.>
              R2: <Path to second-end FastQ file.>
              R2_md5: <Path to MD5 checksum file of second-end FastQ file.>
```
Replace the text between `< >` with appropriate values. R2 values may be
omitted in the case of single-end data. Multiple samples, libraries (per
sample) and readgroups (per library) may be given.

The control value on the sample level should specify the control sample
associated with this sample. This control sample should be present in the
sample configuration as well. This is an optional field. Should it be
specified then somatic-variantcalling will be performed for the indicated
pair.

#### Example
The following is an example of what an inputs JSON might look like:
```json
{
  "pipeline.bwaIndex": {
    "fastaFile": "/home/user/genomes/human/bwa/GRCh38.fasta",
    "indexFiles": [
      "/home/user/genomes/human/bwa/GRCh38.fasta.sa",
      "/home/user/genomes/human/bwa/GRCh38.fasta.amb",
      "/home/user/genomes/human/bwa/GRCh38.fasta.ann",
      "/home/user/genomes/human/bwa/GRCh38.fasta.bwt",
      "/home/user/genomes/human/bwa/GRCh38.fasta.pac"
    ]
  },
  "pipeline.dbSNP": {
    "file": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz",
    "index": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz.tbi"
  },
  "pipeline.sampleConfigFiles": "/home/user/analysis/samples.yml",
  "pipeline.outputDir": "/home/user/analysis/results",
  "pipeline.reference": {
    "fasta": "/home/user/genomes/human/GRCh38.fasta",
    "fai": "/home/user/genomes/human/GRCh38.fasta.fai",
    "dict": "/home/user/genomes/human/GRCh38.dict"
  },
  "pipeline.sample.Sample.library.Library.readgroup.numberChunks": 20,
  "pipeline.sample.Sample.library.Library.readgroup.Readgroup.mapping.AlignBwaMem.bwaMem.threads": 8
}
```

And the associated sample configuration YML might look like this:
```yml
samples:
  - id: patient1-case
    control: patient1-control
    libraries:
      - id: lib1
        readgroups:
          - id: lane1
            reads:
              R1: /home/user/data/patient1-case/R1.fq.gz
              R1_md5: /home/user/data/patient1-case/R1.fq.gz.md5
              R2: /home/user/data/patient1-case/R2.fq.gz
              R2_md5: /home/user/data/patient1-case/R2.fq.gz.md5
  - id: patient1-control
    libraries:
      - id: lib1
        readgroups:
          - id: lane1
            reads:
              R1: /home/user/data/patient1-control/lane1_R1.fq.gz
              R1_md5: /home/user/data/patient1-control/lane1_R1.fq.gz.md5
              R2: /home/user/data/patient1-control/lane1_R2.fq.gz
              R2_md5: /home/user/data/patient1-control/lane1_R2.fq.gz.md5
          - id: lane2
            reads:
              R1: /home/user/data/patient1-control/lane2_R1.fq.gz
              R1_md5: /home/user/data/patient1-control/lane2_R1.fq.gz.md5
              R2: /home/user/data/patient1-control/lane2_R2.fq.gz
              R2_md5: /home/user/data/patient1-control/lane2_R2.fq.gz.md5
```


### Dependency requirements and tool versions
Included in the repository is an `environment.yml` file. This file includes
all the tool version on which the workflow was tested. You can use conda and
this file to create an environment with all the correct tools.

### Output
This pipeline will produce a number of directories and files:
- **samples**: Contains a folder per sample.
  - **&lt;sample>**: Contains a variety of files, including the BAM and gVCF
  files for this sample, as well as their indexes. It also contains a directory
  per library.
    - **somatic-variantcalling**: Contains somatic variantcalling results.
    - **&lt;library>**: Contains the BAM files for this library
    (`*.markdup.bam`) and a BAM file with additional preprocessing performed
    used for variantcalling (`*.markdup.bsqr.bam`). This second BAM file should
    not be used for expression quantification, because splicing events have
    been split into separate reads to improve variantcalling.  
    This directory also contains a directory per readgroup.
      - **&lt;readgroup>**: Contains QC metrics and preprocessed FastQ files,
      in case preprocessing was necessary.
- **multisample.vcf.gz**: A multisample VCF file with the variantcalling
  results.
- **multiqc**: Contains the multiqc report.

## Scattering
This pipeline performs scattering to speed up analysis on grid computing
clusters. This is done in two ways. In the first the FastQ files are split into
a number of chunks (see the `numberChunks` input). For each of these chunks the
QC and alignment are performed in separate jobs, which can be processed in
parallel. For certain other steps (such as variantcalling) a second method is
used: The reference genome is split into regions of roughly equal size (see
the `scatterSize` inputs). Each of these regions will be analyzed in separate
jobs as well, allowing them to be processed in parallel.

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any questions about running this pipeline and feature request (such as
adding additional tools and options), please use the
<a href='https://github.com/biowdl/germline-DNA/issues'>github issue tracker</a>
or contact the SASC team directly at: 
<a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
