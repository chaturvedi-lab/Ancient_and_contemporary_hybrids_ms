#!/bin/bash
# Bash script to run the perl fork script for popanc on the cluster.
# Written by Samridhi Chaturvedi

#SBATCH -n 12 
#SBATCH -N 1
#SBATCH -t 100:00:00
#SBATCH -p usubio-kp
#SBATCH -A usubio-kp
#SBATCH -J popanc

module load gcc
module load gsl
module load hdf5
module load perl

#specify path to working directory
cd /uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/popanc/
perl ./forkrunpopanc.pl 10
