#!/bin/sh

# Check if a flag was passed to skip killall commands
SKIP_KILL=false
if [ "$1" = "--no-kill" ]; then
    SKIP_KILL=true
fi

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

# System Preferncees - Mission Control
# Displays have separate Spaces (menu bar only appears on main display)
defaults write com.apple.spaces spans-displays -bool true
# Hot Corners...
# top left, Start Screen Saver
defaults write com.apple.dock wvous-tl-corner -int 6
# top left, Disable Screen Saver
defaults write com.apple.dock wvous-tr-corner -int 5
# bottom left, Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
# bottom right, Disable Screen Saver
defaults write com.apple.dock wvous-br-corner -int 6

# System Preferences - Desktop & Dock
# Click wallpaper to reveal desktop → Only in Stage Manager
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# System Preferences - Siri
# Enable Ask Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Don't show Siri in menu bar
defaults write com.apple.Siri StatusMenuVisible -bool false

# System Preferences - Accessibility
# Show window title icons
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool YES
# Reduce Transparency
defaults write com.apple.universalaccess reduceTransparency 1
# Differentiate without color
defaults write com.apple.universalaccess differentiateWithoutColor 1

# System Preferences - Keyboard
# Key Repeat/Delay
defaults write -g InitialKeyRepeat -int 25
defaults write -g KeyRepeat -int 1

# System Preferences - Time & Date
# Time format 24-Hour Time
defaults write -g AppleICUForce24HourTime -int 1
# Change clock to analog
defaults write com.apple.menuextra.clock IsAnalog -bool true

# System Preferences - Control Center
# Clock Options, Time, Style, Analog
defaults write com.apple.menuextra.clock IsAnalog -bool true

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
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# When performing a serach: Search the Current Folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder - View
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Default Finder view is List
defaults write com.apple.Finder FXPreferredViewStyle -string Nlsv
# Show ~/Library folder
chflags nohidden ~/Library
if xattr -l ~/Library | grep -q com.apple.FinderInfo; then
    xattr -d com.apple.FinderInfo ~/Library
fi

# Finder - Other
# Move window with cmd + ctrl with click and drag
# Requires user to log out to take effect
defaults write -g NSWindowShouldDragOnGesture -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show full path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Show all files in finder
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show battery percentage defaults write
defaults write com.apple.menuextra.battery ShowPercent -bool true
# Big Sur 10.X toolbar
defaults write -g NSWindowSupportsAutomaticInlineTitle -bool false

# Finder - Menubar Notch Icon Spacing
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 12
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 8
# After running these commands, you need to log out and log back in
# Revert to the original values
# defaults -currentHost delete -globalDomain NSStatusItemSelectionPadding
# defaults -currentHost delete -globalDomain NSStatusItemSpacing

# Enable slow motion minimization
defaults write com.apple.dock slow-motion-allowed -bool YES


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
# New windows open with: Start Page
defaults write com.apple.Safari NewWindowBehavior 4
# New tabs open with: Empty Page
defaults write com.apple.Safari NewTabBehavior 1
# Don’t Open “safe” files after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads 0
# Disable Use command-1 through command-9 to switch tabs
defaults write com.apple.Safari Command1Through9SwitchesTabs 0
# Search engine: DuckDuckGo
defaults write com.apple.Safari SearchProviderIdentifier "com.duckduckgo"
# Preload Top Hit in the background
defaults write com.apple.Safari PreloadTopHit 0
# Allow websites to ask for permission to send notifications
defaults write com.apple.Safari CanPromptForPushNotifications 0
#Show color in compact tab bar
defaults write com.apple.Safari NeverUseBackgroundColorInToolbar 1
#Show full website address
defaults write com.apple.Safari ShowFullURLInSmartSearchField 1
defaults write com.apple.Safari UserStyleSheetEnabled 0
# Show Develop menu in menu bar
defaults write com.apple.Safari IncludeDevelopMenu 1
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey 1
defaults write com.apple.Safari "WebKitPreferences.developerExtrasEnabled" 1
# Enable internal developer menu
defaults write com.apple.Safari IncludeInternalDebugMenu 1
# Show favorites bar
defaults write com.apple.Safari "ShowFavoritesBar-v2" 1

# Safari - View
# Show status bar
defaults write com.apple.Safari ShowStatusBar -bool true
# Show favorites bar
defaults write com.apple.Safari ShowFavoritesBar -bool true
# Show tab bar
defaults write com.apple.Safari AlwaysShowTabBar -bool true

# AppSore - Don't show rating prompts
defaults write com.apple.appstore InAppReviewEnabled -bool false

# FileMerge
# Convert plists from binary to text
defaults write com.apple.FileMerge Filters -array-add '{ Apply = 0; Display = 0; Extension = plist; Filter = "/usr/bin/plutil -convert xml1 -o -  \$(FILE)"; }'

# Xcode
# Show build times in xcode
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true
# Show Xcode build number on icon
defaults write com.apple.dt.Xcode ShowDVTDebugMenu -bool true
# Add counterparts to Xcode https://twitter.com/peterfriese/status/1364544309878534144
defaults write http://com.apple.dt.Xcode IDEAdditionalCounterpartSuffixes -array-add "ViewModel" "View" "Screen" "Tests" "Coordinator"

# Show Indexing numeric progress
defaults write com.apple.dt.Xcode IDEIndexerActivityShowNumericProgress -bool YES
# Show invisibles
defaults write com.apple.dt.Xcode DVTTextShowInvisibleCharacters -bool true
# Set page guide column to 120
defaults write com.apple.dt.Xcode DVTTextPageGuideLocation -integer 120
# Editor Overscroll small
defaults write com.apple.dt.Xcode DVTTextOverscrollAmount -float 0.25
# Trim trailing whitespace on whitespace-only lines
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -bool true
# Make tabs work normally
defaults write com.apple.dt.Xcode IDEEditorCoordinatorTarget_DoubleClick "SameAsClick"
defaults write com.apple.dt.Xcode IDEEditorNavigationStyle_DefaultsKey "IDEEditorNavigationStyle_OpenInPlace"
# Check for spelling automatically
defaults write com.apple.dt.Xcode AutomaticallyCheckSpellingWhileTyping -bool true
# "...a new mode that better utilizes available cores, resulting in faster builds for Swift projects"
defaults write com.apple.dt.XCBuild EnableSwiftBuildSystemIntegration 1
# Don't show ad for Xcode Cloud
defaults write com.apple.dt.Xcode XcodeCloudUpsellPromptEnabled -bool false
# Disable "Print" keyboard shortcut
defaults write com.apple.dt.Xcode NSUserKeyEquivalents -dict-add "Print..." "nil"

# ItsyCal
defaults write com.mowglii.ItsycalApp ClockFormat -string "E MMM d H:mm"
defaults write com.mowglii.ItsycalApp HideIcon -bool true

# Pastebot
# Auto hide Dock Icon
defaults write com.tapbots.Pastebot2Mac UIVisibilityState -integer 2

# Don't kill if flag is set
if [ "$SKIP_KILL" = false ]; then
    killall cfprefsd
    killall Dock
    killall Finder
    killall SystemUIServer
fi
