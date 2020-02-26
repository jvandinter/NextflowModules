process BWASW {
    tag {"BWA BWASW ${sample_id} - ${rg_id}"}
    label 'BWA_0_7_17'
    label 'BWA_0_7_17_BWASW'
    container = 'quay.io/biocontainers/bwa:0.7.17--hed695b0_6'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
    tuple sample_id, rg_id, file(fastq: "*")

    output:
    tuple sample_id, rg_id, file("${fastq[0].simpleName}.sam")

    script:
    """
    bwa bwasw -t ${task.cpus} $params.optional $params.genome $fastq > ${fastq[0].simpleName}.sam
    """
}
