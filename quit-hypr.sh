#!/usr/bin/env bash

# addresses=$(hyprctl -j clients | jq -j '.[] | select(.class=="firefox") | "\(.address) "')
# for address in $addresses; do

#     hyprctl dispatch closewindow address:$address
#     sleep 1
# done

# addresses=$(hyprctl -j clients | jq -j '.[] | "\(.address) "')
# for address in $addresses; do

#     hyprctl dispatch closewindow address:$address
#     sleep 0.3
# done

HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
hyprctl --batch "$HYPRCMDS" >>/tmp/hypr/hyprexitwithgrace.log 2>&1

while true; do
    #aplay ~/Downloads/file.wav
    output=$(hyprctl clients)
    if [[ -z "$output" ]]; then
        break
    fi
    sleep 1
done

killall kmonad

reboot
