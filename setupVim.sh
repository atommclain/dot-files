#!/bin/sh

echo "Checking for required commands"
command -v git >/dev/null 2>&1 || { echo >&2 "git required but not available"; exit 1; }
command -v curl >/dev/null 2>&1 || { echo >&2 "curl required but not available"; exit 1; }

echo "Symlinking .rc files"
ln -sf $(pwd)/.vimrc ~
ln -sf $(pwd)/.gvimrc ~

GIT_CLONE_PULL="$(pwd)/gitCloneIdempotent.sh"

echo "Installing Pathogen"
mkdir -p $HOME/.vim/autoload
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Installing bundles"
mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
$GIT_CLONE_PULL git://github.com/altercation/vim-colors-solarized.git
$GIT_CLONE_PULL git://github.com/arcticicestudio/nord-vim.git
$GIT_CLONE_PULL git://github.com/vim-airline/vim-airline.git
$GIT_CLONE_PULL git://github.com/vim-airline/vim-airline-themes.git
$GIT_CLONE_PULL git://github.com/vim-scripts/a.vim.git
$GIT_CLONE_PULL git://github.com/can3p/incbool.vim.git
$GIT_CLONE_PULL https://github.com/tpope/vim-fugitive.git
$GIT_CLONE_PULL git://github.com/christoomey/vim-tmux-navigator.git
$GIT_CLONE_PULL https://github.com/t9md/vim-quickhl
vim -u NONE -c "helptags fugitive/doc" -c q

mkdir -p $HOME/.vim/undodir
mkdir -p $HOME/.tmp
mkdir -p $HOME/.bak

