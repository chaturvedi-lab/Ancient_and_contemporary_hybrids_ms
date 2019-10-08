#!/usr/bin/env bash

#use samtools version 1.5

module load samtools 

samtools view -b -S -o $out"."bam $file"
samtools sort $out"."bam -o $out"."sorted.bam"
samtools index $out"."sorted.bam"
