#!/bin/bash

#version to install
version=Miniconda3-py310_23.1.0-1-Linux-x86_64.sh


#download script to install it
wget https://repo.anaconda.com/miniconda/${version}

#make executable
chmod -v +x Miniconda*.sh

match_hash=32d73e1bc33fda089d7cd9ef4c1be542616bd8e437d1f77afeeaf7afdb019787

#verify hash
echo "${match_hash} *${version}" | shasum --check  

shasum_return_code=$?

if [ $shasum_return_code -eq 0 ];then
	./${version}
else
	echo "script download not matching SHA256 hash removing script"
	rm ./${version}
fi
