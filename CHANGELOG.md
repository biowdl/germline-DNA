Changelog
==========

<!--

Newest changes should be on top.

This document is user facing. Please word the changes in such a way
that users understand how the changes affect the new version.
-->

version 1.1.0-dev
---------------------------
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
