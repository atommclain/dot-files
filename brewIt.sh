#!/bin/sh

command -v brew >/dev/null 2>&1 || {
    echo >&2 "brew command not available, running instalation script"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

brew analytics off
# update homebrew
brew update
# upgrade installed packages
brew upgrade
# install all entries in Brewfile
brew bundle

# after install settings

# fix quicklook
xattr -cr ~/Library/QuickLook/*
qlmanage -r
qlmanage -r cache
killall Finder
# turn on line numbers for qlcolorcode
defaults write org.n8gray.QLColorCode extraHLFlags '-l -W'
defaults write org.n8gray.QLColorCode lightTheme edit-xcode

# set file type associations
duti dutiSettings
