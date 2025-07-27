#!/bin/bash

HYPR_DEST="$HOME/.config/hypr"
SRC_DIR="$HOME/dotfiles"

# Check if destination files exist
hypr_exists=false

[ -f "$HYPR_DEST/hyprland.conf" ] && hypr_exists=true

# Function to copy/symlink hypr configs
copy_configs() {
    echo "Checking for hypr config files in $HYPR_DEST..."
    mkdir -p "$HYPR_DEST"

    # Copy hyprland.conf if not exists
    if [ -f "$HYPR_DEST/hyprland.conf" ]; then
        echo "Existing hyprland.conf found. Skipping copy."
    else
        echo "Copying hyprland.conf..."
        cp "$SRC_DIR/res/hyprland.conf" "$HYPR_DEST/hyprland.conf" && echo "✅ hyprland.conf copied!"
    fi

    # Symlink other hypr configs
    for file in hypridle.conf hyprlock.conf hyprpaper.conf; do
        if [ -f "$HYPR_DEST/$file" ]; then
            echo "Existing $file found. Skipping symlink."
        else
            echo "Creating symlink for $file..."
            ln -s "$SRC_DIR/hypr/$file" "$HYPR_DEST/$file" && echo "✅ $file symlinked!"
        fi
    done
}


# Function to create symlinks
copy_symlinks() {
    echo "Creating symlinks for other configs..."

    # Define an array of directories to loop over
    declare -A dirs=(
        ["alacritty"]="$HOME/.config/alacritty"
        ["dunst"]="$HOME/.config/dunst"
        ["mpv"]="$HOME/.config/mpv"
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
