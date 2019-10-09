#!/usr/bin/perl
# Written by Samridhi Chaturvedi
# creates a child process per chain
# Usage perl forkPopanc.pl #forks
use warnings;
use strict;
use Parallel::ForkManager;

my $max = shift(@ARGV); #get number of cores to use at one time
my $pm = Parallel::ForkManager->new($max);

my $indir = "./";
#modify this directory
my $outdir = "./outfiles/";
my @w = (3,5,7);
my @hpops = ("BLD","BIC");

CHAINS:
foreach my $w (@w){
        $pm->start and next CHAINS;
#CHAINS:
        foreach my $pop (@hpops){
                my $base = $mel . '_' . $idas . '_' . $pop . '_' . $w;
                print "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 ./idas.txt ./melissa.txt ./lyc_genoest_$pop.txt";
                #system"sleep 2\n";
                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 ./idas.txt ./melissa.txt ./lyc_genoest_$pop.txt"";
                        $pm->finish; ##exit the child process
        }
}

$pm->wait_all_children;
