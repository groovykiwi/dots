# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions z)

source $ZSH/oh-my-zsh.sh
autoload -U colors && colors

# Exports
export PATH=$PATH:$HOME/scripts
export QT_QPA_PLATFORMTHEME="qt5ct"
# Newline after each command
# PROMPT_COMMAND="echo"

# Aliases
alias sudo='sudo '

# Quality of life
alias paru='paru --noconfirm'
eval $(thefuck --alias bro)
alias fuck='sudo $(fc -ln -1)'
alias p='sudo pacman'
alias ls='exa'
alias open='xdg-open'
alias vim='nvim'
alias suspend='systemctl suspend'
# Movement
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias home='cd ~'
alias dl='cd ~/dl'
alias docs='cd ~/docs'
alias pics='cd ~/pics'
alias pwd='pwd | colorize 4'

# File Management
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias rm='rm -i'
alias cp='cp -v -i'
alias mv='mv -v -i'
alias del='trash-put'
alias search='find -L . -iname'

complete -o default java
PROMPT="%{$fg[yellow]%}%B%n%{$fg[red]%} %1~ >%b "

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do time $shell -i -c exit; done
}

zstyle ':completion:*' rehash true
