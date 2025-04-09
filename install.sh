#!/bin/bash

# Run install_yay.sh
echo "Running enable-yay.sh..."
./install-scripts/enable-yay.sh

# Run install-packages.sh
echo "Running install-packages.sh..."
./install-scripts/install-packages.sh

# Run sddm-theme.sh
echo "Running sddm-theme.sh..."
./install-scripts/sddm-theme.sh

# Run install_fluent_kde.sh
echo "Running install-fluent-kde.sh..."
./install-scripts/install-fluent-kde.sh

# Run custom_theme_setup.sh
echo "Running copy-configs.sh..."
./install-scripts/copy-configs.sh

echo "All scripts executed!"
