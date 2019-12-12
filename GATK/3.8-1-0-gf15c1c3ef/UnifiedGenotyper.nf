params.gatk.path
params.gatk.genome
params.gatk.unified_genotyper.intervals = ''
params.gatk.unified_genotyper.dbsnp = ''
params.gatk.unified_genotyper.output_mode = 'EMIT_VARIANTS_ONLY'

process UnifiedGenotyper {
    tag {"GATK UnifiedGenotyper ${sample_id} - ${rg_id}"}
    label 'GATK_3.8-1-0-gf15c1c3ef'
    label 'GATK_3.8-1-0-gf15c1c3ef_UnifiedGenotyper'
    container = 'quay.io/biocontainers/gatk:3.8--py27_1'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
    tuple val(sample_id), val(rg_id), file(input_bam), file(input_bai)

    output:
    tuple val(sample_id), file("${sample_id}.vcf")

    script:
    def intervals = params.gatk.unified_genotyper.intervals ? "--intervals $params.gatk.unified_genotyper.intervals" : ''
    def dbsnp = params.gatk.unified_genotyper.dbsnp ? "--dbsnp $params.gatk.unified_genotyper.dbsnp" : ''

    """
    java -Xmx${task.memory.toGiga()-4}G -jar $params.gatk.path -T UnifiedGenotyper --reference_sequence $params.gatk.genome --input_file $input_bam --out ${sample_id}.vcf --output_mode $params.gatk.unified_genotyper.output_mode $intervals $dbsnp
    """
}
