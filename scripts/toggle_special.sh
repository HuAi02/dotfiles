#!/bin/bash

# Path to your existing toggle script
WAYBAR_SCRIPT="$HOME/dotfiles/scripts/toggle_waybar.sh"

# Run the Waybar toggle
"$WAYBAR_SCRIPT"

# Wait for Waybar animation to finish (adjust as needed)
sleep 1s

# Switch to special workspace
hyprctl dispatch togglespecialworkspace magic
