#!/bin/bash

<<<<<<< HEAD
# Hyprland Wallpaper Selector with Rofi Previews
# Dependencies: rofi, imagemagick, notify-send, hyprpaper, bc, hyprctl

# Config
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
FIXED_JPG="$WALLPAPER_DIR/wallpaper.jpg"
LAST_SELECTED_FILE="$HOME/.cache/hyprland_last_wallpaper_path.txt"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
CACHE_DIR="$HOME/.cache/rofi_wallpapers"
ROFI_THEME="$HOME/.config/rofi/themes/wallpaper-select-theme.rasi"

# Create directories
mkdir -p "$WALLPAPER_DIR" "$CACHE_DIR" "$(dirname "$HYPRPAPER_CONF")"

# Rofi override style for icon size
rofi_override=""
=======
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
>>>>>>> 6738384f92357b151597d9981b61f4672133e85c

# Generate preview icons
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    [ -f "$CACHE_DIR/$filename" ] || convert -strip "$img" -thumbnail 500x500^ -gravity center -extent 500x500 "$CACHE_DIR/$filename"
done

<<<<<<< HEAD
# Rofi image selector with previews
selected=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    ! -iname "wallpaper.jpg" \
    -exec basename {} \; | sort | while read -r name; do
    echo -en "$name\x00icon\x1f$CACHE_DIR/$name\n"
done | rofi -dmenu -theme "$ROFI_THEME" -theme-str "$rofi_override" -p "Select Wallpaper")

# Abort if nothing selected
[ -z "$selected" ] && exit 0
selected_path="$WALLPAPER_DIR/$selected"

# Backup current wallpaper
[ -f "$FIXED_JPG" ] && cp "$FIXED_JPG" "$FIXED_JPG.bak"

# Convert to fixed .jpg
convert "$selected_path" "$FIXED_JPG"

# Save path
echo "$selected_path" > "$LAST_SELECTED_FILE"

# Write hyprpaper config
echo "preload = $FIXED_JPG" > "$HYPRPAPER_CONF"
echo "wallpaper = ,$FIXED_JPG" >> "$HYPRPAPER_CONF"

# Restart hyprpaper
killall hyprpaper 2>/dev/null
hyprpaper &

# Notify
notify-send "Wallpaper Changed" "$selected"

exit 0
=======
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
>>>>>>> 6738384f92357b151597d9981b61f4672133e85c
