

for i in *.hdf5; do
/uufs/chpc.utah.edu/common/home/u6000989/bin/estpost_bgc -i $i -s 0 -w -o -p beta
mv postout.txt ${i%.hdf5.txt}_beta.txt;
done
