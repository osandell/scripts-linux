#!/usr/bin/env bash

# Kill and restart waybar whenever its config files change
CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css"
while true; do
    waybar &
    inotifywait -e modify ${CONFIG_FILES}
    killall .waybar-wrapped
done
