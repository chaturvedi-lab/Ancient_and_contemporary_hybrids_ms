#!/usr/bin/env bash
#! /bin/bash

# written by Samridhi Chaturvedi
# This script runs the perl wrapper script for VCF filtering on the cluster. 

#In this script replace the path to the genome with your file path given by option -f.



#!/bin/bash
#SBATCH --job-name=genomeindex
#SBATCH --time=140:00:00 #walltime
#SBATCH --nodes=1 #number of cluster nodes
#SBATCH --account=usubio-kp #PI account
#SBATCH --partition=usubio-kp #specify computer cluster, other option is kinspeak

cd /uufs/chpc.utah.edu/common/home/gompert-group1/data/lycaeides/lycaeides_dubois/Variants

module load perl

perl filterVCF1.pl variantsLycaeides.vcf
