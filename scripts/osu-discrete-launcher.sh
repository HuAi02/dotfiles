#!/bin/bash

# Get the highest workspace ID
max_id=$(hyprctl workspaces | grep -Po 'workspace ID \K\d+' | sort -nr | head -n 1)
[ -z "$max_id" ] && max_id=0

# Assign new workspaces
otd_ws=$((max_id + 1))
osu_ws=$((max_id + 2))
echo $otd_ws $osu_ws

# Launch otd-gui in new workspace
hyprctl dispatch workspace "$otd_ws"

# Launch otd-daemon in background
otd-daemon &
otd-gui &

# Wait briefly to ensure otd-gui initializes before switching workspace
sleep 5

# Launch osu-wine in another workspace
hyprctl dispatch workspace "$osu_ws"
DRI_PRIME=1 /home/huai/.local/bin/osu-wine "$@"

# Kill otd-gui after osu exits
pkill otd-gui
