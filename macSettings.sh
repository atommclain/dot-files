#!/bin/sh
# Configure OS X/macOS settings

# Check if a flag was passed to skip killall commands
SKIP_KILL=false
if [ "$1" = "--no-kill" ]; then
    SKIP_KILL=true
fi

# Set defaults
./macDefaults.sh --no-kill

# Configure Finder sidebar and Dock
./macConfigFinderDock.sh --no-kill

# Set filetype associations
if hash duti 2>/dev/null; then
    duti dutiSettings
else
    echo "duti is not installed"
fi

# Don't kill if flag is set
if [ "$SKIP_KILL" = false ]; then
    killall cfprefsd
    killall Dock
    killall Finder
    killall SystemUIServer
fi
