#!/usr/bin/env bash
#! /bin/bash

# written by Samridhi Chaturvedi
# this script parses through the current directoy and converts all the .bam files to .sam files. It then sorts and indexes the sam files.
# I use samtools version 1.5 in this script.

module load samtools 

for file in *.bam;
do

samtools view -b -S -o $out"."bam $file"
samtools sort $out"."bam -o $out"."sorted.bam"
samtools index $out"."sorted.bam"
done
