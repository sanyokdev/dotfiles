#!/bin/bash

# Select desired bar
bar_name="ikigai" # Default bar
if [[ "$1" == "--recording" ]]; then
    bar_name="recording" # Recording bar
fi

# Launch/quit Polybar and log the output to a file
{
  polybar-msg cmd quit # Attempt to gracefully quit running instances
  killall -q polybar   # If graceful quit fails, forcefully terminate instances

  polybar -c ~/.config/polybar/config-"$bar_name".ini custom
  echo "--- Polybar Launched!"
} > /tmp/polybar1.log 2>&1 & disown

echo "$bar_name" > ~/.sanyok-private/polybar-cur.txt
