#! /bin/bash

module load bwa

#-t =  number of threads [1]
#-k =  minimum seed length [19]
#-r = look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
#-T = minimum score to output [30]
#genome = lycaeidesmelissa.fasta
#fastq file = sample1.fastq


bwa mem -t 12 -k 15 -r 1.3 -T 30 lycaeidesmelissa.fasta sample1.fastq > mem_sample1.sam

