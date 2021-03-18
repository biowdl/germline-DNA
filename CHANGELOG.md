Changelog
==========

<!--

Newest changes should be on top.

This document is user facing. Please word the changes in such a way
that users understand how the changes affect the new version.
-->

version 4.1.0-dev
---------------------------
+ sample.wdl: Remove postUmiDedupMarkDuplicates.
+ dockerImages.yml: Update umitools (v1.1.1) image (include samtools for indexing)
+ Replace travis with github CI.
+ `renamedVCFs` was changed to `modifiedVcfs`.
+ Add the dockerImages to the output section.
+ Add bwa-mem2 capability.

version 4.0.0
---------------------------
+ Updated default versions for several tools to the newest version. Pin the
  volatile python container to a specific hash digest.
+ Changes in Cromwell 48 made it impossible to use the wide array of inputs
  in our documentation (such as
  `Germline.sampleWorkflow.QC.Cutadapt.minimumLength`). Fixes have been made
  upstream and in the pipeline. From Cromwell 52 onwards these options are
  available again.
+ WDL files and import zip packages are now offered with every release to
  make downloading and running much easier.
+ The output directory was restructured to contain less nested folders.
+ Performance has improved as a result of extensive benchmarking and profiling.
  Details can be
  found [here](https://github.com/biowdl/ngs-performance-choices/).
+ Added a bwaThreads option to the input. This sets the number of threads used
  by the BWA aligner, and is a major influencer of wall clock time.
+ Use scatter-regions from the chunked-scatter python package as scattering
  tool. The old biopet-scatterregions package did not support scattersizes
  larger than 2 billion, making it impossible to have the whole human genome
  in one scatter.
+ Use sambamba markdup for marking duplicates with 2 threads which reduces
  wall clock time.
+ Updated default BWA containers. Both `bwa` and `bwakit` now contain 0.7.17
  and include samtools 1.10 for fast sorting.
+ Added bcftools stats to the pipeline for variant
  statistics. These stats are reported in the MultiQC report.
+ Tasks were updated to contain the `time_minutes` runtime attribute and
  associated `timeMinutes` input, describing the maximum time the task will
  take to run.
+ Document the use of cromwell's `final_workflow_outputs_dir` feature which
  makes the germline and somatic pipelines usable on all of Cromwell's
  supported backends. Users are encouraged to use this feature. `outputDir`
  references are removed from the documentation.
+ Make the MultiQC task suitable for use with a `final_workflow_outputs_dir`
  so it can be used on all of Cromwell's supported backends.
+ Restructure the pipeline so variant calling jobs are scheduled more
  efficiently.

version 3.0.0
---------------------------
+ Add options to disable joint genotyping and allow per sample variant calling.
+ Make sure all important options are in the input section. No more nested
  inputs should be required for running this workflow.
+ Add scatterSize option to centrally control the scatter size
+ Add Structural-variantcalling workflow
+ Add proper copyright headers to WDL files. So the free software license
  is clear to end users who wish to adapt and modify.
+ Restructured inputs to not use unnecessary structs.
+ Added option for somatic CNV calling.
+ Added option for gender-aware variantcalling of X and Y non-PAR regions are
  provided.
+ Added wdl-aid to linting.
+ Added miniwdl to linting.

version 2.0.0
---------------------------
+ The bam-to-gvcf and jointgenotyping subworkflows were combined in a single
  gatk-variantcalling pipeline. This allowed for eliminating some
  inefficiencies that were caused by communication between these pipelines.
+ Simplify the pipelines so they use less subworkflows. This reduces
  the complexity for cromwell and reduces inefficiencies that are caused
  by waiting for the subworkflows to finish.
  It also makes configuring memory or cpu requirements for tasks in the
  workflow a lot easier, as these are not as deeply nested anymore.
+ Separated somatic and germline variant calling into their own workflows.

version 1.1.0
---------------------------
+ Allow using csv table format samplesheet as input format.
+ Update tasks so they pass the correct memory requirements to the
  execution engine. Memory requirements are set on a per-task (not
  per-core) basis.
+ Added option to use bwakit as aligner.
+ Region input is no longer passed to gatk-preprocess.
+ Added option to skip germline variant calling.

version 1.0.0
---------------------------
+ Explicitly list all images in dockerimages.yml.
+ Removed fastqsplitter step as it increased complexity with no gains.
  Documented the use of more cores for cutadapt as an alternative.
+ Updated documentation.
+ Fastqsplitter: Fixed error and updated to a newer build with an
  updated [xopen](github.com/marcelm/xopen) dependency.
+ Fastqsplitter: use version 1.1.
+ Picard: Use version 2.20.5 of the biocontainer as this includes the
  R dependency.
+ General: Update GATK version to 4.1.2.0 and Picard to 2.19.0.
+ Update cutadapt version to 2.4.
