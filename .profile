export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

LSCOLORS="exfxcxdxbxegedabagacad"

#alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
#export EDITOR='mate -w'
export EDITOR='vim'
