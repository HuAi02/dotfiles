#!/bin/bash

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "yay not found, installing yay..."

    # Update package database
    sudo pacman -Sy --noconfirm

    # Install yay from the official Arch repositories
    sudo pacman -S --noconfirm yay
else
    echo "yay is already installed."
fi
