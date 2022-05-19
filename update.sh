#!/bin/sh
# a script to update packages and system software

if [[ "$(uname)" == "Darwin" ]]; then
    if hash brew 2>/dev/null; then
        brew update
        brew upgrade
    fi
    sudo softwareupdate -ia
elif [ "$(uname)" == "Linux" ]; then
    # Alpine Package Keeper
    if hash apk 2>/dev/null; then
      apk update
      apk upgrade
    else
      echo "update Linux"
    fi
else
    echo "unknown system: $(uname)"
fi

