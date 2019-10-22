version 1.0

import "tasks/common.wdl" as common

struct Readgroup {
    String id
    String lib_id
    File R1
    File? R2
}

struct Sample {
    String id
    String? control
    Array[Readgroup] readgroups
}

struct SampleConfig {
    Array[Sample] samples
}
