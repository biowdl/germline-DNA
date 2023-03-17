---
layout: default
title: Home
---

This repository contains two workflows. The first is a workflow for
germline variant calling and the second is a somatic variant calling
workflow.
These workflows can be used to process DNA data (WES or WGS), starting
with FastQ files. They will perform quality control (using FastQC and
MultiQC), adapter clipping (using cutadapt), mapping (using BWA mem or
bwakit) and variant calling (based on the
[GATK Best Practice](https://software.broadinstitute.org/gatk/best-practices/)
for germline calling, and using a variety of callers for somatic calling).
Optionally, the somatic workflow can also perform CNV calling and SV calling.

This workflow is part of [BioWDL](https://biowdl.github.io/)
developed by the SASC team
at [Leiden University Medical Center](https://www.lumc.nl/).

## Usage

### MiniWDL
For local and HPC usage we recommend using [miniwdl](
https://github.com/chanzuckerberg/miniwdl). Miniwdl can run on HPC clusters 
using the [miniwdl-slurm](https://github.com/miniwdl-ext/miniwdl-slurm) 
extension.

First download the latest version of the workflow zip file from
the [releases page](https://github.com/biowdl/germline-DNA/releases).


The workflow can then be started with the following command:

```bash
miniwdl run \
  --cfg miniwdl.cfg \
  -i inputs.json \
  -d output/. \
  <workflow>_v<version>.zip

```
`output/.` ensures the output ends up in the directory called `output`. If the
`.` is omitted, miniwdl will create a subfolder.

`miniwdl.cfg` contains at least the following settings:

```
[file_io]
allow_any_input=true
copy_input_files_for=["MultiQC"]
use_relative_output_paths=true  # This will lead to a predictable output structure

[task_runtime]
as_user = true
```
Miniwdl also allows setting global configuration values. See the 
[miniwdl documentation on configuration](
https://miniwdl.readthedocs.io/en/latest/runner_reference.html#configuration) 
for more details.


### Cromwell
This workflow can also be run using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):

First download the latest version of the workflow wdl file(s)
and zip imports package from
the [releases page](https://github.com/biowdl/germline-DNA/releases).

The workflow can then be started with the following command:
```bash
java \
    -jar cromwell-<version>.jar \
    run \
    -o options.json \
    -i inputs.json \
    --imports <workflow>_v<version>.zip \
    <workflow>_<version>.wdl
```

Where `options.json` contains the following json:
```json
{
    "final_workflow_outputs_dir": "/path/to/outputs",
    "use_relative_output_paths": true,
    "final_workflow_log_dir": "/path/to/logs/folder"
}
```

The `options.json` will make sure all outputs end up in `/path/to/outputs` in
an easy to navigate folder structure.

### Inputs
Inputs are provided through a JSON file. The minimally required inputs are
described below, but additional inputs are available.
A template containing all possible inputs can be generated using
Womtool as described in the
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
For an overview of all available inputs, see the following pages:
- [germline](./germline-inputs.html)
- [somatic](./somatic-inputs.html)

Replace `<workflow>` with either `Germline` or `Somatic`. 

```json
{
    "<workflow>.dbsnpVCF": "A path to a dbSNP VCF file.",
    "<workflow>.sampleConfigFile": "A sample configuration file (see below).",
    "<workflow>.referenceFasta": "A path to a reference fasta.",
    "<workflow>.dockerImagesFile": "A file listing the used docker images."
}
```

The above omits the index files, which are automatically created if not
provided. If you want to use a custom BWA index (for instance, using an alt 
file for use with bwa-kit) you can specify it. Other indexes can also be given
to omit the indexing tasks:

```json 
{
    "<workflow>.bwaIndex": {
        "fastaFile": "A path to the fasta file from the bwa index.",
        "indexFiles": "A list containing the other bwa index files."
    },
    "<workflow>.dbsnpVCFIndex": "The path to the index (.tbi) file associated with the dbSNP VCF.",
    "<workflow>.referenceFastaFai": "The path to the index associated with the reference fasta.",
    "<workflow>.referenceFastaDict": "The path to the dict file associated with the reference fasta."
}    
```

Alternatively you can specify an index for bwa-mem2. When you do so, bwa-mem2
will be used for alignment.

```json
{
    "<workflow>.bwaMem2Index": {
        "fastaFile": "A path to the fasta file from the bwa index.",
        "indexFiles": "A list containing the other bwa index files."
    }
}
```

Specific inputs for the germline workflow are:
```json
{
    "Germline.XNonParRegions": "(Optional) A BED file that lists all the non-PAR regions on the X chromosome.",
    "Germline.YNonParRegions": "(Optional) A BED file that lists all the non-PAR regions on the Y chromosome.",
    "Germline.jointgenotyping": "Whether to call a multisample VCF using JointGenotyping or not.",
    "Germline.singleSampleGvcf": "Whether to create a GVCF file for each sample."
}
```

These region files are required in order to have gender-aware variantcalling,
were the non-PAR region of the X and Y chromosome is called with ploidy 1 for
males and the Y chromosome is not called for females.

For samples with unknown gender the non-PAR regions of X will be called with
ploidy 2 and the non-PAR regions of Y will be called with ploidy 1 to ensure
no variants are missed, regardless of the gender.

Specific inputs for the somatic workflow are:
```json
{
    "Somatic.preprocessedIntervals": "The preprocessed intervals to be used for CNV calling.",
    "Somatic.performCnvCalling": "Whether or not CNV calling should be performed.",
    "Somatic.CnvPanelOfNormals": "A Panel of normals to be used for CNV calling."
}
```

There are also the booleans `runStrelka`, `runVardict`, `runMutect2` and
`runManta` which can turn somatic variant callers on or off (default: all
are on).

The panel of normals and preprocessed intervals will be generated on the fly
if not provided in the inputs. All samples for which no `control` is given in
the samplesheet will be used to generate the panel of normals.

Some additional inputs which may be of interest are:
```json
{
    "<workflow>.platform": "The sequencing platform used. Default: illumina.",
    "<workflow>.scatterSize": "The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.",
  "<workflow>.regions": "Bed file with regions used for variantcalling.",
  "<workflow>.adapterForward": "The adapters to be cut from the forward reads. Default: Illumina Universal Adapter.",
  "<workflow>.adapterReverse": "The adapters to be cut from the reverse reads (if paired-end reads are used). Default: Illumina Universal Adapter.",
  "<workflow>.useBwaKit": "Whether bwakit should be used instead of plain BWA mem, this will required an '.alt' file to be present in the index."
}
```
#### UMI

In case UMI deduplication needs to be performed `"<workflow>.umiDeduplication": true`
needs to be set in the inputs JSON file. 
The FASTQ files need to be processed such that the UMI is appended to the 
read ID. [umi-tools extract](https://umi-tools.readthedocs.io/en/latest/reference/extract.html) 
can be used to perform this task.

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

##### CSV format
The sample configuration can be given as a csv file with the following
columns: sample, library, readgroup, R1, R1_md5, R2, R2_md5.

column name | function
---|---
sample | sample ID
library | library ID. These are the libraries that are sequenced. Usually
there is only one library per sample.
readgroup | readgroup ID. Usually a library is sequenced on multiple lanes in
the sequencer, which gives multiple fastq files (referred to as readgroups).
Each readgroup pair should have an ID.
R1| The fastq file containing the first reads of the read pairs.
R1_md5 | Optional: md5sum for the R1 file.
R2| Optional: The fastq file containing the reverse reads.
R2_md5| Optional: md5sum for the R2 file.

The easiest way to create a samplesheet is to use a spreadsheet program
such as LibreOffice Calc or Microsoft Excel, and create a table:

sample | library | readgroup | R1 | R1_md5 | R2 | R2_md5
-------|---------|------|----|--------|----|-------
sample1|lib1|rg1|data/s1-l1-rg1-r1.fastq|||
sample2|lib1|rg1|data/s1-l1-rg1-r2.fastq|||

NOTE: R1_md5, R2 and R2_md5 are optional do not have to be filled. And
additional fields may be added (eg. for documentation purposes), these will be
ignored by the workflow.

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
    control: <sample id for associated control> # Only used in the somatic workflow
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
in the somatic-variantcalling workflow, in which somatic-variantcalling
will be performed for the indicated pair.

#### Example
The following is an example of what an inputs JSON might look like. This
example is for the somatic-variantcalling workflow, however the same values
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
    "Somatic.dbsnpVCF": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz",
    "Somatic.dbsnpVCFIndex": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz.tbi",
    "Somatic.sampleConfigFiles": "/home/user/analysis/samples.yml",
    "Somatic.referenceFasta": "/home/user/genomes/human/GRCh38.fasta",
    "Somatic.referenceFastaFai": "/home/user/genomes/human/GRCh38.fasta.fai",
    "Somatic.referenceFastaDict": "/home/user/genomes/human/GRCh38.dict",
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

The workflow also supports tab- and ;-delimited files.

## Dependency requirements and tool versions
Biowdl workflows use docker images to ensure reproducibility. This
means that biowdl workflows will run on any system that has docker
installed. Alternatively they can be run with singularity.

For more advanced configuration of docker or singularity please check
the [cromwell documentation on containers](
https://cromwell.readthedocs.io/en/stable/tutorials/Containers/).

Images from [biocontainers](https://biocontainers.pro) are preferred for
biowdl workflows. The list of default images for this workflow can be
found in the default for the `dockerImages` input.

## Output
The workflow will output mapped reads by minimap2 in a .sam file. A
cleaned .sam file and log information from transcriptclean. A database
containing transcript information together with a log file of
read/transcript comparison and a abundance plus summary file of the database.
It will also output fastqc and picard statistics based on the fastq files and
minimap2 alignment files, combined into a multiqc report.

### Output
This workflow will produce a number of directories and files:
- **samples**: Contains a folder per sample.
  - **&lt;sample>**: Contains a variety of files, including the BAM files
    for this library (`*.markdup.bam`) and a BAM file with additional
    preprocessing performed used for variant calling (`*.bsqr.bam`).
    It contains the vcf file for the sample if germline.wdl was used and
    a single sample vcf was produced.
    It also contains a directory per readgroup.
    - **structural-variants**: Structural variant calling results per
      caller and the merged results from SURVIVOR. Only present if 
      `germline.wdl` is used with SV calling enabled.
    - **CNVcalling**: Contains the CNV calling results for this sample
      and its control sample. Only present if `somatic.wdl` is used with
      CNV calling enabled.
    - **somatic-variantcalling**: Contains somatic variant calling results.
      Only present if `somatic.wdl` is used.
    - **&lt;library>**: This directory contains a directory per readgroup.
      - **&lt;readgroup>**: Contains QC metrics and preprocessed FastQ files.
- **multisample.vcf.gz**: A multisample VCF file with the variant calling
  results. Only present if `germline.wdl` is used.
- **multiqc_report.html**: The multiQC report.
- **PON**: A generated panel of normals and the preprocessed intervals.
  Only present if `somatic.wdl` is used with CNV calling enabled and no
  PON or preprocessed intervals were provided in the inputs.
- **somatic-sv-calling**: Somatic SV calling results. Only present if
  `somatic.wdl` is used with SV calling enabled.
  - **&lt;sample>**: SV results for Delly and Manta per tumor sample.
  - **gridss**: GRIDSS results per normal and the generated PON files 
    (if no PON was provided in the inputs).

## Scattering
This workflow performs scattering to speed up analysis on grid computing
clusters. For steps such as variant calling the reference genome is split
into regions of roughly equal size (see the `scatterSize` inputs).
Each of these regions will be analyzed in separate jobs, allowing them
to be processed in parallel.

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any questions about running this workflow and feature requests (such as
adding additional tools and options), please use the
<a href="https://github.com/biowdl/germline-DNA/issues">github issue tracker</a>
or contact the SASC team directly at: 
<a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;">
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
