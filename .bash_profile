source ~/.profile
source ~/.bashrc 
source ~/.alias

# reload profile
# source ~/.bash_profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# git autocomplete
#if [ -f ~/.git-completion.bash ]; then
#	  . ~/.git-completion.bash
#fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
