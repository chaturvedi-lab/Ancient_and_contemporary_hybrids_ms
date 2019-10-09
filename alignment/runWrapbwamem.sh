#!/bin/bash

## This is a bash script to submit a job to the cluster to run the wrapper perl script to run BWA MEM. Modify directories based on your directory.

## Written by Samridhi Chaturvedi

#SBATCH --job-name=parsebarcodes
#SBATCH --time=140:00:00 #walltime
#SBATCH --nodes=1 #number of cluster nodes
#SBATCH --account=usubio-kp #PI account
#SBATCH --partition=usubio-kp #specify computer cluster, other option is kinspeak


#change this directory to working directory 
cd ./fastqfiles

module load perl
module load bwa

perl wrap_qsub_slurm_bwa_mem.pl *.fastq
