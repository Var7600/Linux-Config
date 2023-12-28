#!/bin/bash

sudo apt install build-essential -y 
sudo apt install git -y  
sudo apt install most -y  
sudo apt install mysql-client mysql-server -y

# install Vsccodium 
sudo apt install dirmngr software-properties-common apt-transport-https curl -y
curl -fSsL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscodium.gpg >/dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main" | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium
# end vscodium

sudo apt install cppcheck -y #static C++ analyzer 
sudo apt install cppcheck-gui -y # GUI
sudo apt install check -y # unit test C
sudo apt install shellcheck -y    # lint bash
sudo apt install tmux -y
sudo apt install ddd -y # data display debugger for gdb
sudo apt install codeblocks -y    # C/C++ editors
sudo apt install ncdu -y
sudo apt install cloc -y #sofware metrics tool
#sudo apt-get install meld
sudo apt install fzf -y
sudo apt install w3m w3m-img # terminal browser
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-V/ugit/master/install)"  # ugit undo git
sudo apt install xcas giac-doc # xcas computer Algebra
sudo apt install libsdl2-dev libsdl2-doc libsdl2-gfx-dev libsdl2-gfx-doc libsdl2-image-dev  # SDL2
# Zeal Simple offline API documentation browser
sudo apt install zeal -y

# install GNU-octave
sudo apt-add-repository ppa:octave/stable # add octave repository
sudo apt install octave -y
# end octave
