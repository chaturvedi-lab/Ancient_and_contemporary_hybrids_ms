#!/usr/bin/perl
# Written by Samridhi Chaturvedi
# creates a child process per chain
# Usage perl forkPopanc.pl #forks
use warnings;
use strict;
use Parallel::ForkManager;

my $max = shift(@ARGV); #get number of cores to use at one time
my $pm = Parallel::ForkManager->new($max);

#directory for input files
my $indir = "/uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/popanc/infiles/";
#directory to write output files
my $outdir = "/uufs/chpc.utah.edu/common/home/u6007910/projects/lyc_dubois/popanc/outfiles/";
my @w = (3,5,7);
#my @melissa = ("all","submore","sub");
#my @idas = ("all","bld_frc","notpure","pure");
my @hpops = ("BLD","BNP", "PSP");
#my @hpops = ("BIC","BTB","DBS","PIN","PSP","RDL","RNV");


#module load gcc
#module load gsl
#module load hdf5

CHAINS:
foreach my $w (@w){
		foreach my $pop (@hpops){
		 		$pm->start and next CHAINS; ##fork;
				my $base = $pop . '_' . $w;
				#print "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_$idas.txt infiles/comb_melissa_$mel.txt infiles/lyc_genoest_$pop.txt";
				#system"sleep 2\n";
				#melissa all
				system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_all_all_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_all.txt infiles/comb_melissa_all.txt infiles/lyc_genoest_$pop.txt"; 
				system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_all_bldfrc_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_bld_frc.txt infiles/comb_melissa_all.txt infiles/lyc_genoest_$pop.txt";  
				system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_all_notpure_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_notpure.txt infiles/comb_melissa_all.txt infiles/lyc_genoest_$pop.txt";  
				system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_all_pure_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_pure.txt infiles/comb_melissa_all.txt infiles/lyc_genoest_$pop.txt";  
				#melissa submore
				 system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_submore_all_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_all.txt infiles/comb_melissa_submore.txt infiles/lyc_genoest_$pop.txt";      
                                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_submore_bldfrc_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_bld_frc.txt infiles/comb_melissa_submore.txt infiles/lyc_genoest_$pop.txt";  
                                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_submore_notpure_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_notpure.txt infiles/comb_melissa_submore.txt infiles/lyc_genoest_$pop.txt";  
                                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_submore_pure_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_pure.txt infiles/comb_melissa_submore.txt infiles/lyc_genoest_$pop.txt"; 
				#melissa sub
				system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_sub_all_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_all.txt infiles/comb_melissa_sub.txt infiles/lyc_genoest_$pop.txt";
                                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_sub_bldfrc_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_bld_frc.txt infiles/comb_melissa_sub.txt infiles/lyc_genoest_$pop.txt";
                                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_sub_notpure_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_notpure.txt infiles/comb_melissa_sub.txt infiles/lyc_genoest_$pop.txt";
                                system "/uufs/chpc.utah.edu/common/home/u6000989/bin/popanc -o $outdir"."out_sub_pure_$base.hdf5 -n $w -d 15000 -m 10000 -b 5000 -t 10 -s 1 -q 1 -z 1 infiles/comb_idas_pure.txt infiles/comb_melissa_sub.txt infiles/lyc_genoest_$pop.txt";

			$pm->finish; ##exit the child process
	}
	
}

$pm->wait_all_children;
