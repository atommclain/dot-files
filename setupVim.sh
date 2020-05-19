#!/bin/sh

echo "Checking for required commands"
command -v git >/dev/null 2>&1 || { echo >&2 "git required but not available" exit 1; }
command -v curl >/dev/null 2>&1 || { echo >&2 "curl required but not available" exit 1; }

echo "Installing Pathogen"
mkdir -p $HOME/.vim/autoload
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Installing bundles"
mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git
git clone git://github.com/vim-airline/vim-airline.git
git clone git://github.com/vim-airline/vim-airline-themes.git