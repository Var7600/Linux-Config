#!/bin/bash

#install default utilities
./tools.sh

#save current bashrc config to install new bashrc config
mv ~/.bashrc ~/.bashrc.old && cp ./bashrc ~/.bashrc 

#aliases
if [ -e ~/.bash_aliases ];then
	mv ~/bash_aliases ~/.bash_aliases.old && cp ./bash_aliases ~/.bash_aliases
else
	cp ./bash_aliases ~/.bash_aliases
fi

#copie folder Script to HOME
cp -R ./Script/ ~/

#install git prompt bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

#install tmux config
if [ -e ~/.tmux.conf ];then
	mv ~/.tmux.conf ~/tmux.conf.old && cp ./tmux.conf ~/.tmux.conf
else
	cp ./tmux.conf ~/.tmux.conf
fi

#install miniconda
if [ -e ./miniconda.sh ];then
	./miniconda.sh
fi

#restart shell
source ~/.bashrc

