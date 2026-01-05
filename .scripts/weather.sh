#!/bin/env bash
colors_path=$HOME/.cache/wal/colors.sh

WEATHER=$(curl --silent v2d.wttr.in/Samara | grep "Weather:")
TEMP=$(echo $WEATHER | tr "," "\n" | grep "°C")

if [ -f "$colors_path" ]; then
	source $colors_path
	[[ ! -z "$TEMP" ]] && echo "^b$color1^^c$color0^  ^d^^b$color8^^c$color0^$TEMP ^d^"
fi
