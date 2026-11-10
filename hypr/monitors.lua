-- Monitors (migrated from main.conf)
-- See https://wiki.hypr.land/configuring/core/monitors/

-- Both
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@144",
    position = "1920x0",
    scale = 1,
})
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@200",
    position = "0x0",
    scale = 1,
})

-- Laptop monitor only
-- hl.monitor({ output = "HDMI-A-1", disabled = true })
-- hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1.33 })

-- External monitor only
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@200", position = "0x0", scale = 1 })
-- hl.monitor({ output = "eDP-1", disabled = true })

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
