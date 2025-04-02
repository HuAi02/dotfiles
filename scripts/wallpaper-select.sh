#!/bin/bash

# Hyprland Wallpaper Selector with History
# Requires: tofi, hyprpaper, find, basename

# Configuration
WALLPAPER_DIR="/home/huai/Pictures/Wallpapers"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
HISTORY_FILE="$HOME/.cache/hyprland_wallpaper_history.txt"
MAX_HISTORY=5  # Number of recent wallpapers to remember

# Create necessary directories and files
mkdir -p "$(dirname "$HISTORY_FILE")"
mkdir -p "$WALLPAPER_DIR"
touch "$HISTORY_FILE"

# Get list of image files
wallpapers=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \))

if [ -z "$wallpapers" ]; then
    notify-send "Wallpaper Selector" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Prepare the selection menu with history
{
    echo "󰌍 Previous Wallpaper"
    # Add current wallpapers
    echo "$wallpapers" | while read -r line; do basename "$line"; done
    # Add recent history (excluding duplicates and non-existent files)
    grep -v '^$' "$HISTORY_FILE" | while read -r line; do
        if [ -f "$line" ]; then
            basename "$line"
        fi
    done
} | tofi --prompt-text "Select Wallpaper: " | {
    read -r selected

    if [ -z "$selected" ]; then
        exit 0
    fi

    if [ "$selected" = "󰌍 Previous Wallpaper" ]; then
        # Get the most recent previous wallpaper (second line in history)
        previous_wallpaper=$(tail -n +2 "$HISTORY_FILE" | head -n 1)
        if [ -n "$previous_wallpaper" ] && [ -f "$previous_wallpaper" ]; then
            full_path="$previous_wallpaper"
        else
            notify-send "Wallpaper Selector" "No previous wallpaper found"
            exit 1
        fi
    else
        # Find the full path of the selected wallpaper
        full_path=$(echo "$wallpapers" | grep -F "/$selected")
        if [ -z "$full_path" ]; then
            # Check if it's from history
            full_path=$(grep -F "/$selected" "$HISTORY_FILE" | head -n 1)
        fi
    fi

    if [ -n "$full_path" ] && [ -f "$full_path" ]; then
        # Update history
        temp_file=$(mktemp)
        echo "$full_path" > "$temp_file"
        grep -v -F "$full_path" "$HISTORY_FILE" | head -n $((MAX_HISTORY - 1)) >> "$temp_file"
        mv "$temp_file" "$HISTORY_FILE"

        # Update hyprpaper config
        echo "preload = $full_path" > "$HYPRPAPER_CONF"
        echo "wallpaper = ,$full_path" >> "$HYPRPAPER_CONF"

        # Restart hyprpaper to apply changes
        killall hyprpaper || true
        hyprpaper &

        notify-send "Wallpaper Changed" "$(basename "$full_path")"
    else
        notify-send "Wallpaper Selector" "Error: Could not find selected wallpaper"
    fi
}
