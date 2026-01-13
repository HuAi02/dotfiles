#!/bin/bash

# Check if Waybar is running
if pgrep -x "waybar" >/dev/null; then
  # If Waybar is running, kill it
  kill -SIGUSR1 $(pidof waybar)
else
  # If Waybar is not running, start it
  kill -SIGUSR1 $(pidof waybar)
fi
