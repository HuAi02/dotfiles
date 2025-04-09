#!/bin/bash

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "yay not found, installing yay..."

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
else
    echo "yay is already installed."
fi
