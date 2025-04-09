#!/bin/bash

# Function to check if a package is installed using pacman
is_installed_pacman() {
    pacman -Q "$1" &> /dev/null
}

# Function to check if a package is installed using yay (AUR helper)
is_installed_yay() {
    yay -Q "$1" &> /dev/null
}

# Function to install a package using pacman
install_pacman() {
    sudo pacman -S --noconfirm "$1"
}

# Function to install a package using yay
install_yay() {
    yay -S --noconfirm "$1"
}

# List of packages to install
packages=(
    # SDDM and themes
    "sddm"
    "qt6-svg"
    "qt6-virtualkeyboard"
    "qt6-multimedia-ffmpeg"


    # Hyprland family
    "hyprland"
    "hyprpaper"
    "hypridle"
    "hyprlock"

    # Power menu
    "wlogout"

    # Shell
    "alacritty"
    "zsh"
    "fastfetch"

    # Runner
    "tofi"

    # Notification
    "dunst"

    # waybar-related
    "waybar"
    "network-manager-applet"
    "blueman"
    "brightnessctl"
    "wireplumber"
    "libwireplumber"
    "pavucontrol"

    # CPU and fan control
    "auto-cpufreq"
    "nbfc-linux"

    # Screenshot
    "grim"
    "slurp"

    # Clipboard
    "wl-clipboard"

    # Explorer
    "nemo"

    # Documents
    "onlyoffice-bin"

    # Media
    "gwenview"
    "vlc"
    "spotify"

    # Utilities
    "xdg-desktop-portal-gtk"
    "gnome-clocks"
    "gnome-calendar"
    "btop"

    # Theming
    "nwg-look"
    "qt6ct"
    "qt5ct"
    "kvantum"
    "kvantum-qt5"
    "fluent-gtk-theme" # QT in another script
    "papirus-icon-theme"
    "rose-pine-cursor"
    "rose-pine-hyprcursor"


    # Chinse input
    "fcitx5"
    "fcitx5-chinese-addons"
)

for package in "${packages[@]}"; do
    if is_installed_pacman "$package"; then
        echo "$package is already installed with pacman."
    elif is_installed_yay "$package"; then
        echo "$package is already installed with yay."
    else
        echo "$package is not installed, installing..."
        # First, try installing with pacman
        if sudo pacman -S --noconfirm "$package"; then
            echo "$package installed with pacman."
        # If pacman fails (e.g., it's an AUR package), try yay
        else
            echo "Package not found in pacman, trying yay..."
            yay -S --noconfirm "$package"
        fi
    fi
done
