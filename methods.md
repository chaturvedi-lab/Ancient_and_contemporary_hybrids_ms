These are just general outline and notes for what I have done so far for the Dubois hybridization project. This document has all the figures and scripts used for doing all the analysis. I will obviously keep adding more details for the methods, but I just wanted to get an idea of the methods outline as I want to repeat this analysis with only males.

I have 835 individuals from 23 populations included in this study. Here is a table of details for each population:

Population  species  number of individuals
----------  -------  ---------------------
BIC         melissa  18
BCR 	      hybrid	 46
BLD 	      idas	   74
BNP 	      hybrid	 20
BST 	      melissa	 24
BTB  	      hybrid	 46
CDY 	      melissa	 23
CKV 	      melissa	 10
DBS 	      hybrid	 115
FRC 	      idas	   20
GNP 	      idas	   98
LAN  	      melissa	 24
MON  	      melissa	 20
KHL 	      idas	   18
PIN 	      hybrid	 20
PSP 	      hybrid	 20
RDL 	      hybrid	 30
RNV 	      hybrid	 32
SDC 	      idas	   20
SYC 	      idas	   20
YWP       	melissa	 20
SIN 	      melissa	 97
VIC 	      melissa	 20

**Table 1: Details of the populations used in this study**

Alignment and variant calling
-----------------------------

**Alignments**

1. I used `bwa mem` for aligning fastq files to the reference genome. I used a `perl wrapper` script to submit the job for this step. Basically, I aligned each fastq file against the reference genome. This will create a `sam` file which will be used in the next step. Here is the command I used:

```bash
bwa mem -t 12 -k 15 -r 1.3 -T 30 $genome $file > mem"."$file".".sam

-t =  number of threads [1]
-k =  minimum seed length [19]
-r = look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
-T = minimum score to output [30]
$genome = dovetail genome
$file = fastq files
```
2. I then converted the sam file to bam file. For this I used `samtools` version 1.5. I first sorted and then indexed the sam files to create the final bam file. Here is the command I used:

```bash
samtools view -b -S -o $out"."bam $file"
samtools sort $out"."bam -o $out"."sorted.bam"
samtools index $out"."sorted.bam"
```

Before moving on to variant calling, I calculated the number of mapped reads for each population. These are listed in the table below in the column *no. of mapped reads*. To do this I created a shell script to run for loops to output the number of mapped reads in a text file. I then ran the python script **findreadcount_v2.py** on this text file to calculate total mapped reads for each population group. 

The for loop for this is (this is an example for DBS but this should be repeated for each population):

```bash
for f in memDBS*.sorted.bam; do samtools flagstat $f; done >> outDBS.txt
```

**Variant Calling**

I used `samtools mpileup` and `bcftools call` for variant calling. I used samtools version 1.5 and bamtools version 1.6 for variant calling. Note that bcftools view is now replaced by bcftools call. Here are the commands for variant calling in the shell script which takes genome, and a list of bam files as input (not the path to bam files but a list containing names of all the bam files). Here is the bash script I used for this:

```bash
#!/bin/sh                                      
#SBATCH --time=96:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --account=usubio-kp
#SBATCH --partition=usubio-kp
#SBATCH --job-name=variantcalling
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=samridhi.chaturvedi@gmail.com

    echo ------------------------------------------------------
    echo SLURM: job identifier is $SLURM_JOBID
    echo SLURM: job name is $SLURM_JOB_NAME
    echo ------------------------------------------------------

#SAMTOOLs mpileup version 1.5 options used:
#C = adjust mapping quality; recommended:50, disable:0 [0]
#d = max per-file depth; avoids excessive memory usage [250]
#f = faidx indexed reference sequence file
#q = skip alignments with mapQ smaller than INT [0]
#Q = skip bases with baseQ/BAQ smaller than INT [13]
#g = generate genotype likelihoods in BCF format
#t = --output-tags LIST  optional tags to output:DP,AD,ADF,ADR,SP,INFO/AD,INFO/ADF,INFO/ADR []

#BCFTOOLs call version 1.6 options used
#v = output variant sites only
#c/m = he original calling method (conflicts with -m) or alternative model for multiallelic and rare-variant calling (conflicts with -c)
#p = variant if P(ref|D)<FLOAT with -c [0.5]
#P =  --prior <float-o mutation rate (use bigger for greater sensitivity), use with -m [1.1e-3]
#O =  output type: 'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' (here it is 'v') 
#o = write output to a file [standard output]

module load samtools
module load bcftools
cd /uufs/chpc.utah.edu/common/home/gompert-group1/data/lycaeides/lycaeides_dubois/Alignments/bamfiles

samtools mpileup -C 50 -d 250 -f /uufs/chpc.utah.edu/common/home/gompert-group1/data/lycaeides/lycaeides_dubois/Alignments/fastqfiles/melissa_blue_21Nov2017_GLtS4.fasta -q 20 -Q 15 -g -I -t DP,DPR -u -b lycaeidesBam.txt -o variantsLycaeides.bcf
bcftools call -v -c -p 0.01 -P 0.001 -O v -o variantsLycaeides.vcf variantsLycaeides.bcf 
```
This script will output a vcf (variant calling format) file. This is the main variants file and needs to be further filtered to create the final variants file.


Filtering of variants
-----------------------------



Common and rare variants
-----------------------------

Entropy
-----------------------------

Admixture proportions
-----------------------------

popanc
-----------------------------

Genomic clines
-----------------------------