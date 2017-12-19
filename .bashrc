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

export PS1="\[\033[01;34m\] \w \$\[\033[00m\] "

# Put your fun stuff here.
# Enables ^s and ^q in rTorrent, when running in screen
stty -ixon -ixoff

export TZ="/usr/share/zoneinfo/PST8PDT"

# Find Duplicate Files (based on size first, then MD5 hash)
# find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='Exgxfxfxcxdxdxhbadbxbx'

function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
#export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '
