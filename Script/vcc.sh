#!/bin/bash

########################################################
# bash script to compile analyze and run  vhdl file(s)
# in current working dir from the command line using ghdl
# ######################################################


# Check if GHDL is installed
if ! command -v ghdl &> /dev/null
then
	echo "GHDL is not installed. Please install GHDL to continue run(sudo apt
	install ghdl)."
    exit 1
fi


# find all vhdl files in the current working dir
# shellcheck disable=SC2010
vhdl_files=$(ls | grep "\.vhdl$" || ls | grep "\.vhd$") 

# analyze every file with ghdl
for file in $vhdl_files
do
	if  ! command  ghdl -a "$file" 
	then
		exit 1
	fi
done


# top unit file
top_unit=""


# trying to find the top entity unit to elaborate
for file in $vhdl_files
do
  file_lower=$(echo "$file" | tr '[:upper:]' '[:lower:]')
  if [ "$file_lower" == "testbench.vhdl" ] || [ "$file_lower" ==\
		"testbench.vhd"\
		] || [ "$file_lower" == "main.vhdl" ] || [ "$file_lower" == "main.vhd" ] || 
			[ "$file_lower" == "test.vhdl" ] || [ "$file_lower" == "test.vhd" ]
  then
		# file top unit to elaborate
    top_unit=${file%.*} 
		break
	fi
done

# if top unit not found
if [ -z "$top_unit" ]
then
		read -r  -p 'no driver filename found like ("testbench.vhdl" or "main.vhdl"
	"test.vhdl") please enter the entity top level file(driver file):' driver
		
	# extract extension if given
	driver=${driver%.*}
	top_unit="$driver"
fi

	# elaborate top unit file given
	ghdl -e "$top_unit"

	if [ $? == 1 ]
	then
		echo "top entity filename given " "$driver" " not found!"
		exit 1
	fi

read -r -p 'auto testbench or simulation waveforms?answer with (auto or simu): ' answer

if [ "$answer" == "auto" ]
then
	ghdl -r "$top_unit"
elif [ "$answer" == "simu" ]
then
	ghdl -r "$top_unit" --wave=wave.ghw
else
	echo "not valid answer! answer by (auto) or (simu) only."
	exit 1
fi

echo "vcc.sh finished succefully!"
exit 0



