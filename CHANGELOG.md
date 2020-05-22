Changelog
==========

<!--

Newest changes should be on top.

This document is user facing. Please word the changes in such a way
that users understand how the changes affect the new version.
-->

version 4.0.0-dev
-----------------
+ Document the use of cromwell's `final_workflow_outputs_dir` feature which 
  makes the germline and somatic pipelines usable on all of Cromwell's 
  supported backends. Users are encouraged to use this feature. `outputDir` references are removed from the documentation.
+ Make the MultiQC task suitable for use with a `final_workflow_outputs_dir` 
  so it can be used on all of Cromwell's supported backends.
+ Restructure the pipeline so variant calling jobs are scheduled more 
  efficiently.

version 3.0.0
-----------------
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
+ separated somatic and germline variant calling into their own workflows

version 1.1.0
---------------------------
+ Allow using csv table format samplesheet as input format.
+ Update tasks so they pass the correct memory requirements to the 
  execution engine. Memory requirements are set on a per-task (not
  per-core) basis.
+ added option to use bwakit as aligner
+ region input is no longer passed to gatk-preprocess
+ added option to skip germline variant calling 

version 1.0.0
---------------------------
+ Explicitly list all images in dockerimages.yml.
+ Removed fastqsplitter step as it increased complexity with no gains.
  Documented the use of more cores for cutadapt as an alternative.
+ Updated documentation
+ Fastqsplitter: Fixed error and updated to a newer build with an updated [xopen](github.com/marcelm/xopen) dependency
+ Fastqsplitter: use version 1.1.
+ Picard: Use version 2.20.5 of the biocontainer as this includes the R dependency
+ General: Update GATK version to 4.1.2.0 and Picard to 2.19.0
+ Update cutadapt version to 2.4
