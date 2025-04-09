#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "yay not found, installing yay..."

    # Clone the yay repo
    git clone https://aur.archlinux.org/yay.git /tmp/yay

    # Navigate to the yay directory
    cd /tmp/yay

    # Build and install yay
    makepkg -si --noconfirm

    # Cleanup
    cd ~
    rm -rf /tmp/yay
else
    echo "yay is already installed."
fi
