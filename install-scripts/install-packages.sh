#!/bin/bash

# Ensure not running as root
if [ "$EUID" -eq 0 ]; then
  echo "⚠️  Please do NOT run this script as root."
  exit 1
fi

# Function to check if a package is installed using pacman
is_installed_pacman() {
  pacman -Q "$1" &>/dev/null
}

# Function to check if a package is installed using yay (AUR helper)
is_installed_yay() {
  yay -Q "$1" &>/dev/null
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
  "rofi"

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

  # NVIDIA driver
  "nvidia-dkms"
  "nvidia-settings"

  # Tablet driver
  "otd-daemon"
  "otd-gui"

  # CPU and fan control
  "auto-cpufreq"
  "nbfc-linux"

  # Screenshot & recording
  "grim"
  "slurp"
  "obs-studio"

  # Clipboard
  "wl-clipboard"
  "cliphist"

  # Explorer
  "nemo"

  # Documents
  "onlyoffice-bin"

<<<<<<< HEAD
  # Media
  "loupe"
  "vlc"
  "mpv"
  "mpv-mpris"
  "spotify"
  "vesktop"
  "lutris"
  "wine"
  "qbittorrent"

  # Utilities
  "xdg-desktop-portal-hyprland"
  "xdg-desktop-portal"
  "gnome-clocks"
  "gnome-calendar"
  "btop"
  "base-devel"
  "git"
  "imagemagick"
  "gnome-disk-utility"
  "baobab"
  "easyeffects"
  "lsp-plugins"
  "pamixer"
  "unzip"
  "zip"
=======
    # Media
    "loupe"
    "vlc"
    "mpv"
    "mpv-mpris"
    "spotify"
    "vesktop"
    "lutris"
    "wine"
    "qbittorrent"

    # Utilities
    "xdg-desktop-portal-hyprland"
    "xdg-desktop-portal"
    "gnome-clocks"
    "gnome-calendar"
    "btop"
    "base-devel"
    "git"
    "imagemagick"
    "gnome-disk-utility"
    "baobab"
    "easyeffects"
    "lsp-plugins"
    "pamixer"
    "unzip"
    "zip"
>>>>>>> 27162b8 (Sync)

  # File sharing
  "warp"

<<<<<<< HEAD
  # ADB capabilities
  "android-tools"
  "easyeffects"
=======
    # ADB capabilities
    "android-tools"
>>>>>>> 27162b8 (Sync)

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
  "fcitx5-configtool"

<<<<<<< HEAD
  # Fonts
  "adobe-source-code-pro-fonts"
  "noto-fonts-cjk"
  "noto-fonts"
  "noto-fonts-extra"

  # Emoji fonts
  "noto-fonts-emoji"
  "otf-font-awesome"
  "ttf-nerd-fonts-symbols-mono"
=======
    # Fonts
    "adobe-source-code-pro-fonts"
    "noto-fonts-cjk"
    "noto-fonts"
    "noto-fonts-extra"

    # Emoji fonts
    "noto-fonts-emoji"
    "otf-font-awesome"
    "ttf-nerd-fonts-symbols-mono"
>>>>>>> 27162b8 (Sync)
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
