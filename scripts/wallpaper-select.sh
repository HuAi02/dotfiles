#!/bin/bash
# Hyprland Wallpaper Selector - Docked Left Vertical Preview Style
# Dependencies: rofi, imagemagick, notify-send, hyprpaper
# Config
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
FIXED_JPG="$WALLPAPER_DIR/wallpaper.jpg"
LAST_SELECTED_FILE="$HOME/.cache/hyprland_last_wallpaper_path.txt"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
CACHE_DIR="$HOME/.cache/rofi_wallpapers"
ROFI_THEME="$HOME/.config/rofi/themes/wallpaper-select-theme.rasi"
# Create directories
mkdir -p "$WALLPAPER_DIR" "$CACHE_DIR" "$(dirname "$HYPRPAPER_CONF")"
# Rofi override:
rofi_override='
window {
    background-color: rgba(0,0,0,0.8);
    width: 15%;
    height: 100%;
    location: west;
    anchor: west;
    border-radius: 0px;
    border: 0px;
}
mainbox {
    padding: 6% 0px 0% 0px;
}
listview {
    layout: vertical;
    lines: 100;
    columns: 1;
    scrollbar: false;
    spacing: 0px;
}
element {
    orientation: vertical;
    padding: 2px;
    border-radius: 8px;
}
element-icon {
    size: 230px;
    horizontal-align: 0.5;
    vertical-align: 0.5;
}
element-text {
    enabled: false;
}
'
# Generate vertical preview thumbnails (portrait or square-ish)
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -f "$img" ] || continue
  filename=$(basename "$img")
  [ -f "$CACHE_DIR/$filename" ] || convert -strip "$img" -resize 600x340^ -gravity center -extent 600x340 "$CACHE_DIR/$filename"
done
# Rofi image selector
selected=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
  ! -iname "wallpaper.jpg" \
  -exec basename {} \; | sort | while read -r name; do
  echo -en "$name\x00icon\x1f$CACHE_DIR/$name\n"
done | rofi -dmenu -theme "$ROFI_THEME" -theme-str "$rofi_override" -p "Wallpapers" -show-icons)
# Abort if nothing selected
[ -z "$selected" ] && exit 0
selected_path="$WALLPAPER_DIR/$selected"
# Backup current wallpaper
[ -f "$FIXED_JPG" ] && cp "$FIXED_JPG" "$FIXED_JPG.bak"
# Convert to fixed .jpg
convert "$selected_path" "$FIXED_JPG"
# Save path
echo "$selected_path" >"$LAST_SELECTED_FILE"
# Write hyprpaper config
cat >"$HYPRPAPER_CONF" <<EOF
wallpaper {
    monitor = 
    path = $FIXED_JPG
    fit_mode = cover
}
EOF
# Restart hyprpaper
killall hyprpaper 2>/dev/null
hyprpaper &
# Notify
notify-send "Wallpaper Changed" "$selected"
exit 0
