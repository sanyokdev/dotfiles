#!/bin/bash

if [[ "$1" == "--stop" ]]; then
    if pgrep -x "obs" > /dev/null; then
        notify-send "Stopping recording!" --expire-time=2500
        $HOME/.config/polybar/launch.sh
    fi
       
    exit 0
fi

# Prompt for input and set the environment variable
message=$(zenity --entry --title="Recording Message" --text="Enter the recording message:")

if [ -n "$message" ]; then
    export RECORDING_MSG="Subject: $message"

    # Restart Polybar to apply the changes
    $HOME/.config/polybar/launch.sh --recording
        
    # Start obs if not currently running
    if ! pgrep -x "obs" > /dev/null; then
        obs --startrecording &
    fi

    notify-send "Ready to record!" --expire-time=2500
fi
