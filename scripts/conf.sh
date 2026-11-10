#!/bin/bash

# Directory containing the config files
CONFIG_DIR="$HOME/dotfiles/hypr"

# List Hyprland lua configs + daemon .conf files and store them in an array
mapfile -t conf_files < <(ls "$CONFIG_DIR"/*.lua "$CONFIG_DIR"/hypr*.conf 2>/dev/null | xargs -n 1 basename | sort -u)

# Display the list of config files in walker (dmenu mode)
selected_config=$(printf "%s\n" "${conf_files[@]}" | walker --dmenu)

# Check if a selection was made
if [ -n "$selected_config" ]; then
  # Open the selected config file in neovim
  kitty nvim "$CONFIG_DIR/$selected_config"
else
  echo "No selection made. Exiting..."
  exit 1
fi
