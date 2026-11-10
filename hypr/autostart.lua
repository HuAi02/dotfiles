-- Autostart (migrated from autostart.conf)
-- See https://wiki.hypr.land/configuring/core/autostart/
-- hl.exec_cmd() is async, no need for trailing `&`.
-- `exec-once` -> hyprland.start event. `exec` (every reload) -> top-level hl.exec_cmd.

local DOTFILES = os.getenv("HOME") .. "/dotfiles"

hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 1 && hyprlock")
    hl.exec_cmd('tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"')
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start graphical-session.target") -- elephant + walker run as systemd user units (auto-restart)
    hl.exec_cmd(DOTFILES .. "/hypr/xdg-portal-hyprland")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("cliphist wipe")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("playerctld daemon")
    hl.exec_cmd("kitty")

    -- Scripts
    hl.exec_cmd(DOTFILES .. "/scripts/set_volume.sh")
    hl.exec_cmd(DOTFILES .. "/scripts/cycle_play.sh")

    -- Fix mouse cursor inconsistency (https://github.com/hyprwm/Hyprland/issues/6320#issuecomment-2243109637)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
    hl.exec_cmd("nwg-look set cursor Bibata-Modern-Classic")
end)

-- Old `exec =` lines (run on every config reload, including startup since top-level runs each load)
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Fluent-Dark"')
