-- Window rules (migrated from windowrule.conf)
-- See https://wiki.hypr.land/configuring/core/rules/window-rules/

hl.window_rule({
    name = "floating-decorations",
    match = { float = true },
    border_size = 2,
    border_color = "rgb(5a5a7a)",
    decorate = true,
})

hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Make applications float (tag first, rule consumes tag)
hl.window_rule({ match = { class = "blueman-manager" }, tag = "+pleasefloat" })
hl.window_rule({ match = { class = "nm-connection-editor" }, tag = "+pleasefloat" })
hl.window_rule({ match = { class = "org.fcitx.fcitx5-config-qt" }, tag = "+pleasefloat" })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, tag = "+pleasefloat" })
hl.window_rule({ match = { class = "app.drey.Warp" }, tag = "+pleasefloat" })
hl.window_rule({
    name = "please-float",
    match = { tag = "pleasefloat" },
    float = true,
    size = { 800, 600 },
    opacity = "0.9",
})

hl.window_rule({
    name = "calculator",
    match = { class = "org.gnome.Calculator" },
    float = true,
    center = true,
    keep_aspect_ratio = true,
})

hl.window_rule({
    name = "table_driver",
    match = { class = "OpenTabletDriver.UX" },
    float = true,
    size = { 1600, 900 },
    center = true,
    opacity = "0.9",
})

-- Media & image viewers
hl.window_rule({ match = { class = "mpv" }, tag = "+floating-media" })
hl.window_rule({ match = { class = "org.kde.gwenview" }, tag = "+floating-media" })
hl.window_rule({ match = { class = "org.gnome.Loupe" }, tag = "+floating-media" })
hl.window_rule({
    name = "floating-media",
    match = { tag = "floating-media" },
    float = true,
    center = true,
    size = { 1600, 900 },
    opaque = true,
    keep_aspect_ratio = true,
})

hl.window_rule({
    name = "vlc",
    match = { class = "vlc" },
    fullscreen_state = "3",
})

-- Make Firefox opaque when YouTube video is playing
hl.window_rule({ match = { title = ".*- YouTube —.*" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ match = { title = "Plex" }, opaque = true })

-- PIP support
hl.window_rule({ match = { title = ".*Picture in Picture.*" }, tag = "+popups" })
hl.window_rule({ match = { title = ".*Picture-in-Picture.*" }, tag = "+popups" })
hl.window_rule({ match = { initial_title = "Discord Popout" }, tag = "+popups" })
hl.window_rule({
    name = "PIP",
    match = { tag = "popups" },
    float = true,
    center = true,
    pin = true,
    opaque = true,
    keep_aspect_ratio = true,
    size = { 480, 270 },
})

-- Rules for system dialogues and pop-ups
hl.window_rule({ match = { title = ".*Properties" }, tag = "+dialogues" })
hl.window_rule({ match = { title = ".*Copying.*" }, tag = "+dialogues" })
hl.window_rule({ match = { title = ".*Upload.*" }, tag = "+dialogues" })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, tag = "+dialogues" })
hl.window_rule({ match = { class = "hyprland-share-picker" }, tag = "+dialogues" })
hl.window_rule({ match = { class = "setup.tmp" }, tag = "+dialogues" })
hl.window_rule({ match = { class = "quicksfv.exe" }, tag = "+dialogues" })
hl.window_rule({ match = { class = "dxwsetup.exe" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "Add Connection" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "New VM" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "Locate" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "Enter.*" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "File Management.*" }, tag = "+dialogues" })
hl.window_rule({ match = { title = ".*mp4.*" }, tag = "+dialogues" })
hl.window_rule({ match = { title = ".*to save.*" }, tag = "+dialogues" })
hl.window_rule({ match = { title = ".*File conflict.*" }, tag = "+dialogues" })
hl.window_rule({ match = { class = "hyprpolkitagent" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "Lutris settings" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "Add a new game" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "Remove torrent.*" }, tag = "+dialogues" })
hl.window_rule({ match = { title = "Open Torrent Files" }, tag = "+dialogues" })
hl.window_rule({
    name = "dialogues",
    match = { tag = "dialogues" },
    float = true,
    center = true,
    dim_around = true,
    border_size = 2,
    border_color = "rgb(5a5a7a)",
    size = { 800, 600 },
})

-- Game support
hl.window_rule({ match = { class = "steam_app.*" }, tag = "+games" })
hl.window_rule({ match = { class = "Stray" }, tag = "+games" })
hl.window_rule({ match = { class = "DARK SOULS" }, tag = "+games" })
hl.window_rule({ match = { class = "Red Dead Redemption" }, tag = "+games" })
hl.window_rule({
    name = "games",
    -- NOTE: old .conf had no match here (would apply globally); scoped to tag per intent.
    match = { tag = "games" },
    idle_inhibit = "always",
    fullscreen = true,
    allows_input = true,
    opaque = true,
    content = "game",
})

-- VM support
hl.window_rule({ match = { title = "on QEMU/KVM" }, opaque = true })
hl.window_rule({ match = { class = "looking-glass-client" }, fullscreen = true })

hl.window_rule({
    name = "password-prompt",
    match = { class = "gcr-prompter" },
    dim_around = true,
    stay_focused = true,
})
