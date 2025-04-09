#!/bin/bash

# Directory containing the config files
CONFIG_DIR="$HOME/dotfiles/hypr"

# List only .conf files and store them in an array
mapfile -t conf_files < <(ls "$CONFIG_DIR"/*.conf | xargs -n 1 basename)

# Display the list of config files in tofi
selected_config=$(printf "%s\n" "${conf_files[@]}" | tofi --prompt-text "open:")

# Check if a selection was made
if [ -n "$selected_config" ]; then
  # Open the selected config file in neovim
  alacritty -e nvim "$CONFIG_DIR/$selected_config"
else
  echo "No selection made. Exiting..."
  exit 1
fi
