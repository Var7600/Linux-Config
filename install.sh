!#/bin/bash
#save current bashrc config to install new bashrc config
mv ~/.bashrc ~/.bashrc.old && cp ./bashrc ~/.bashrc && cp bash_aliases ~/.bash_aliases

#restart shell
source ~/.bashrc

