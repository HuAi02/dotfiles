#!/bin/bash

echo "Making install scripts executable..."
chmod +x ./install-scripts/*
chmod +x ./scripts/*

# Run install_yay.sh
echo "Running enable-yay.sh..."
./install-scripts/enable-yay.sh

# Run install-packages.sh
echo "Running install-packages.sh..."
./install-scripts/install-packages.sh

# Run sddm-theme.sh
echo "Running sddm-theme.sh..."
./install-scripts/set-sddm-theme.sh

# Run install_fluent_kde.sh
echo "Running install-fluent-kde.sh..."
./install-scripts/install-fluent-kde.sh

# Run copy-configs.sh
echo "Running copy-configs.sh..."
./install-scripts/copy-configs.sh

# Run update-locale.sh
echo "Running update-locale.sh..."
./install-scripts/update-locale.sh

# Run completion.sh
echo "Running completion.sh..."
./install-scripts/completion.sh

echo "All scripts executed!"
