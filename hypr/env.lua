-- Environment variables (migrated from ../variables/env_var.conf + env_var_nvidia.conf)
-- See https://wiki.hypr.land/configuring/core/environment-variables/
-- NOTE: uwsm users should prefer ~/.config/uwsm/env instead. Kept here to match old behavior.

-- Theming
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- Carried over as-is from old config (unusual name, kept for fidelity):
hl.env("kvantum-dark", "qt6ct")

-- NVIDIA specific
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card2")
