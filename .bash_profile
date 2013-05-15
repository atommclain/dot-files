# reload profile
# source ~/.bash_profileu

export EDITOR='mate -w'

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

#git alias
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit -m '
alias gcam='git commit -a -m '
alias gd='git diff'
alias go='git checkout '
alias gom='git checkout master '
alias gp='git pull '
alias gpu='git push'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gcp='git cherry-pick '
alias grb='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grb1='git reset --soft HEAD^'
alias grb2='git reset HEAD .'
alias grh='git reset --hard'
alias gmt='git mergetool '

# for repeating the last command
# see http://stackoverflow.com/questions/4956018/in-git-how-can-i-stage-a-file-i-have-just-diffed-without-manually-specifying-the/4956417#4956417
alias r='fc -s'

# git autocomplete
#if [ -f ~/.git-completion.bash ]; then
#	  . ~/.git-completion.bash
#fi

# reload bash profile
# . ~/.bash_profile
