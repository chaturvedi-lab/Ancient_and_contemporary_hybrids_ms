#!/usr/bin/env bash

#use samtools version 1.5

module load samtools 

samtools view -b -S -o mem_sample1.bam
samtools sort mem_sample1.bam -o mem_sample1_sorted.bam
samtools index mem_sample1_sorted.bam
