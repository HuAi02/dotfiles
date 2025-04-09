#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Define paths to the new configuration files
NEW_MKINITCPIO_CONF="/etc/mkinitcpio-2.conf"
NEW_GRUB_CONF="/etc/default/grub-2"

# Define paths to the current configuration files
CURRENT_MKINITCPIO_CONF="/etc/mkinitcpio.conf"
CURRENT_GRUB_CONF="/etc/default/grub"

# Backup directory
BACKUP_DIR="$HOME/Documents/backup_configs"
mkdir -p "$BACKUP_DIR"

# Backup current configuration files
echo "Backing up current configuration files..."
cp "$CURRENT_MKINITCPIO_CONF" "$BACKUP_DIR/mkinitcpio.conf.backup"
cp "$CURRENT_GRUB_CONF" "$BACKUP_DIR/grub.backup"

# Swap mkinitcpio.conf files
echo "Swapping mkinitcpio.conf files..."
mv "$CURRENT_MKINITCPIO_CONF" "$CURRENT_MKINITCPIO_CONF.old"
mv "$NEW_MKINITCPIO_CONF" "$CURRENT_MKINITCPIO_CONF"
mv "$CURRENT_MKINITCPIO_CONF.old" "$NEW_MKINITCPIO_CONF"

# Swap grub configuration files
echo "Swapping grub configuration files..."
mv "$CURRENT_GRUB_CONF" "$CURRENT_GRUB_CONF.old"
mv "$NEW_GRUB_CONF" "$CURRENT_GRUB_CONF"
mv "$CURRENT_GRUB_CONF.old" "$NEW_GRUB_CONF"

# Update GRUB configuration
# echo "Updating GRUB configuration..."
# grub-mkconfig -o /boot/grub/grub.cfg
echo "Skipping GRUB configuration..."

# Regenerate initramfs using mkinitcpio
echo "Regenerating initramfs..."
mkinitcpio -P

echo "System configuration updated successfully!"
