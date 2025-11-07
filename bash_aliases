#!/usr/bin/bash

 # some more  aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -iv'
alias mv='mv -iv'
alias cls='clear'
alias nano='nano -l'
alias mv='mv -iv'
alias cp='cp -p -a -i'
alias v='vim'
alias mtmux='tmux new -s RONDIA \; split-window \; select-layout even-horizontal'
alias idle='/usr/bin/idle-python3.8'
alias zcc="gcc -g -ggdb3 -Wall -Werror -Wreturn-type -Wmain -Wformat-overflow -Wextra -pedantic -std=c11"
alias ccW="gcc -g -Wall "
#alias cc89='gcc -g -Wall -Werror -Wextra -pedantic -std=c89'
alias cc90='gcc -g -Wall -Werror -Wextra -pedantic -std=c90'
alias indentme='indent -blf -bli0 -ce -cdw -cli2 -cbi0 -nbc'
alias ccE='cc -E'
alias ccC='cc -c'
alias cpp11='g++ -g -ggdb3 -Wall -Wextra -pedantic -Werror -std=c++11'
alias cpp17='g++ -g -ggdb3 -Wall -pedantic -Werror -std=c++17'
alias cppcheck='cppcheck --enable=all'

alias zcp="g++ -g -gggdb3   -Wall -Werror -Wmain  -Wformat-overflow -Wreturn-type -Wextra -pedantic -Wfloat-equal -Wshadow -Woverloaded-virtual "
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
alias w3g="w3m google.com"
