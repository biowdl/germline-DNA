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
For overviews of all available inputs, see the following pages:
- [germline](./germline-inputs.html)
- [somatic](./comatic-inputs.html)

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

Specific inputs for the germline pipeline are:

```json
{
  "Germline.XNonParRegions": "A BED file that lists all the non-PAR regions on the X chromosome.",
  "Germline.YNonParRegions": "A BED file that lists all the non-PAR regions on the Y chromosome."
}
```
These region files are required in order to have gender-aware variantcalling, 
were the non-PAR region of the X and Y chromosome is called with ploidy 1 for 
males and the Y chromosome is not called for females. 

For samples with unknown gender the non-PAR regions of X will be called with
ploidy 2 and the non-PAR regions of Y will be called with ploidy 1 to ensure 
no variants are missed, regardless of the gender. 

Some additional inputs which may be of interest are:
```json
{
  "<pipeline>.sample.platform":
    "The sequencing platform used. Default: illumina",
  "<pipeline>.sample.Sample.bwaMem.threads":
    "Number of threads used for alignment. Default: 2",
  "<pipeline>.sample.Sample.qc.QC.Cutadapt.cores":
    "Number of threads used for cutadapt. Default: 1",
  "<pipeline>.regions":
    "Bed file with regions used for variantcalling",
  "<pipeline>.sample.Sample.qc.adapterForward":
    "The adapters to be cut from the forward reads. Default: Illumina Universal Adapter",
  "<pipeline>.sample.Sample.qc.adapterReverse":
    "The adapters to be cut from the reverse reads (if paired-end reads are used). Default: Illumina Universal Adapter.",
  "<pipeline>.sample.useBwaKit":
    "Whether bwakit should be used instead of plain BWA mem, this will required an '.alt' file to be present in the index.",
  "Germline.sample.Sample.bwakit.threads":
    "Number of threads used for alignment when using bwakit. Default: 1"
}
```

#### Sample configuration

##### Verification

All samplesheet formats can be verified using `biowdl-input-converter`. 
It can be installed with `pip install biowdl-input-converter` or 
`conda install biowdl-input-converter` (from the bioconda channel). 
Python 3.7 or higher is required.

