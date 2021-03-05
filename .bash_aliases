# temporary holding area for linux/unbuntu specific commands

if [[ $TERM == "linux" ]]; then
: #	setfont ~/git/fonts/Terminus/PSF/ter-powerline-v16b.psf.gz
fi

alias wcard='lspci -vnn | grep 14e4'
unalias myip
alias myip='ifconfig wlan0 | grep inet | awk "{ print $2 }" | head -n 1'
alias el='$EDITOR ~/.bash_aliases && . ~/.bash_aliases'
alias light='setterm -foreground black -background white -store'
alias dark='setterm -foreground white -background black -store'
alias sysver='lsb_release -a'
alias githubssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/github_rsa'
alias coolfont='setfont ~/git/fonts/Terminus/PSF/ter-powerline-v16b.psf.gz'
# linux ubuntu print out all chars from console font // showconsolefont
alias getchars='setfont -ou chars.txt'
alias expandchars='while read -r x u; do printf "%s\t%b\n" "$x	$u" "${u/U+/\\U}"; done '
