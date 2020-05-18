if [[ $TERM == "LINUX" ]]; then
	setterm -foreground black -background white -store
	setfont ~/git/fonts/Terminus/PSF/ter-powerline-v16b.psf.gz
fi

alias el='vim ~/.bash_aliases && . ~/.bash_aliases'
alias light='setterm -foreground black -background white -store'
alias dark='setterm -foreground white -background black -store'

# show man for the nth listing in /usr/bin based on the offset of start_ts
function dailyMan () {
	startDate="2020-05-15"
	start_ts=0
	end_ts=0
	if [ "$(uname)" == "Darwin" ]; then
		start_ts=$(date -j -f "%Y-%m-%d" ${startDate} +"%s")
		end_ts=$(date +"%s")
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		start_ts=$(date -d ${startDate} '+%s')
		end_ts=$(date -d `date +%F` '+%s')
	fi
	offset_ts=$(expr $end_ts - $start_ts)
	startOffset=$(( $offset_ts/(60*60*24) ))
	commandNum="${startOffset}p"
	ls /usr/bin | man `sed -n $commandNum`
}
