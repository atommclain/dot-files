# !/bin/sh

# System Preferences - General
# Show scroll bars: Always
defaults write -g AppleShowScrollBars -string "Always"

# System Preferences - Desktop & Screen Saver - Screen Saver
# Start after: 5 Minutes
defaults -currentHost write com.apple.screensaver idleTime -int 300

# System Preferences - Desktop & Screen Saver - Screen Saver - Hot Corners
# Top right screen corner → Start Screen Saver
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom right screen corner → Disable Screen Saver
defaults write com.apple.dock wvous-bl-corner -int 6
defaults write com.apple.dock wvous-bl-modifier -int 0

# System Preferences - Siri
# Enable Ask Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Show Siri in menu bar
defaults write com.apple.Siri StatusMenuVisible -bool false

# System Preferences - Accessibility
# Zoom - Enable Use scroll gesture with modifier keys to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
# Display - Reduce transparency
#defaults write com.apple.universalaccess reduceTransparency -bool true

# Finder - Preferences - General
# Show these items on desktop:
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# New Finder windows show:
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Finder - Preferences - Advanced
# Show all filename extensions
defaults write -g AppleShowAllExtensions -bool true
# Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Keep folders on top: In windows when sorting by name
com.apple.finder _FXSortFoldersFirst -bool true
# When performing a serach: Search the Current Folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder - View
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Default Finder view is List
defaults write com.apple.Finder FXPreferredViewStyle -string Nlsv

# Activity Monitor
# Icon shows CPU History
defaults write com.Apple.ActivityMonitor IconType 6
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

# Xcode
# Show build times in xcode
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true
# Show Xcode build number on icon
defaults write com.apple.dt.Xcode ShowDVTDebugMenu -bool true
# Add counterparts to Xcode https://twitter.com/peterfriese/status/1364544309878534144
defaults write http://com.apple.dt.Xcode IDEAdditionalCounterpartSuffixes -array-add "ViewModel" "View" "Screen"

killall cfprefsd
