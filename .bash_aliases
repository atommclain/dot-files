# temporary holding area for linux/unbuntu specific commands

if [[ $TERM == "linux" ]]; then
: #	setfont ~/git/fonts/Terminus/PSF/ter-powerline-v16b.psf.gz
fi

alias el='$EDITOR ~/.bash_aliases && . ~/.bash_aliases'
alias light='setterm -foreground black -background white -store'
alias dark='setterm -foreground white -background black -store'
alias sysver='lsb_release -a'
alias githubssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/github_rsa'

