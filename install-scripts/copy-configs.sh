#!/bin/bash

HYPR_DEST="$HOME/.config/hypr"
SRC_DIR="$HOME/dotfiles/res"

HYPR_SRC="$SRC_DIR/hyprland.conf"

# Check if destination files exist
hypr_exists=false

[ -f "$HYPR_DEST/hyprland.conf" ] && hypr_exists=true

# Function to copy the hyprland.conf
copy_configs() {
    echo "Checking if hyprland.conf exists in $HYPR_DEST..."

    # Check if the destination file exists
    if [ -f "$HYPR_DEST/hyprland.conf" ]; then
        echo "Existing hyprland.conf found in $HYPR_DEST. Skipping copy."
    else
        echo "Copying hyprland.conf to $HYPR_DEST..."
        mkdir -p "$HYPR_DEST"
        cp "$HYPR_SRC" "$HYPR_DEST/hyprland.conf" && echo "✅ hyprland.conf copied!"
    fi
}

# Function to create symlinks
copy_symlinks() {
    echo "Creating symlinks for other configs..."

    # Define an array of directories to loop over
    declare -A dirs=(
        ["waybar"]="$HOME/.config/waybar"
        ["tofi"]="$HOME/.config/tofi"
        ["fastfetch"]="$HOME/.config/fastfetch"
        ["kvantum"]="$HOME/.config/Kvantum"
        ["qt5ct"]="$HOME/.config/qt5ct"
        ["qt6ct"]="$HOME/.config/qt6ct"
        ["alacritty"]="$HOME/.config/alacritty"
        ["wlogout"]="$HOME/.config/wlogout"
    )

    # Loop through each directory
    for dir in "${!dirs[@]}"; do
        dest="${dirs[$dir]}"

        # Check if the destination directory exists and has files
        if [ -d "$dest" ] && [ "$(ls -A $dest)" ]; then
            echo "Existing files found in $dest. Skipping symlink creation for $dir."
        else
            echo "Creating symlinks for $dir..."
            mkdir -p "$dest"
            cp -s "$HOME/dotfiles/$dir/"* "$dest/"
            echo "✅ Symlinks for $dir created!"
        fi
    done
}

# If neither file exists, just copy and exit
if ! $hypr_exists && ! $zshrc_exists; then
    echo "No existing configs found. Creating and copying new configs..."
    copy_configs
    copy_symlinks
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
        copy_symlinks
        ;;
    2)
        echo "Skipped config update."
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac
