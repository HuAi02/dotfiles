#!/bin/bash

# Start OpenTabletDriver daemon
otd-daemon &

# Start OpenTabletDriver GUI
otd-gui &

# Launch osu-wine with discrete GPU
DRI_PRIME=1 /home/huai/.local/bin/osu-wine "$@"

pkill otd-gui
