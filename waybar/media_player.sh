#!/bin/bash

# Function to truncate text to a specified length and add "..." if truncated
truncate_text() {
    max_length=15
    text="$1"
    if [ ${#text} -gt $max_length ]; then
        echo "${text:0:$max_length}..."
    else
        echo "$text"
    fi
}

status=$(playerctl status)
artist=$(playerctl metadata artist)
title=$(playerctl metadata title)

# Truncate the artist and title if they're too long
artist=$(truncate_text "$artist")
title=$(truncate_text "$title")

# Combine artist and title
full_text="$artist | $title"

if [ "$status" == "Playing" ]; then
    echo "▶️ $full_text"
elif [ "$status" == "Paused" ]; then
    echo "⏸️ $full_text"
else
    echo "No music"
fi
