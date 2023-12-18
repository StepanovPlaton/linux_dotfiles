setxkbmap -option grp:ctrl_shift_toggle us,ru

libinput-gestures &

wal --theme base16-gruvbox-hard

polybar -r &

picom &

pactl -- set-sink-volume 0 25%

numen ~/.config/numen/phrases.phrases --phraselog=phrases.txt &

exec sxhkd -c ~/.config/sxhkd/sxhkdrc &
exec bspwm
