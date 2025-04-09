#!/bin/bash

output=$(playerctl metadata --format '♫ {{ title }} by {{ artist }} ♫' 2>/dev/null)

# Escape HTML entities for Hyprlock compatibility
escaped=$(echo "$output" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')

echo "<b>$escaped</b>"
