#! /bin/bash

# written by Samridhi Chaturvedi
# this script uses estimates posterior probabilities from hdf5 files from the bgc output

## calculate means, medians and CI by giving -p beta
for i in *.hdf5; do
#specify path to bgc
/uufs/chpc.utah.edu/common/home/u6000989/bin/estpost_bgc -i $i -s 0 -w -o -p beta
mv postout.txt ${i%.hdf5.txt}_beta.txt;
done

# For predictability tests, I used the MCMC outputs for each chain. To do this, first use the following bash loop to output the MCMC point data for each chain:
for i in *.hdf5; do
#specify path to bgc
/uufs/chpc.utah.edu/common/home/u6000989/bin/estpost_bgc -i $i -s 2 -w -o -p alpha
mv postout.txt ${i%.hdf5.txt}_mcmc_alpha.txt;
done

for i in *.hdf5; do
#specify path to bgc
/uufs/chpc.utah.edu/common/home/u6000989/bin/estpost_bgc -i $i -s 2 -w -o -p beta
mv postout.txt ${i%.hdf5.txt}_mcmc_beta.txt;
done
