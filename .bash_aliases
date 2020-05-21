if [[ $TERM == "linux" ]]; then
	setfont ~/git/fonts/Terminus/PSF/ter-powerline-v16b.psf.gz
fi

alias el='$EDITOR ~/.bash_aliases && . ~/.bash_aliases'
alias light='setterm -foreground black -background white -store'
alias dark='setterm -foreground white -background black -store'
alias sysver='lsb_release -a'
alias githubssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/github_rsa'
alias et='vim ~/git/dot-files/todo.txt'

# show man for the nth listing in /usr/bin based on the offset of startDate
function dailyMan() {
	startDate="2020-05-15"
	offset=$(dateDiff $startDate)
	commandNum="${offset}p"
	commandName=$( ls /usr/bin | sed -n $commandNum)
	man $commandName
	echo $commandName
}

# return the nth builtin base of the offset of startDate
function dailyBuiltin() {
	startDate="2020-05-20"
	offset=$(dateDiff $startDate)
	commandNum="${offset}p"
	todaysCommand=$(compgen -b | sed -n $commandNum)
	echo "info|man|help $todaysCommand"
}

# takes a date string in the format "yyyy-mm-dd" and returns the number
# of days to now
function dateDiff() {
	if [ $# -eq 0 ]
	then
		echo "No arguments supplied"
		return
	fi

	startDate="$1"
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
	offset=$(( $offset_ts/(60*60*24) ))
	echo $offset
}

alias vimp='rm profile.log && vim ~/.vimrc --startuptime profile.log'
alias profvim="rm profile.log & vim  --cmd 'profile start profile.log'     --cmd 'profile func *'     --cmd 'profile file *'     -c 'profdel func *'     -c 'profdel file *' ~/git/dot-files/todo.txt"
 #test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
