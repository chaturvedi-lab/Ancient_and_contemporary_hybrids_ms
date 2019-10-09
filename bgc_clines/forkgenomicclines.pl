#!/usr/bin/perl
## Written by Samridhi Chaturvedi
## creates a child process per chain to run bgc
## usage perl forkFilter.pl #forks
use warnings;
use strict;
use Parallel::ForkManager;
#
my $max = shift(@ARGV); #get number of cores to use at one time
my $pm = Parallel::ForkManager->new($max);

#specify directory for in files
my $dir = './';
#specify directory for output files
my $odir = "./outdir";

CHAINS:
foreach my $j (0..4){
                 $pm->start and next CHAINS; ##fork;
				print "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas.gl -b $dir"."melissa.gl -h $dir"."admixed.gl -F $odir"."bgcout_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
				system"sleep 3\n";
                          	system "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas.gl -b $dir"."melissa.gl -h $dir"."admixed.gl -F $odir"."bgcout_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
                                 }

$pm->wait_all_children;
