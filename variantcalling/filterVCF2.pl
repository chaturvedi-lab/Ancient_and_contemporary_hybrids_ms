#!/usr/bin/perl

use warnings;
use strict;

# filter vcf files based on coverage
# Written by Zach Gompert, modified by Samridhi Chaturvedi

# usage vcfFilter.pl infile.vcf
#
# change the marked variables below to adjust settings
#
### stringency variables, edits as desired
my $maxCoverage = 9711; #17162; # maximum depth to avoid repeats, mean + 2sd = 17162.16
my $mind = 3; # don't call if SNPs are closer together than this
##### this set is for whole genome shotgun data
my $tooclose;
my $i;

my @line;
my @scaf;
my @pos;
my @keep;


### get set of SNPs and precompute distnaces ##
#
open(IN, "snpsMales.txt") or die "failed to read the locus info file\n";
while(<IN>){
	m/(\d+)\s+(\d+)/ or die "failed to match $_\n";
	push(@scaf,$1);
	push(@pos,$2);
	push(@keep,1);
}
close(IN);
my $n = @scaf; 
print "checking neighbors for $n SNPs\n";
for($i=0; $i<$n; $i++){
	$tooclose = 0;
	unless($i==0){
		if($scaf[$i] == $scaf[$i-1] and ($pos[$i] - $pos[$i-1]) < $mind){
			$tooclose = 1;
		}
	}
	unless($i==($n-1)){
		if($scaf[$i] == $scaf[$i+1] and ($pos[$i+1] - $pos[$i]) < $mind){
			$tooclose = 1;
		}
	}
	if($tooclose==1){
		$keep[$i] = 0;
	}
}

my $in = shift(@ARGV);
open (IN, "males_filtered2x_variantsLycaeides.vcf") or die "Could not read the infile = $in\n";
#$in =~ m/([a-zA-Z0-9_]+\.vcf)$/ or die "Failed to match the variant file\n";
open (OUT, "> morefilter_$1") or die "Could not write the outfile\n";

my $flag = 0;
my $cnt = 0;

while (<IN>){
	chomp;
	$flag = 1;
	print "\n";
	if (m/^\#/){ ## header row, always write
		$flag = 1;
	}
	elsif (m/^Scaffold_/){ ## this is a sequence line, you migh need to edit this reg. expr.
		$flag = 1;
		m/DP=(\d+)/ or die "Syntax error, DP not found\n";
		if ($1 > $maxCoverage){
			$flag = 0;
			print "fail DP\n";
		}
		$tooclose = shift(@keep);
		if ($tooclose == 0){
			$flag = 0;
			print "fail too close\n";				
		}
		if ($flag == 1){
			$cnt++; ## this is a good SNV
		}
	}
	else{
		print "Warning, failed to match the chromosome or scaffold name regular expression for this line\n$_\n";
		$flag = 0;
	}
	if ($flag == 1){
		print OUT "$_\n";
	}
}
close (IN);
close (OUT);

print "Finished filtering $in\nRetained $cnt variable loci\n";
