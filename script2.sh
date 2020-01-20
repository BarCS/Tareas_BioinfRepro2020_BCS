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

