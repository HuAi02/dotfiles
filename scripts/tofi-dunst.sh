#!/bin/bash

# Read the action list from stdin (provided by dunst)
choice=$(tofi --prompt-text="Choose Action:" <&0)

# Echo the choice so dunst can read it back
[ -n "$choice" ] && echo "$choice"
