# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -d "/opt/local/bin" ] ; then
	export PATH="/opt/local/bin:$PATH"
fi

if [ -d "/opt/local/sbin" ] ; then
	export PATH="/opt/local/sbin:$PATH"
fi

if [ -d "/usr/local/bin" ] ; then
	export PATH="/usr/local/bin:$PATH"
fi

if [ -d "/usr/local/sbin" ] ; then
	export PATH="/usr/local/sbin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
	export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/usr/bin" ] ; then
    PATH="$HOME/usr/bin:$PATH"
fi

export CDPATH=".:$HOME:$HOME/git"

# lscolors https://gist.github.com/thomd/7667642
LSCOLORS="exfxcxdxbxegedabagacad"

export EDITOR='vim'
export VISUAL='vim'
export FCEDIT='vim'

if [ -d "$HOME/.rvm" ] ; then
    export BUNDLE_PATH="$HOME/.rvm"
fi

if hash python 2>/dev/null; then
    PYTHON_PATH="$(python -c 'import site; print(site.USER_BASE)')/bin"
    if [ -d "$PYTHON_PATH" ] ; then
        PATH="$PYTHON_PATH:$PATH"
    fi
fi

if hash python3 2>/dev/null; then
    PYTHON3_PATH="$(python3 -c 'import site; print(site.USER_BASE)')/bin"
    if [ -d "$PYTHON3_PATH" ] ; then
        PATH="$PYTHON3_PATH:$PATH"
    fi
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ "$SHELL" = "/bin/ash" ]; then
    export ENV=$HOME/.ashinit
fi

