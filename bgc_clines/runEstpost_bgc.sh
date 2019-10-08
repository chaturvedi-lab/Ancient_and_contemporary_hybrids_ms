#! /bin/bash

# written by Samridhi Chaturvedi
# this script uses estimates posterior probabilities from hdf5 files from the bgc output


for i in *.hdf5; do
/uufs/chpc.utah.edu/common/home/u6000989/bin/estpost_bgc -i $i -s 0 -w -o -p beta
mv postout.txt ${i%.hdf5.txt}_beta.txt;
done
