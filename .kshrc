# resource file for the korn shell

PS1='$(pwd | sed "s,^$HOME,~,")$ '

TERM=vt100
stty erase '^?' echoe
set -o emacs
export MAIL PS1 TERM

alias lsa='ls -lA'
alias l='ls'
alias cdd='cd $HOME/src/dot-files'
alias up='cd ..'

for term in $(env | grep -i less_term | cut -f1 -d"=")
do
  unset $term
done
