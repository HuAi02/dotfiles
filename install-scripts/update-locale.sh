#!/bin/bash

# Define source and destination for locale.gen
LOCALE_SRC="$HOME/dotfiles/locale/locale.gen"
LOCALE_DEST="/etc/locale.gen"

# Check if the locale.gen file exists in the source
if [ -f "$LOCALE_SRC" ]; then
    echo "Copying $LOCALE_SRC to $LOCALE_DEST..."
    sudo cp "$LOCALE_SRC" "$LOCALE_DEST" && echo "✅ locale.gen copied successfully!"
else
    echo "Error: $LOCALE_SRC not found!"
    exit 1
fi

# Run locale-gen
echo "Running locale-gen..."
sudo locale-gen && echo "✅ locale-gen completed successfully!"

# Compatibility with dual boot, this fixes wrong Windows timing
timedatectl set-local-rtc 0
