#!/bin/bash

# Get current brightness and max brightness
current=$(cat /sys/class/backlight/gmux_backlight/brightness)
max=$(cat /sys/class/backlight/gmux_backlight/max_brightness)

# If no argument is provided, echo the current brightness and exit
if [[ $# -eq 0 ]]
then
    echo $current
    exit 0
fi

# Check if argument is a number
if [[ $1 =~ ^[+-]?[0-9]+(\.[0-9]+)?$ ]]
then
    if [[ $1 =~ ^[+-] ]]
    then
        # If argument is a relative number (starting with '+' or '-')
        sign="${1:0:1}"
        value="${1:1}"
        percent=$(echo "scale=2; $value * $max / 100" | bc)
        if [[ $sign == '+' ]]
        then
            new=$(echo "$current + $percent" | bc)
        else
            new=$(echo "$current - $percent" | bc)
        fi
    else
        # If argument is an absolute number
        new=$1
    fi

    # Ensure new brightness is within the valid range
    if (( $(echo "$new < 1" |bc -l) )); then new=1; fi
    if (( $(echo "$new > $max" |bc -l) )); then new=$max; fi

    # Update brightness
    echo ${new%.*} | sudo dd of=/sys/class/backlight/gmux_backlight/brightness
else
    echo "Invalid argument: please provide a number, optionally starting with '+' or '-' for relative adjustment."
    exit 1
fi
