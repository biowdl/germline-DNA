---
layout: default
title: Home
version: develop
latest: true
---

This pipeline can be used to process germline-DNA data, starting with FastQ
files. It will perform adapter clipping (using cutadapt), mapping (using BWA
mem) and variantcalling (based on the GATK Best Practises).

This pipeline is part of [BioWDL](https://biowdl.github.io/)
developed by [the SASC team](http://sasc.lumc.nl/).

## Usage
In order to run the complete multisample pipeline, you can
run `pipeline.wdl` using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json pipeline.wdl
```

### Inputs
Inputs are provided through a JSON file. The primary inputs are described
below, but additional inputs are available.
A template containing all possible inputs can be generated using
Womtool as described in the
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
See [this page](inputs.md) for some additional general notes and information
about pipeline inputs.

The following are the bare minimum inputs required:
```JSON
{
  "pipeline.bwaIndex": {
    "fastaFile": "File: The fasta file from the bwa index",
    "indexFiles": "Array[File]: The other bwa index files"
  },
  "pipeline.dbSNP": {
    "file": "File: A dbSNP VCF file",
    "index": "File: The index (.tbi) file associated with the dbSNP VCF"
  },
  "pipeline.sampleConfigFiles": "Array[File]: Sample configuration files (see below)",
  "pipeline.outputDir": "String: The path to the output directory",
  "pipeline.reference": {
    "fasta": "File: A reference fasta",
    "fai": "File: The index associated with the reference fasta",
    "dict": "File: The dict associated with the reference fatsa"
  }
}
```

Some additional inputs which may be of interest are:
```JSON
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
    "Int (optional, default = 10000000): Size of scatter regions (see explanation of scattering below)"
}
```

### Sample configuration
The sample configuration should be a YML file which adheres to the following
structure:
```YML
samples: #Biological replicates
  <sample>:
    libraries: #Technical replicates
      <library>:
        readgroups: #Sequencing lanes
          <readgroup>:
              reads:
                R1: <Path to first-end FastQ file.>
                R1_md5: <MD5 checksum of first-end FastQ file.>
                R2: <Path to second-end FastQ file.>
                R2_md5: <MD5 checksum of second-end FastQ file.>
```
Replace the text between `< >` with appropriate values. R2 values may be
omitted in the case of single-end data. Multiple samples, libraries (per
sample) and readgroups (per library) may be given.

## Output
This pipeline will produce a number of directories and files:
- **samples**: Contains a folder per sample.
  - **&lt;sample>**: Contains a variety of files, including the BAM and gVCF
  files for this sample, as well as their indexes. It also contains a directory
  per library.
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

## Scattering
The pipeline performs scattering to speed up analysis on grid computing
clusters. This means that the reference genome will be split into regions of
roughly equal size (see the `scatterSize` inputs). For certain steps each of
these regions will be analyzed in separate jobs, allowing them to be processed
in parallel.

## Tool versions
Included in the repository is an `environment.yml` file. This file includes
all the tool version on which the workflow was tested. You can use conda and
this file to create an environment with all the correct tools.

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any question related to this pipeline, please use the
<a href='https://github.com/biowdl/germline-DNA/issues'>github issue tracker</a>
or contact
 <a href='http://sasc.lumc.nl/'>the SASC team</a> directly at: <a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
