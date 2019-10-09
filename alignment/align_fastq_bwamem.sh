#! /bin/bash

# written by Samridhi Chaturvedi
# this script parses through the current directoy and aligns all .fastq files to a reference (REF)
# BWA MEM is the alignment algorithm used in this script

module load bwa

# change this path to your reference genome or pseudo-reference genome created in the first part of the lycaeides_GBS_pipeline cheat sheet
genome ='/uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/lycaeides_dubois/Alignments/fastqfiles/melissa_blue_21Nov2017_GLtS4.fasta

bwa mem -t 12 -k 15 -r 1.3 -T 30 $genome GNP08-30M.fastq > memGNP08-03M.fastq.sam
