# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

source ~/.alias

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

# mini prompt // [command #] [pwd]
#export PS1="\[\033[01;34m\] \! \w \$\[\033[00m\] "
# micro prompt
export PS1="\[\033[01;34m\]\! \$\[\033[00m\] "

function _update_ps1() {
    PS1=$(powerline-shell $?)
    #PS1="$(powerline-go -cwd-mode semifancy -hostname-only-if-ssh -modules "venv,host,ssh,cwd,perms,git,hg,jobs,exit,root" $?)"
}

if [[ $TERM != linux && $TERM_PROGRAM = "Apple_Terminal" && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Put your fun stuff here.
# Enables ^s and ^q in rTorrent, when running in screen
stty -ixon -ixoff
# verify command before execcuting
shopt -s histverify
# append to history, don't overwrite it
shopt -s histappend
HISTSIZE= HISTFILESIZE= # Infinite
HISTCONTROL=ignoredups

# Find Duplicate Files (based on size first, then MD5 hash)
# find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export BASH_SILENCE_DEPRECATION_WARNING=1 # https://support.apple.com/kb/HT208050
