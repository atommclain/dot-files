if [[ $TERM == "LINUX" ]]; then
	setterm -foreground black -background white -store
	setfont ~/git/fonts/Terminus/PSF/ter-powerline-v16b.psf.gz
fi

alias el='vim ~/.bash_aliases && . ~/.bash_aliases'
alias light='setterm -foreground black -background white -store'
alias dark='setterm -foreground white -background black -store'

function dailyMan () {
	start_ts=$(date -d "2020-05-15" '+%s')
	end_ts=$(date -d `date +%F` '+%s')
	commandNum=$(( ( end_ts - start_ts )/(60*60*24) ))
	commandNum="${commandNum}p"
	ls /usr/bin | man `sed -n $commandNum`
}
