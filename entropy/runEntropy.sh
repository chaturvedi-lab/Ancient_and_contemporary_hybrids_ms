#!/bin/bash
#written by Samridhi Chaturvedi
#change options
#SBATCH -n 12
#SBATCH -N 1
#SBATCH -t 360:00:00
#SBATCH -p gompert-kp
#SBATCH -A gompert-kp
#SBATCH -J entropy

module load gcc
module load gsl
module load hdf5
module load perl

#define path to directory for the perl fork script to run entropy.

cd /uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/entropy
perl ./forkRunEntropy.pl 10
