#!/bin/sh
# a script to update packages and system software

if [ "$(uname)" = "Darwin" ]; then
    if hash brew 2>/dev/null; then
        brew analytics off
        brew update
        brew upgrade
        mas upgrade
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

