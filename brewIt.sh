# /bin/sh

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

duti dutiSettings
