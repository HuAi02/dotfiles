-- Hyprland Lua config (migrated from hyprlang *.conf, Hyprland >= 0.55)
-- Entry point: ~/.config/hypr/hyprland.lua -> this file
-- Split to mirror the old multi-file layout. Each require() is separately
-- protected: an error in one file won't stop the others from loading.

require("/home/huai/dotfiles/hypr/monitors")
require("/home/huai/dotfiles/hypr/env")
require("/home/huai/dotfiles/hypr/appearance")
require("/home/huai/dotfiles/hypr/input")
require("/home/huai/dotfiles/hypr/autostart")
require("/home/huai/dotfiles/hypr/keybinds")
require("/home/huai/dotfiles/hypr/windowrules")
