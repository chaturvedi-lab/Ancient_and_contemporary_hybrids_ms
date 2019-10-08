#!/usr/bin/perl
# Written by Samridhi Chaturvedi
# creates a child process per chain
# Usage perl forkPopanc.pl #forks
use warnings;
use strict;
use Parallel::ForkManager;

my $max = shift(@ARGV); #get number of cores to use at one time
my $pm = Parallel::ForkManager->new($max);

my $indir = "/uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/popanc/infiles/";
my $outdir = "/uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/popanc/outfiles/";
my @w = (3,5,7);
my @melissa = ("all","submore","sub");
my @idas = ("all","bld_frc","notpure","pure");
my @hpops = ("BLD","BNP", "PSP");
#my @hpops = ("BIC","BTB","DBS","PIN","PSP","RDL","RNV");


#module load gcc
#module load gsl
#module load hdf5

CHAINS:
foreach my $w (@w){
        $pm->start and next CHAINS;
#CHAINS:
        foreach my $pop (@hpops){
                foreach my $mel (@melissa){
                        foreach my $idas (@idas){
                                #$pm->start and next CHAINS; ##fork;
                                my $base = $mel . '_' . $idas . '_' . $pop . '_' . $w;
                                print "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_$idas.txt infiles/comb_melissa_$mel.txt infiles/lyc_genoest_$pop.txt";
                                #system"sleep 2\n";
                                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_$idas.txt infiles/comb_melissa_$mel.txt infiles/lyc_genoest_$pop.txt";
                        $pm->finish; ##exit the child process
        }
        }
        }
}

$pm->wait_all_children;
