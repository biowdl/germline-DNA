---
layout: default
title: Home
version: develop
latest: true
---

This pipeline can be used to process germline-DNA data, starting from FastQ
files. It will perform adapter clipping (using cutadapt), mapping (using BWA
mem) and variantcalling (based on the GATK Best Practises).

## Usage
In order to run the complete multisample pipeline, you can
run `pipeline.wdl` using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json pipeline.wdl
```

The inputs JSON can be generated using WOMtools as described in the [WOMtools
documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/). Note that
not some inputs should not be used! See [this page](inputs.md) for more
information.

The primary inputs are described below, additional inputs (such as precommands
and JAR paths) are available. Please use the above mentioned WOMtools command
to see all available inputs.

| field | type | |
|-|-|-|
| sampleConfigFiles | `Array[File]` | The sample configuration files. See below for more details. |
| refFasta | `File` | Reference fasta file. |
| refFastaIndex | `File` | Index for the reference fasta files. |
| refDict | `File` | The dict file for the referene fasta. |
| dbsnpVCF | `File` | Reference dbSNP VCF file. |
| dbsnpVCFindex | `File` | Index for the reference dbSNP VCF file. |
| outputDir | `String` | The directory where the output will be placed. |
| sample.library.readgroup.<br />mapping.bwaMem.referenceFasta | `File` | Reference fasta file from the BWA mem index. |
| sample.library.readgroup.<br />mapping.bwaMem.indexFiles | `Array[File]` | The BWA mem index files assciated with the reference fasta. |

>All inputs have to be preceded by with `pipeline.`.
Type is indicated according to the WDL data types: `File` should be indicators
of file location (a string in JSON). Types ending in `?` indicate the input is
optional, types ending in `+` indicate they require at least one element.

### Sample configuration
The sample configuration should be a YML file which adheres to the following
structure:
```YML
samples:
  <sample>:
    libraries:
      <library>:
        readgroups:
          <readgroup>:
              R1: <Path to first-end FastQ file.>
              R1_md5: <MD5 checksum of first-end FastQ file.>
              R2: <Path to second-end FastQ file.>
              R2_md5: <MD5 checksum of second-end FastQ file.>
```
Replace the text between `< >` with appropriate values. R2 values may be
omitted in the case of single-end data. Multiple readgroups can be added per
library and multiple libraries may be given per sample.

## Tool versions
Included in the repository is an `environment.yml` file. This file includes
all the tool version on which the workflow was tested. You can use conda and
this file to create an environment with all the correct tools.

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

## About
This pipeline is part of [BioWDL](https://biowdl.github.io/)
developed by [the SASC team](http://sasc.lumc.nl/).

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any question related to this pipeline, please use the
<a href='https://github.com/biowdl/germline-DNA/issues'>github issue tracker</a>
or contact
 <a href='http://sasc.lumc.nl/'>the SASC team</a> directly at: <a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
