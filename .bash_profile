# reload profile
# source ~/.bash_profileu

#export EDITOR='mate -w'
export EDITOR='vim'

source ~/.bashrc 

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
##
# Your previous /Users/atom/.bash_profile file was backed up as /Users/atom/.bash_profile.macports-saved_2011-04-08_at_02:10:39
##

# MacPorts Installer addition on 2011-04-08_at_02:10:39: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=~/bin:$PATH

alias svn=colorsvn
source ~/.alias

# git autocomplete
#if [ -f ~/.git-completion.bash ]; then
#	  . ~/.git-completion.bash
#fi

# reload bash profile
# . ~/.bash_profile