With `biowdl-input-converter --validate samplesheet.csv` The file
"samplesheet.csv" will be checked. Also the presence of all files in
the samplesheet will be checked to ensure no typos were made. For more
information check out the [biowdl-input-converter readthedocs page](
https://biowdl-input-converter.readthedocs.io).

##### CSV Format
The sample configuration can be given as a csv file with the following 
columns: sample, library, readgroup, R1, R1_md5, R2, R2_md5.

column name | function
---|---
sample | sample ID
library | library ID. These are the libraries that are sequenced. Usually there is only one library per sample
readgroup | readgroup ID. Usually a library is sequenced on multiple lanes in the sequencer, which gives multiple fastq files (referred to as readgroups). Each readgroup pair should have an ID.
R1| The fastq file containing the forward reads 
R1_md5 | Optional: md5sum for the R1 file.
R2| Optional: The fastq file containing the reverse reads
R2_md5| Optional: md5sum for the R2 file
control| Optional: The sample ID for the control sample (in case of case-control somatic variant calling).
gender| Optional: The gender of the sample. Can be `F`, `f`, `female`, `M`, `m`, `male`. If another value is chosen or gender is left empty, the pipeline will handle this sample as an unknown gender.

The easiest way to create a samplesheet is to use a spreadsheet program
such as LibreOffice Calc or Microsoft Excel, and create a table:

sample | library | readgroup | R1 | R1_md5 | R2 | R2_md5
-------|---------|------|----|--------|----|-------
sample1|lib1|rg1|data/s1-l1-rg1-r1.fastq|||
sample2|lib1|rg1|data/s1-l1-rg1-r2.fastq|||

NOTE: R1_md5, R2 and R2_md5 are optional do not have to be filled. And additional fields may be added (eg. for documentation purposes), these will be ignored by the pipeline.

Or with control information:

sample           | library | readgroup | control        | R1 | R1_md5 | R2 | R2_md5
-----------------|---------|-----------|----------------|----|--------|----|-------
patient1-case    |lib1     |rg1        |patient1-control|data/case1-l1-rg1-r1.fastq|||
patient1-case    |lib1     |rg2        |                |data/case1-l1-rg1-r1.fastq|||
patient1-case    |lib1     |rg3        |                |data/case1-l1-rg1-r1.fastq|||
patient1-control |lib1     |rg1        |                |data/control1-l1-rg1-r1.fastq|||

NOTE: The control only needs one field per sample to be filled. Although
filling more columns is possible if you like to be explicit.
 
After creating the table in a spreadsheet program it can be saved in 
csv format.
 
##### YAML format
The sample configuration can also be a YML file which adheres to the following
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
  "Somatic.sample.Sample.bwaMem.threads": 8,
  "Somatic.sample.Sample.qc.QC.Cutadapt.cores": 4,
  "Somatic.dockerImages.yml": "dockerImages.yml"
}
```

And the associated samplesheet might look like this:

sample | library | read |control| R1 | R1_md5 | R2 | R2_md5
-------|---------|------|-------|----|--------|----|-------
patient1-case|lib1|lane1|patient1-control|/home/user/data/patient1-case/R1.fq.gz|181a657e3f9c3cde2d3bb14ee7e894a3|/home/user/data/patient1-case/R2.fq.gz|ebe473b62926dcf6b38548851715820e
patient1-control|lib1|lane1| |/home/user/data/patient1-control/lane1_R1.fq.gz|7e79b87d95573b06ff2c5e49508e9dbf|/home/user/data/patient1-control/lane1_R2.fq.gz|dc2776dc3a07c4f468455bae1a8ff872
patient1-control|lib1|lane2| |/home/user/data/patient1-control/lane2_R1.fq.gz|18e9b2fef67f6c69396760c09af8e778|/home/user/data/patient1-control/lane2_R2.fq.gz|72209cc64510827bc3f849bab00dfe7d

Saved as csv format it will look like this.
```csv
"sample","library","read","control","R1","R1_md5","R2","R2_md5"
"patient1-case","lib1","lane1","patient1-control","/home/user/data/patient1-case/R1.fq.gz","181a657e3f9c3cde2d3bb14ee7e894a3","/home/user/data/patient1-case/R2.fq.gz","ebe473b62926dcf6b38548851715820e"
"patient1-control","lib1","lane1",,"/home/user/data/patient1-control/lane1_R1.fq.gz","7e79b87d95573b06ff2c5e49508e9dbf","/home/user/data/patient1-control/lane1_R2.fq.gz","dc2776dc3a07c4f468455bae1a8ff872"
"patient1-control","lib1","lane2",,"/home/user/data/patient1-control/lane2_R1.fq.gz","18e9b2fef67f6c69396760c09af8e778","/home/user/data/patient1-control/lane2_R2.fq.gz","72209cc64510827bc3f849bab00dfe7d"
```
The pipeline also supports tab- and ;-delimited files.

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
    for this library (`*.markdup.bam`) and a BAM file with additional 
    preprocessing performed used for variant calling (`*.bsqr.bam`).
    It also contains a directory per library.  
    - **somatic-variantcalling**: Contains somatic variant calling results.
      Only present if `somatic.wdl` is used.  
    - **&lt;library>**: This directory contains a directory per readgroup.
      - **&lt;readgroup>**: Contains QC metrics and preprocessed FastQ files.
- **multisample.vcf.gz**: A multisample VCF file with the variant calling
  results. Only present if `germline.wdl` is used.
- **multiqc**: Contains the multiQC report.

## Scattering
This pipeline performs scattering to speed up analysis on grid computing
clusters. For steps such as variant calling the reference genome is split
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
