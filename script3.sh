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

