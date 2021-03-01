# !/bin/sh

# System Preferences - General
# Show scroll bars: Always
defaults write -g AppleShowScrollBars -string "Always"

# Finder - Preferences - General
# Show these items on desktop:
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# New Finder windows show:
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Activity Monitor
# Icon shows CPU History
defaults write  com.Apple.ActivityMonitor IconType 6
# View -> All Processes
defaults write com.Apple.ActivityMonitor ShowCategory 100
