#!/bin/bash
#get the modified files
git status | grep -E "*: *" | cut -d':' -f2 | /  
#push files	
while read i  ;do
	echo "file: " $i
	read -p "commit : " commit
	git commit -m "${commit}"
	git push
done
