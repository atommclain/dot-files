# a script to setup a shell environment

git branch --set-upstream-to origin/master
source .alias

# all shells
clink .profile
clink .alias

# git
clink .gitconfig
clink .git_template
clink .gitattributes
clink .gitignore_global

# editor
clink .minivimrc
if [ ! -f ~/.vimrc ]; then
    ln -sf $(pwd)/.minivimrc ~/.vimrc
fi

# bash
if [ -n "$BASH_VERSION" ]; then
    echo "setting up bash"
    clink .bashrc
    clink .inputrc
fi

# zsh
if [ -n "$ZSH_VERSION" ]; then
    echo "setting up zsh"
    clink .zshrc
    clink .zshenv
    clink .p10k.zsh
fi

# almquist and iSH
if [ "$SHELL" = "/bin/ash" ]; then
    echo "setting up almquist"
    clink .ashinit

    # fix concurrency issue
    git config --global pack.threads "1"

    # remove login message
    if [ -f "/etc/motd" ]; then
        rm /etc/motd
    fi
fi
