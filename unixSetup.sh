#!/bin/sh

git branch --set-upstream-to origin/master
source .alias
clink .profile
clink .alias
clink .gitconfig
clink .minivimrc
if [ ! -f ~/.vimrc ]; then
    ln -sf $(pwd)/.minivimrc ~/.vimrc
fi
