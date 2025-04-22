#!/bin/bash

# Hyprland Wallpaper Selector with Fixed Filename (Convert to .jpg for Hyprlock)
# Requires: tofi, hyprpaper, notify-send, find, basename, imagemagick

# Config
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
CURRENT_WALLPAPER="$WALLPAPER_DIR/wallpaper"
LAST_SELECTED_FILE="$HOME/.cache/hyprland_last_wallpaper_path.txt"
FIXED_JPG="$WALLPAPER_DIR/wallpaper.jpg"

# Create required dirs
mkdir -p "$WALLPAPER_DIR"
mkdir -p "$(dirname "$HYPRPAPER_CONF")"
mkdir -p "$(dirname "$LAST_SELECTED_FILE")"

# Get list of image files (exclude the current converted wallpaper)
wallpapers=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) ! -name "wallpaper.jpg")

if [ -z "$wallpapers" ]; then
    notify-send "Wallpaper Selector" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Prompt selection
selected=$(echo "$wallpapers" | while read -r line; do basename "$line"; done | tofi --prompt-text "Select Wallpaper: ")

if [ -z "$selected" ]; then
    exit 0
fi

selected_path="$WALLPAPER_DIR/$selected"

# Backup previous wallpaper.jpg (if you want to restore the original someday)
if [ -f "$FIXED_JPG" ]; then
    rm -f "$FIXED_JPG.bak"
    cp "$FIXED_JPG" "$FIXED_JPG.bak"
fi

# Convert selected image to wallpaper.jpg
convert "$selected_path" "$FIXED_JPG"

# Store the path
echo "$selected_path" > "$LAST_SELECTED_FILE"

# Update hyprpaper config
echo "preload = $FIXED_JPG" > "$HYPRPAPER_CONF"
echo "wallpaper = ,$FIXED_JPG" >> "$HYPRPAPER_CONF"

# Restart hyprpaper
killall hyprpaper || true
hyprpaper &

notify-send "Wallpaper Changed" "$selected"
