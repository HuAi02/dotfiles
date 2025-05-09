#!/bin/bash

# Ensure not running as root
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  Please do NOT run this script as root."
    exit 1
fi

# Function to check if a package is installed using pacman
is_installed_pacman() {
    pacman -Q "$1" &> /dev/null
}

# Function to check if a package is installed using yay (AUR helper)
is_installed_yay() {
    yay -Q "$1" &> /dev/null
}

# List of packages to install
packages=(
    # SDDM and themes
    "sddm"
    "qt6-svg"
    "qt6-virtualkeyboard"
    "qt6-multimedia-ffmpeg"

    # Grub stuff
    "os-prober"

    # Hyprland family
    "hyprland"
    "hyprpaper"
    "hypridle"
    "hyprlock"
    "hyprpolkitagent"

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
    "cliphist"

    # Explorer
    "nemo"

    # Documents
    "onlyoffice-bin"

    # Media
    "loupe"
    "vlc"
    "spotify"
    "vesktop"

    # Utilities
    "xdg-desktop-portal-gtk"
    "gnome-clocks"
    "gnome-calendar"
    "btop"
    "base-devel"
    "git"
    "imagemagick"
    "gnome-disk-utility"
    "easyeffects"

    # Internet
    "firefox"

    # Theming
    "nwg-look"
    "qt6ct"
    "qt5ct"
    "kvantum"
    "kvantum-qt5"
    "fluent-gtk-theme"
    "papirus-icon-theme"
    "rose-pine-cursor"
    "rose-pine-hyprcursor"

    # Chinese input
    "fcitx5"
    "fcitx5-chinese-addons"

    # Fonts
    "adobe-source-code-pro-fonts"
    "noto-fonts-cjk"
    "otf-font-awesome"
    "ttf-nerd-fonts-symbols-mono"
)

echo "🔍 Checking and installing packages..."

for package in "${packages[@]}"; do
    if is_installed_pacman "$package"; then
        echo "✅ $package is already installed with pacman."
    elif is_installed_yay "$package"; then
        echo "✅ $package is already installed with yay."
    else
        echo "📦 Installing $package..."
        if sudo pacman -S --noconfirm --needed "$package"; then
            echo "✅ Installed $package with pacman."
        else
            echo "📦 $package not found in pacman, trying yay..."
            yay -S --noconfirm "$package"
        fi
    fi
done

echo "🎉 Setup complete!"
