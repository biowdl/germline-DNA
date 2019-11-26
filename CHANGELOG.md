Changelog
==========

<!--

Newest changes should be on top.

This document is user facing. Please word the changes in such a way
that users understand how the changes affect the new version.
-->

version 2.0.0-dev
---------------------------
+ The bam-to-gvcf and jointgenotyping subworkflows were combined in a single
  gatk-variantcalling pipeline. This allowed for some inefficiencies to be 
  eliminated when communicating between these pipelines.
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
