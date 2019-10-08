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

#directory for in files
my $dir = '/uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/clines/';
#directory for output files
my $odir = "/uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/clines/outfiles/";

CHAINS:
foreach my $j (0..4){
                 $pm->start and next CHAINS; ##fork;
				print "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas_p01_pct1.gl -b $dir"."melissa_p02_pct1.gl -h $dir"."admixed_dbs_pct1.gl -F $odir"."bgcout_pct1_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
                                print "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas_p01_pct2.gl -b $dir"."melissa_p02_pct2.gl -h $dir"."admixed_dbs_pct2.gl -F $odir"."bgcout_pct2_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
                                print "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas_p01_pct3.gl -b $dir"."melissa_p02_pct3.gl -h $dir"."admixed_dbs_pct3.gl -F $odir"."bgcout_pct3_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
				system"sleep 3\n";
                          	system "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas_p01_pct1.gl -b $dir"."melissa_p02_pct1.gl -h $dir"."admixed_dbs_pct1.gl -F $odir"."bgcout_pct1_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
				system "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas_p01_pct2.gl -b $dir"."melissa_p02_pct2.gl -h $dir"."admixed_dbs_pct2.gl -F $odir"."bgcout_pct2_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
				system "/uufs/chpc.utah.edu/common/home/u6000989/bin/bgc -a $dir"."idas_p01_pct3.gl -b $dir"."melissa_p02_pct3.gl -h $dir"."admixed_dbs_pct3.gl -F $odir"."bgcout_pct3_$j -O 0 -x 25000 -n 5000 -t 5 -p 1 -q 1 -N 1 -m 0 -d 1 -s 1 -I 1 -T 0";
                                 }

$pm->wait_all_children;
