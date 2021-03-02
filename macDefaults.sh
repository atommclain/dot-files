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

# Safari - Preferences
# Safari opens with: All windows from last session
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch 1
defaults write com.apple.Safari OpenPrivateWindowWhenNotRestoringSessionAtLaunch 0
defaults write com.apple.Safari ExcludePrivateWindowWhenRestoringSessionAtLaunch 0
# New tabs open with: Empty Page
defaults write com.apple.Safari NewTabBehavior 1
# Don’t Open “safe” files after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads 0
# Disable Use command-1 through command-9 to switch tabs
defaults write com.apple.Safari Command1Through9SwitchesTabs 0
# Search engine: DuckDuckGo
defaults write com.apple.Safari SearchProviderIdentifier "com.duckduckgo"
#Show full website address
defaults write com.apple.Safari ShowFullURLInSmartSearchField 1
defaults write com.apple.Safari UserStyleSheetEnabled 0
# Show Develop menu in menu bar
defaults write com.apple.Safari IncludeDevelopMenu 1
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey 1
defaults write com.apple.Safari "WebKitPreferences.developerExtrasEnabled" 1

# Safari - View
# Show status bar
defaults write com.apple.Safari ShowStatusBar -bool true
# Show favorites bar
defaults write com.apple.Safari ShowFavoritesBar -bool true
# Show tab bar
defaults write com.apple.Safari AlwaysShowTabBar -bool true
