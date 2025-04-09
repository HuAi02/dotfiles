#!/bin/bash

# Read the action list from stdin (provided by dunst)
choice=$(cat - | tofi --prompt-text="Choose Action:")

# Echo the choice so dunst can read it back
echo "$choice"
