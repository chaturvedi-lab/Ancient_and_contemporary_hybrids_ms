#! /bin/bash

module load bwa

#-t =  number of threads [1]
#-k =  minimum seed length [19]
#-r = look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
#-T = minimum score to output [30]
#$genome = dovetail genome
#$file = fastq files


bwa mem -t 12 -k 15 -r 1.3 -T 30 $genome $file > mem"."$file".".sam

