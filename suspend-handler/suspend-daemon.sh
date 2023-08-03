#!/bin/bash

script_dir=$(dirname "$0")

# Define log file with the start time
start_time=$(date +"%Y%m%d%H%M%S")
log_file=~/templog_$start_time

# Ensure inotify-tools is installed
if ! command -v inotifywait &>/dev/null; then
    echo "inotifywait could not be found. Install it using your package manager." | tee -a "$log_file"
    exit
fi

# Wait for changes in 'should-suspend.txt'
while true; do
    echo "Playing sound..." | tee -a "$log_file"
    aplay ~/Downloads/file.wav

    echo "Waiting for trigger to be modified..." | tee -a "$log_file"
    inotifywait -e modify "$script_dir/trigger" | tee -a "$log_file"

    echo "Fetching active workspace..." | tee -a "$log_file"
    workspace=$(hyprctl monitors | grep "active workspace" | awk -F': ' '{print $2}' | awk '{print $1}')
    echo "Active workspace: $workspace" | tee -a "$log_file"

    echo "Suspending system..." | tee -a "$log_file"
    systemctl suspend

    sleep 5

    # Wait until the system wakes up from suspension and Hyperland switches workspace to 8 (for reasons unknown),
    while [[ $(hyprctl monitors | grep "active workspace" | awk -F': ' '{print $2}' | awk '{print $1}') != 8 ]]; do
        echo "Playing sound..." | tee -a "$log_file"
        aplay ~/Downloads/file.wav
        sleep 1
    done

    echo "Adjusting brightness and workspace..." | tee -a "$log_file"
    hyprctl dispatch exec brightness +0
    hyprctl dispatch workspace $workspace

    echo "Starting kmonad..." | tee -a "$log_file"
    kmonad -ctrue /home/olof/.kmonad-internal.kbd &
    echo "---------------------------------------------------------" | tee -a "$log_file"
done
