#!/bin/bash

# Terminate already running bar instances
# If all your bars have IPC enabled, you can use polybar-msg cmd quit
# Otherwise, you can use the nuclear option: killall -q polybar

# Launch Polybar and log the output to a file
{
  polybar-msg cmd quit  # Attempt to gracefully quit running instances
  killall -q polybar   # If graceful quit fails, forcefully terminate instances

  config="ikigai" # Default bar
  if [[ "$1" == "--recording" ]]; then
      config="recording" # Recording bar
  fi

  polybar "$config"
  echo "--- Polybar Launched!"
} > /tmp/polybar1.log 2>&1 & disown
