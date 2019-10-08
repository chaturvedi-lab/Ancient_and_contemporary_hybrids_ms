#!/usr/bin/env bash

module load samtools
module load bcftools


samtools mpileup -C 50 -d 250 -f /uufs/chpc.utah.edu/common/home/gompert-group1/data/lycaeides/lycaeides_dubois/Alignments/fastqfiles/melissa_blue_21Nov2017_GLtS4.fasta -q 20 -Q 15 -g -I -t DP,DPR -u -b lycaeidesBam.txt -o variantsLycaeides.bcf
bcftools call -v -c -p 0.01 -P 0.001 -O v -o variantsLycaeides.vcf variantsLycaeides.bcf
