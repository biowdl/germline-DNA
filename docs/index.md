---
layout: default
title: Home
---

This repository contains two workflows. The first is a pipeline for
germline variant calling and the second is a somatic variant calling
pipeline.  
These pipelines can be used to process DNA data (WES or WGS), starting
with FastQ files. They will perform quality control (using FastQC and
MultiQC), adapter clipping (using cutadapt), mapping (using BWA mem or
bwakit) and variant calling (based on the
[GATK Best Practice](https://software.broadinstitute.org/gatk/best-practices/)
for germline calling, and using a variety of callers for somatic calling).

These pipelines are part of [BioWDL](https://biowdl.github.io/)
developed by the SASC team at [Leiden University Medical Center](https://www.lumc.nl/).

## Usage
You can run these pipelines using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json <pipeline>.wdl
```
Use `germline.wdl` to perform germline variant calling and `somatic.wdl`
for somatic variant calling.

### Inputs
Inputs are provided through a JSON file. The minimally required inputs are
described below, but additional inputs are available.
A template containing all possible inputs can be generated using
Womtool as described in the
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).

Replace `<pipeline>` with either `Germline` or `Somatic`.
```json
{
  "<pipeline>.bwaIndex": {
    "fastaFile": "A path to the fasta file from the bwa index",
    "indexFiles": "A list containing the other bwa index files"
  },
  "<pipeline>.dbSNP": {
    "file": "A path to a dbSNP VCF file",
    "index": "The path to the index (.tbi) file associated with the dbSNP VCF"
  },
  "<pipeline>.sampleConfigFile": "A sample configuration file (see below)",
  "<pipeline>.outputDir": "The path to the output directory",
  "<pipeline>.reference": {
    "fasta": "A path to a reference fasta",
    "fai": "The path to the index associated with the reference fasta",
    "dict": "The path to the dict file associated with the reference fasta"
  },
  "<pipeline>.dockerImagesFile": "A file listing the used docker images."
}
```

Some additional inputs which may be of interest are:
```json
{
  "<pipeline>.sample.Sample.library.Library.readgroup.platform":
    "The sequencing platform used. Default: illumina",
  "<pipeline>.sample.Sample.library.Library.readgroup.Readgroup.bwaMem.threads":
    "Number of threads used for alignment. Default: 2",
  "<pipeline>.sample.Sample.library.Library.readgroup.Readgroup.qc.QC.Cutadapt.cores":
    "Number of threads used for cutadapt. Default: 1",
  "<pipeline>.regions":
    "Bed file with regions used for variantcalling",
  "<pipeline>.sample.Sample.library.Library.readgroup.Readgroup.qc.adapterForward":
    "The adapters to be cut from the forward reads. Default: Illumina Universal Adapter",
  "<pipeline>.sample.Sample.library.Library.readgroup.Readgroup.qc.adapterReverse":
    "The adapters to be cut from the reverse reads (if paired-end reads are used). Default: Illumina Universal Adapter.",
  "<pipeline>.sample.Sample.library.Library.readgroup.useBwaKit":
    "Whether bwakit should be used instead of plain BWA mem, this will required an '.alt' file to be present in the index.",
  "Germline.sample.Sample.library.Library.readgroup.Readgroup.bwakit.threads":
    "Number of threads used for alignment when using bwakit. Default: 1"
}
```

#### Sample configuration
The sample configuration should be a YML file which adheres to the following
structure:
```yml
samples: # Biological replicates
  - id: <sample>
    control: <sample id for associated control> # Only used in the somatic pipeline
    libraries: # Technical replicates
      - id: <library>
        readgroups: # Sequencing lanes
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
sample configuration as well. This is an optional field which is only used
in the somatic-variantcalling pipeline, in which somatic-variantcalling
will be performed for the indicated pair.

#### Example
The following is an example of what an inputs JSON might look like. This
example is for the somatic-variantcalling pipeline, however the same values
can be used for Germline as long as the starting `Somatic.` is replaced with
`Germline.`.
```json
{
  "Somatic.bwaIndex": {
    "fastaFile": "/home/user/genomes/human/bwa/GRCh38.fasta",
    "indexFiles": [
      "/home/user/genomes/human/bwa/GRCh38.fasta.sa",
      "/home/user/genomes/human/bwa/GRCh38.fasta.amb",
      "/home/user/genomes/human/bwa/GRCh38.fasta.ann",
      "/home/user/genomes/human/bwa/GRCh38.fasta.bwt",
      "/home/user/genomes/human/bwa/GRCh38.fasta.pac"
    ]
  },
  "Somatic.dbSNP": {
    "file": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz",
    "index": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz.tbi"
  },
  "Somatic.sampleConfigFiles": "/home/user/analysis/samples.yml",
  "Somatic.outputDir": "/home/user/analysis/results",
  "Somatic.reference": {
    "fasta": "/home/user/genomes/human/GRCh38.fasta",
    "fai": "/home/user/genomes/human/GRCh38.fasta.fai",
    "dict": "/home/user/genomes/human/GRCh38.dict"
  },
  "Somatic.sample.Sample.library.Library.readgroup.bwaMem.threads": 8,
  "Somatic.sample.Sample.library.Library.readgroup.Readgroup.qc.QC.Cutadapt.cores": 4,
  "Somatic.dockerImages.yml": "dockerImages.yml"
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
Biowdl pipelines use docker images to ensure  reproducibility. This
means that biowdl pipelines will run on any system that has docker
installed. Alternatively they can be run with singularity.

For more advanced configuration of docker or singularity please check
the [cromwell documentation on containers](
https://cromwell.readthedocs.io/en/stable/tutorials/Containers/).

Images from [biocontainers](https://biocontainers.pro) are preferred for
biowdl pipelines. The list of default images for this pipeline can be
found in the default for the `dockerImages` input.

### Output
This pipeline will produce a number of directories and files:
- **samples**: Contains a folder per sample.
  - **&lt;sample>**: Contains a variety of files, including the BAM files
    for this sample. It also contains a directory per library.
    - **somatic-variantcalling**: Contains somatic variantcalling results.
      Only present if `somatic.wdl` is used.  
    - **&lt;library>**: Contains the BAM files for this library
      (`*.markdup.bam`) and a BAM file with additional preprocessing performed
      used for variantcalling (`*.markdup.bsqr.bam`).  
      This directory also contains a directory per readgroup.
      - **&lt;readgroup>**: Contains QC metrics and preprocessed FastQ files,
        in case preprocessing was necessary.
- **multisample.vcf.gz**: A multisample VCF file with the variantcalling
  results. Only present if `germline.wdl` is used.
- **multiqc**: Contains the multiqc report.

## Scattering
This pipeline performs scattering to speed up analysis on grid computing
clusters. For steps such as variant qcalling the reference genome is split
into regions of roughly equal size (see the `scatterSize` inputs).
Each of these regions will be analyzed in separate jobs, allowing them
to be processed in parallel.

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
