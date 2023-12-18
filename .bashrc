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
