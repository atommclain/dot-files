# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# load local profile if present
if [ -f "$HOME/.profile.local" ] ; then
    . "$HOME/.profile.local"
fi

# homebrew for m1 mac
if [ -f "/opt/homebrew/bin/brew" ] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/usr/bin" ] ; then
    export PATH="$HOME/usr/bin:$PATH"
fi

if [ -z "$SRCDIR" ]; then
    export SRCDIR="$HOME/src"
fi

export CDPATH=".:$HOME:$SRCDIR"

# lscolors https://gist.github.com/thomd/7667642
LSCOLORS="exfxcxdxbxegedabagacad"

export EDITOR='vim'
export VISUAL='vim'
export SUDO_EDITOR='vim'
export FCEDIT='vim -u .minivimrc'

export MANPAGER='less -s -M +Gg'
export LESS='-F'
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# ruby
if [ -d "/usr/local/opt/ruby/bin" ] ; then
    export PATH="/usr/local/opt/ruby/bin:$PATH"
fi

if [ -d "/opt/homebrew/opt/ruby/bin" ] ; then
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    # fix for Cocoapods on m1 mac
    export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
fi

# gem
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$HOME/.gem"
if [ -d "$GEM_HOME" ] ; then
    export PATH="$GEM_HOME/bin:$PATH"
fi

# bundle
export BUNDLE_PATH="$HOME/.bundle"

# python
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

# Cargo rust
if [ -d "$HOME/.cargo" ] ; then
    . "$HOME/.cargo/env"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ -d "/proc/ish/" ] ; then
    export ENV=$HOME/.ashinit
fi

if [ $(basename $SHELL) = "ksh" ] ; then
    export ENV=$HOME/.kshrc
fi

if [ -t 0 ]; then
    if hash fortune 2>/dev/null; then
        if [ -d "$SRCDIR/fortune" ] ; then
            $SRCDIR/fortune/fortune.sh
        fi
    fi
fi

