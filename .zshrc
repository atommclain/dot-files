# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

bindkey -v
bindkey ^R history-incremental-search-backward

alias ez='vim ~/.zshrc; source ~/.zshrc'

__git_files () {
	_wanted files expl 'local files' _files  }

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
	globalias
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=236'

source $ZSH/oh-my-zsh.sh

# User configuration

#export GOPATH=/usr/local
if [ -f "$GOPATH/bin/powerline-go" ] ; then
	function powerline_precmd() {
		PS1="$($GOPATH/bin/powerline-go -error $? -jobs ${${(%):%j}:-0} \
		-cwd-mode semifancy -hostname-only-if-ssh -modules "venv,host,ssh,cwd,perms,git,hg,jobs,exit,root")"

		# Uncomment the following line to automatically clear errors after s
		# them once. This not only clears the error for powerline-go, but al
		# everything else you run in that shell. Don't enable this if you're
		# sure this is what you want.

		#set "?"
	}

	function install_powerline_precmd() {
		for s in "${precmd_functions[@]}"; do
			if [ "$s" = "powerline_precmd" ]; then
				return
			fi
		done
	precmd_functions+=(powerline_precmd)
	}

	if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
		install_powerline_precmd
	fi
fi

source ~/.alias

# Edit line in vim with ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

alias -g _gf1="`git --no-pager diff --name-only | sed -n 1p | sed 's/ /\\\\ /g'`"
alias -g _gf2="`git --no-pager diff --name-only | sed -n 2p | sed 's/ /\\\\ /g'`"
alias -g _gf3="`git --no-pager diff --name-only | sed -n 3p | sed 's/ /\\\\ /g'`"
alias -g _gf4="`git --no-pager diff --name-only | sed -n 4p | sed 's/ /\\\\ /g'`"
alias -g _gf5="`git --no-pager diff --name-only | sed -n 5p | sed 's/ /\\\\ /g'`"
alias -g _gf6="`git --no-pager diff --name-only | sed -n 6p | sed 's/ /\\\\ /g'`"
alias -g _gf7="`git --no-pager diff --name-only | sed -n 7p | sed 's/ /\\\\ /g'`"
alias -g _gf8="`git --no-pager diff --name-only | sed -n 8p | sed 's/ /\\\\ /g'`"
alias -g _gf9="`git --no-pager diff --name-only | sed -n 9p | sed 's/ /\\\\ /g'`"
alias -g _gf10="`git --no-pager diff --name-only | sed -n 10p | sed 's/ /\\\\ /g'`"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
