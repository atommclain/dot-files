EDITOR=/usr/pkg/bin/vim
PS1="$ " 

TERM=vt100
stty erase '^?' echoe
set -o emacs
export MAIL PS1 TERM EDITOR VISUAL 

alias lsa='ls -la'
alias l='ls'
alias cdd='cd $HOME/src/dot-files'
alias up='cd ..'
