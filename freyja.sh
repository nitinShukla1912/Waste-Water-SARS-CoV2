#!/bin/bash

set +x # Enable debug mode

# Set variables
REF_GENOME=~/SARS/SARSCoV2_genome.fasta
FASTQ_DIR=/home/SARS/WateWater-FASTQ/
OUTPUT_DIR=/home/SARS/Out/

for R1_FASTQ in ${FASTQ_DIR}/*_R1_001.fastq.gz; do
  # Get base name of R1 file
  SAMPLE_NAME=$(basename ${R1_FASTQ%%_R1_001.fastq.gz})

  # Get corresponding R2 file
  R2_FASTQ=${FASTQ_DIR}/${SAMPLE_NAME}_R2_001.fastq.gz

  # Map reads to reference genome using BWA
  bwa mem -t 4  $REF_GENOME $R1_FASTQ $R2_FASTQ > $OUTPUT_DIR/${SAMPLE_NAME}.sam

  # Convert SAM file to BAM file
  samtools view -@ 4 -bS $OUTPUT_DIR/${SAMPLE_NAME}.sam > $OUTPUT_DIR/${SAMPLE_NAME}.bam

  # Sort BAM file
  samtools sort -@ 4 -o $OUTPUT_DIR/${SAMPLE_NAME}_sorted.bam $OUTPUT_DIR/${SAMPLE_NAME}.bam

  # Index BAM file
  samtools index $OUTPUT_DIR/${SAMPLE_NAME}_sorted.bam

  # freyja variants

  freyja variants $OUTPUT_DIR/${SAMPLE_NAME}_sorted.bam --variants $OUTPUT_DIR/${SAMPLE_NAME}.variants --depths $OUTPUT_DIR/${SAMPLE_NAME}.d --ref $REF_GENOME

  # freyja demix

  freyja demix $OUTPUT_DIR/${SAMPLE_NAME}.variants.tsv $OUTPUT_DIR/${SAMPLE_NAME}.d --output $OUTPUT_DIR/${SAMPLE_NAME}.demix.out

done
