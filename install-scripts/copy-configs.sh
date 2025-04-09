#!/bin/bash

HYPR_DEST="$HOME/.config/hypr"
SRC_DIR="$HOME/dotfiles/res"

HYPR_SRC="$SRC_DIR/hyprland.conf"

# Check if destination files exist
hypr_exists=false

[ -f "$HYPR_DEST/hyprland.conf" ] && hypr_exists=true

copy_configs() {
    echo "Copying hyprland.conf to $HYPR_DEST..."
    mkdir -p "$HYPR_DEST"
    cp "$HYPR_SRC" "$HYPR_DEST/hyprland.conf" && echo "✅ hyprland.conf copied!"
}

# If neither file exists, just copy and exit
if ! $hypr_exists && ! $zshrc_exists; then
    echo "No existing configs found. Creating and copying new configs..."
    copy_configs
    exit 0
fi

# If one or both files exist, prompt user
echo "Existing config(s) detected:"
$hypr_exists && echo "- hyprland.conf"

echo ""
echo "What would you like to do?"
echo "1) Update configs (overwrite existing)"
echo "2) Skip copying"
read -p "Choose [1/2]: " choice

case $choice in
    1)
        echo "Updating configs..."
        copy_configs
        ;;
    2)
        echo "Skipped config update."
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac
