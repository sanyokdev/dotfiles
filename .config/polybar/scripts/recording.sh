#!/bin/bash

# Get message variable
if [[ "$1" == "--get" ]]; then
    echo "$RECORDING_MSG"
    exit 0
fi

# Stop recording
if [[ "$1" == "--stop" ]]; then
    if pgrep -x "obs" > /dev/null && [[ "$(<~/.sanyok-private/polybar-cur.txt)" = "recording" ]]; then
        notify-send "Recording stopped!" --expire-time=2500
        $HOME/.config/polybar/launch.sh # Reload polybar to default

        notify-send "Closing OBS, do not use!" --expire-time=2500
        sleep 3 # Wait before closing OBS incase of loading
        killall -q obs
    fi
       
    exit 0
fi

# Check if the current bar is set to "recording" else, prompt change
if [[ "$(<~/.sanyok-private/polybar-cur.txt)" != "recording" ]]; then
    # Exit if prompt if currently open
    if pgrep -x "yad" > /dev/null; then
        exit 0
    fi

    # If launched, kill OBS so it doesn't record right away
    if pgrep -x "obs" > /dev/null; then
        killall -q obs
    fi

    # Prompt for input and set the environment variable, use previous if found 
    msg_path=$HOME/.sanyok-private/yad-prev.txt
    touch $msg_path # Create file if not found
    prev_msg=$(<$msg_path)
    cur_msg="$(yad --entry --text="Enter recording message:" --entry-text "$prev_msg")"
   
    if [[ -n "$cur_msg" ]]; then
        export RECORDING_MSG="Subject: $cur_msg"
        echo "$cur_msg" > ~/.sanyok-private/yad-prev.txt

        # Start recording mode
        $HOME/.config/polybar/launch.sh --recording
        obs &

        notify-send "Ready to record." --expire-time=2500
    fi

    exit 0
else
    # OBS handles the actual screen recording (uses the same keybind as script)
    if pgrep -x "obs" > /dev/null; then # Checks if OBS crashed on launch
        dunstctl close-all
        paplay $HOME/.sanyok/media/recording-snd.mp3
    else
        notify-send "OBS crashed or exited, reverting to default!" --expire-time=2500
        $HOME/.config/polybar/launch.sh # Reload polybar to default
    fi
fi
