#!/bin/sh

if [ -f "$HOME/.ssh/id_rsa" ]; then
    printf "[SSH] Pulblic key already exists\n"
else
    read -p "[SSH] Create new SSH key (yes/no): " response
    if test "$response" = "yes"; then
        printf "\n"
        read -p "Enter your e-mail: " ssh_email
        printf "\n"
        printf "[SSH] Creating ssh key\n"
        ssh-keygen -t rsa -b 4096 -C $ssh_email
        printf "\n"
    fi
fi


printf "[SSH] Copying ssh key to pasteboard\n"
if [ "$(uname)" == "Darwin" ]; then
    cat ~/.ssh/id_rsa.pub | pbcopy
elif [ "$(uname)" == "Linux" ]; then
    if [ -e "/dev/clipboard" ] ; then
        cat ~/.ssh/id_rsa.pub > /dev/clipboard
    else
        echo "[SSH] /dev/clipboard does not exist"
    fi
    printf "\n"
else
    echo "[SSH] Unknown system: $(uname)"
fi

printf "[SSH] Setting up ssh key\n"
if [ "$(uname)" == "Darwin" ]; then
    # Setup SSH to use keychain to prevent git from always asking for passphrase
    # https://superuser.com/questions/1127067/macos-keeps-asking-my-ssh-passphrase-since-i-updated-to-sierra
    printf "[SSH] Configuring .ssh/configure\n"
    touch ~/.ssh/configure
    echo "Host *" >> ~/.ssh/configure
    echo "    UseKeychain yes" >> ~/.ssh/configure
elif [ "$(uname)" == "Linux" ]; then
    printf "[SSH] Adding ssh key to ssh-agent\n"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    printf "\n"
else
    echo "[SSH] Unknown system: $(uname)"
fi

printf "[SSH] Done\n"
printf "\n"
