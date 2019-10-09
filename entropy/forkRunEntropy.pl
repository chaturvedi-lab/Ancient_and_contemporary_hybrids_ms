#!/usr/bin/perl
#  Written by Samridhi Chaturvedi
#  This is a perl fork script which creates a child process per chain
#  Usage perl forRunEntropy.pl #forks
#  Modify paths for the genotype likelihood files, outputs and input files for entropy according to your file paths

use warnings;
use strict;
use Parallel::ForkManager;

my $max = shift(@ARGV); #get number of cores to use at one time
my $pm = Parallel::ForkManager->new($max);

#path to the genotype likelihood file
my $in = "examples.gl";
#path to the starting value files
my $qdir = "./";

foreach my $ch (1..3){
        CHAINS:
        foreach my $k (2..5){
                $pm->start and next CHAINS; ##fork;
                print "entropy -i $in -l 8000 -b 5000 -t 3 -k $k -Q 0 -s 50 -q $qdir"."ldak$k.txt -o ./ento_lyc_hybridsCh$ch"."K$k.hdf5 -w 0 -m 1";
                system "entropy -i $in -l 8000 -b 5000 -t 3 -k $k -Q 0 -s 50 -q $qdir"."ldak$k.txt -o ./ento_lyc_hybridsCh$ch"."K$k.hdf5 -w 0 -m 1";
                        $pm->finish; ## exit the child process
                }
        }      


$pm->wait_all_children;
