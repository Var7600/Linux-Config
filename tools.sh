#!/bin/bash

sudo apt install build-essential 
sudo apt install openjdk-21-jre
sudo apt install openjdk-21-jdk

#-----------------------------------
# cli tools
#----------------------------------
cli="./cli-tools.txt"
read -r -p "install cli tools?(y/n): " tool
if [ "$tool" == "y" ] || [ "$tool" == "Y" ];then
	# read file install apps
	while IFS= read -r line
	do
		echo "installing $line ..."
		sudo apt install "$line" -y
	done < "$cli"
fi



#-------------------------------------
# GUI tools
#--------------------------------------
path="./gui-apps.txt"
read -r -p "install gui apps?(y/n): " gui
if [ "$gui" == "y" ] || [ "$gui" == "Y" ];then
	# read file install apps
	while IFS= read -r line
	do
		echo "installing $line ..."
		sudo apt install "$line" -y
	done < "$input"
fi





# ugit undo git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-V/ugit/master/install)"  

#--------------------
# SDL2
#---------------------
sudo apt install libsdl2-dev libsdl2-doc libsdl2-gfx-dev libsdl2-gfx-doc libsdl2-image-dev 

read -r -p "install VsCodium:(y/n)?: " vs
if [ "$vs" == "Y" ] || [ "$vs" == "y" ];then

	# install Vsccodium 
	sudo apt install dirmngr software-properties-common apt-transport-https curl -y
	curl -fSsL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscodium.gpg >/dev/null
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main" | sudo tee /etc/apt/sources.list.d/vscodium.list
	sudo apt update
	sudo apt install codium
	# end vscodium
fi

# install GNU-octave
read -r -p "install Octave?(y/n): " oct
if [ "$oct" == "Y" ] || [ "$oct" == "y" ];then
	sudo apt-add-repository ppa:octave/stable # add octave repository
	sudo apt install octave -y
	# end octave
fi

echo "installing  pip,jupyter Notebook,python data analyst libraries for python3"
# install pip,jupyter Notebook,python data analyst libraries for python3
sudo apt install python3-pip -y
pip3 install ipython
pip3 install Jupyter
pip3 install numpy pandas matplotlib
# end python3

# R-lang
sudo apt install r-base-core -y

# ghdl
echo "install ghdl"
sudo apt install ghdl ghdl-common ghdl-tools -y
# end ghdl
