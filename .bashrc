#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

(cat ~/.cache/wal/sequences &)

. "${HOME}/.cache/wal/colors.sh"
alias dmenu_wal='dmenu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15"'

#export SUDO_ASKPASS=".scripts/dpass.sh"
#alias sudo="sudo -A"

alias numen_full="numen ~/.config/numen/phrases.phrases --phraselog=phrases.txt"
alias ll="ls -lah --color"

export PATH="~/.scripts:$PATH"
export PATH="/usr/lib/jvm/default/bin:$PATH"

# Created by `pipx` on 2025-06-29 13:27:39
export PATH="$PATH:/home/dwarf/.local/bin"

export EDITOR="nvim"
