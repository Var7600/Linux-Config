#!/bin/bash

#install default utilities
./tools.sh

#save current bashrc config to install new bashrc config
mv ~/.bashrc ~/.bashrc.old && cp ./bashrc ~/.bashrc && cp bash_aliases ~/.bash_aliases

#copie folder Script to HOME
cp -R ./Script/ ~/

#install git prompt bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

#restart shell
source ~/.bashrc

