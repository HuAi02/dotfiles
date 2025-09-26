# My Personal Hyprland Config
## Screenshot
<img width="1920" height="1080" alt="Showcase" src="https://github.com/user-attachments/assets/bf98df08-07f6-47f6-af73-08694c3610a1" />


## My Setup
[Acer Nitro 5 AN515-55](https://www.notebookcheck.net/Acer-Nitro-5-AN515-55-Laptop-Review-Price-to-performance-champ-with-an-RTX-3060.540607.0.html)\
[Arch Linux](https://archlinux.org/)

## Install Hyprland
[Guide here](https://wiki.hyprland.org/Getting-Started/Installation/)

## Dependencies
```
# Hyprland utilities
hyprpaper
hypridle
hyprlock
waybar
wlogout
tofi (previously wofi)
dunst
nm-applet
blueman-applet
brightnessctl
wpctl
pavucontrol

# CPU and fan control
auto-cpufreq (previously tlp & powertop)
nbfc

# Screenshot
grim
slurp

# Clipboard
wlpaste

# Preference
nemo
gwenview
```

## Nitro 5 keyboard backlight:
Someone made a [module](https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module)\
Install as a service and it should work fine\
Configuration autoset on boot (in hypr/autostart.conf)

## Fan control:
Use [nbfc](https://github.com/nbfc-linux/nbfc-linux) and set model to AN515-51 (it's compatible)\
This sets to auto fan control:
```
nbfc set -a
```

## For app dark themes:
```
nwg-look (Nordic theme, Adwaita icons, BreezeX-RosePine cursor)
qt6ct (set to kvantum-dark)
qt5ct (set color scheme to darker)
kvantum & kvantum-qt5 (Qt, KvArcDark theme)
fluent-gtk-theme
Fluent KDE (link below)
xdg-desktop-portal-gtk or xdg-portal-hyprland
```

## For Chinese pinyin input:
```
fcitx5
fcitx5-chinese-addon
```

## Grub theme:
[Mojave Elegant](https://github.com/vinceliuice/Elegant-grub2-themes)

## SDDM theme:
[Astronaut Theme - Hyprland Kath](https://github.com/Keyitdev/sddm-astronaut-theme)

## Fluent KDE theme:
[Fluent KDE](https://github.com/vinceliuice/Fluent-kde.git)
