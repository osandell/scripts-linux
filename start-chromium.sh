#!/bin/sh

# Chromium has a bug that makes the window too large on initial start. To work around that we
# launch it floating (rule in hyprland.conf), then toggle float back off. This corrects the bug
# but has the side effect that it jumps to another workspace so we have to move it to the correct one.
hyprctl dispatch exec "[workspace 9] chromium --ozone-platform-hint=auto --auto-open-devtools-for-tabs"
sleep 3
hyprctl dispatch togglefloating chromium
sleep 1
hyprctl dispatch movetoworkspace "3,^(.*chromium)$"
