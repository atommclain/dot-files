#!/bin/sh
# a script to update packages and system software

if [ "$(uname)" = "Darwin" ]; then
    if hash brew 2>/dev/null; then
        brew analytics off
        brew update
        brew upgrade
        brew bundle
        # Streaks throws a warning when upgrading it when it's running, close and
        # reopen it to make this script run with less direct intervention
         if ps aux | grep -v grep | grep -q "Streaks"; then
             OPEN_STREAKS=1
             killall "Streaks"
         fi
        mas upgrade
        if [ -n "$OPEN_STREAKS" ]; then
            open /Applications/Streaks.app
        fi

        ./macDefaults.sh
    else
        echo "Homebrew not installed"
    fi
    sudo softwareupdate --install --all --agree-to-license
elif [ "$(uname)" = "Linux" ]; then
    # Alpine Package Keeper
    if hash apk 2>/dev/null; then
      apk update
      apk upgrade
    elif hash apt 2>/dev/null; then
      sudo apt update && sudo apt upgrade -y
      sudo apt autoremove -y
    else
      echo "unknown package manager for Linux"
    fi
else
    echo "unknown system: $(uname)"
fi

