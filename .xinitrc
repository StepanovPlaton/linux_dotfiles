setxkbmap -option grp:ctrl_shift_toggle us,ru

libinput-gestures &

# wal --theme base16-gruvbox-hard
wal --theme ~/.config/colorschemes/vscode.json

polybar -r &

picom &

pactl -- set-sink-volume 0 25%

numen ~/.config/numen/startup.phrasess.txt &
echo "[R]" > ~/.config/numen/current_mode

conky -c ~/.config/conky/conky.conf &
conky -c ~/.config/conky/weather.conf &
conky -c ~/.config/conky/icon.conf &

[ ! -s ~/.config/mpd/pid ] && mpd ~/.config/mpd/mpd.conf && mpc stop

exec sxhkd -c ~/.config/sxhkd/sxhkdrc &
exec bspwm
