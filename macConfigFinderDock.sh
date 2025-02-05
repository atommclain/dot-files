#!/bin/sh
# configure finder sidebar and dock

SKIP_KILL=false
if [ "$1" = "--no-kill" ]; then
    SKIP_KILL=true
fi

# Configure the finder sidebar
if hash mysides 2>/dev/null; then
    mysides remove all
    mysides add Downloads file:///Users/$(whoami)/Downloads/
    mysides add $(whoami) file:///Users/$(whoami)/
    mysides add git file:///Users/$(whoami)/git/
    mysides add Applications file:///Applications/
else
    echo "mysides is not installed"
fi

# This currently uses a localy built version via https://github.com/Kyle-Ye/dockutil/tree/spm
# Need to fix this once the brew version works. See https://github.com/kcrawford/dockutil/pull/131
if hash dockutil 2>/dev/null; then
    dockutil --remove com.apple.launchpad.launcher --no-restart
    dockutil --remove com.apple.MobileSMS --no-restart
    dockutil --remove com.apple.mail --no-restart
    dockutil --remove com.apple.Maps --no-restart
    dockutil --remove com.apple.Photos --no-restart
    dockutil --remove com.apple.FaceTime --no-restart
    dockutil --remove com.apple.iCal --no-restart
    dockutil --remove com.apple.AddressBook --no-restart
    dockutil --remove com.apple.reminders --no-restart
    dockutil --remove com.apple.Notes --no-restart
    dockutil --remove com.apple.TV --no-restart
    dockutil --remove com.apple.Music --no-restart
    dockutil --remove com.apple.podcasts --no-restart
    dockutil --remove com.apple.news --no-restart
    dockutil --remove com.apple.AppStore --no-restart
    dockutil --remove com.apple.systempreferences --no-restart

    # Skip kill if flag is set
    if [ "$SKIP_KILL" = false ]; then
        killall Dock
    fi
else
    echo "dockutil is not installed"
fi
