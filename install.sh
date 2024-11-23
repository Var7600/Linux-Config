#!/bin/bash

# install default utilities
./tools.sh

# ctags config file
if [ -e ~/.ctags ];then
	mv ~/.ctags ~/.ctags.old && mv ./ctags ~/.ctags
fi

# save current bashrc config to install new bashrc config
mv ~/.bashrc ~/.bashrc.old && cp ./bashrc ~/.bashrc 


# aliases
if [ -e ~/.bash_aliases ];then
	mv ~/bash_aliases ~/.bash_aliases.old && cp ./bash_aliases ~/.bash_aliases
else
	cp ./bash_aliases ~/.bash_aliases
fi

# install SCripts folder to  $HOME/Scripts
if  [ ! -d "$HOME/Scripts/" ];then
		mkdir "$HOME/Scripts/"
fi

read -r -p "copy actual to $HOME/Scripts/ folder?:" response
if [ "$response" == "y" ] || [ "$response" == "Y" ]; then
		cp -R ./Scripts/ "$HOME/Scripts/"
		# add Scripts to path
		export PATH=$HOME/Scripts/:$PATH
fi


# git config file
if [ -e ~/.gitconfig ];then
	mv ~/.gitconfig ~/.gitconfig.save
	mv ./.gitconfig ~/.gitconfig
else
	mv ./.gitconfig ~/.gitconfig
fi

# gitignore
mv ./.gitignore-global ~/.gitignore-global

# install git prompt bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# install tmux config
if [ -e ~/.tmux.conf ];then
	mv ~/.tmux.conf ~/tmux.conf.old && cp ./tmux.conf ~/.tmux.conf
else
	cp ./tmux.conf ~/.tmux.conf
fi

# install miniconda
if [ -e ./miniconda.sh ];then
	./miniconda.sh
fi

#################################################
# install dep packages in ../deb-packages/ folder
#################################################

# get all the the deb packages in folder
packages=$(cd ./dep-packages && ls)

for pkg in $packages;do
	echo "installing $pkg ..."
	sudo dpkg -i "$pkg"
done


# installing docker
read -r  -p  "do you want to install docker (yes[y/Y]/no[n/N]):" answer
# echo "your answer is ${answer}"

if [[ $answer == "yes" || $answer == "y" || $answer == "Y" ]];then
	./install-docker.sh
fi

# restart shell
source ~/.bashrc

