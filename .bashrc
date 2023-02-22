#
# ~/.bashrc
#
export PATH="$HOME/.local/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

# _set_liveuser_PS1() {
#     PS1='[\033[01;33m\]\u\[\033[00m\] \W] $ \[\033[00m\]'
#     if [ "$(whoami)" = "liveuser" ] ; then
#         local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
#         if [ -n "$iso_version" ] ; then
#             local prefix="eos-"
#             local iso_info="$prefix$iso_version"
#             PS1="[\u@$iso_info \W]\$ "
#         fi
#     fi
# }
# _set_liveuser_PS1
# unset -f _set_liveuser_PS1

if [[ ${EUID} == 0 ]]; then
    PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
else
    #           color   user    normal  folder  normal
    #PS1='[\[$(tput setaf 3)\]\u\[$(tput sgr0)\] \W] \\$ \[$(tput sgr0)\]' no bold color
    #PS1='[\[\e[01;33m\]\u\[\e[m\] \W] \\$ \[$(tput sgr0)\]'
    PS1="\[$(tput bold)\]\[\e[33m\]\u \[\e[31m\]\W >\[\e[m\]  "
fi

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ]; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..' # show long listing of all except ".."
alias l='ls -lav --ignore=.?*' # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100 # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ]; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >&/dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ]; then
        for file in "$@"; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >&/dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################

# Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Exports
export PATH=$PATH:$HOME/scripts
export QT_QPA_PLATFORMTHEME="qt5ct"
# Newline after each command
# PROMPT_COMMAND="echo"

# Aliases
alias sudo='sudo '

# Quality of life
alias paru='paru --noconfirm'
alias fuck='sudo $(history -p !!)'
eval $(thefuck --alias bro)
alias p='sudo pacman'
alias ls='exa'
alias op='xdg-open'
alias vim='nvim'
alias suspend='systemctl suspend'

# Movement
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias home='cd ~'
alias dl='cd ~/dl'
alias docs='cd ~/docs'
alias pics='cd ~/pics'

# File Management

alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias rm='rm -i'
alias cp='cp -v -i'
alias mv='mv -v -i'
alias del='trash-put'
alias search='find -L . -iname'

# Configs
alias brc='nvim ~/.bashrc'
alias sbrc='source ~/.bashrc'

complete -o default java
