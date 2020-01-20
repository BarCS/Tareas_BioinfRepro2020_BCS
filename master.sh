#Step1

#Do a loop
## Directory

``src=$HOME/research/project``

## Do variable
files=”sample_01 
sample_02
sample_03”``

#
## Align with GSnap and convert to BAM
#
```
for file in $files do gsnap -t 36 -n 1 -m 5 -i 2 --min-coverage=0.90 \
			-A sam -d gac_gen_broads1_e64 \
			-D ~/research/gsnap/gac_gen_broads1_e64 \
			$src/samples/${file}.fq > $src/aligned/${file}.sam
	samtools view -b -S -o $src/aligned/${file}.bam $src/aligned/${file}.sam 
	rm $src/aligned/${file}.sam
	done```
	
	
# Step 2
## Do other loop
## Run Stacks on the gsnap data; the i variable will be our ID for each sample we process.
# 
```
i=1 
for file in $files 
do 
	pstacks -p 36 -t bam -m 3 -i $i \
	 		 -f $src/aligned/${file}.bam \
	 		 -o $src/stacks/ 
	let "i+=1"; 
done``` 

# Step 3

# Use a loop to create a list of files to supply to cstacks.
# 
```
samp="" 
for file in $files 
do 
	samp+="-s $src/stacks/$file "; 
done
```

# Step 4
# Build the catalog; the "&>>" will capture all output and append it to the Log file.
# 
```
cstacks -g -p 36 -b 1 -n 1 -o $src/stacks $samp &>> $src/stacks/Log
``` 

## do a loop

```
for file in $files 
do 
	sstacks -g -p 36 -b 1 -c $src/stacks/batch_1 \
			 -s $src/stacks/${file} \ 
			 -o $src/stacks/ &>> $src/stacks/Log 
done
``` 



# Step 5
# Calculate population statistics and export several output files.
# 
```
populations -t 36 -b 1 -P $src/stacks/ -M $src/popmap \
			  -p 9 -f p_value -k -r 0.75 -s --structure --phylip --genepop
```
			  
			  
		
