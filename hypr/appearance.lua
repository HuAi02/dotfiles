-- Look and feel (migrated from appearance.conf)
-- See https://wiki.hypr.land/configuring/core/config-options/

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,

		col = {
			active_border = { colors = { "rgb(3a3a4a)", "rgb(5a5a7a)" }, angle = 45 },
			inactive_border = "rgb(000000)",
			nogroup_border = "rgb(ffffff)",
			nogroup_border_active = "rgb(ffffff)",
		},
		border_size = 1,

		resize_on_border = true,
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 3,

		active_opacity = 0.95,
		inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 2,
			color = "rgba(00000066)",
		},

		blur = {
			enabled = true,
			size = 5,
			passes = 3,
			ignore_opacity = true,
			popups = true,
		},
	},
})

-- Custom animations
-- NOTE: hl.animation() only accepts known tree leaves (no custom names).
-- Layer style overrides live in the layer_rule; speed/curve come from here.
-- 100ms (speed=1) snappy pop for layer surfaces (walker, notifications, waybar).
-- hl.animation({
-- 	leaf = "layersIn",
-- 	enabled = true,
-- 	speed = 1,
-- 	type = "bezier",
-- 	style = "popin 88%",
-- })
--
-- hl.animation({
-- 	leaf = "layersOut",
-- 	enabled = true,
-- 	speed = 1,
-- 	bezier = "smooth",
-- 	style = "fade",
-- })

-- Layer rules (were top-level `layerrule` lines)
-- See https://wiki.hypr.land/configuring/core/rules/layer-rules/
hl.layer_rule({ match = { namespace = "selection" }, blur = false })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, animation = "slide right" })
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, ignore_alpha = 0.2, animation = "slide down" })
hl.layer_rule({ match = { namespace = "rofi" }, blur = true, animation = "slide left", dim_around = true })
hl.layer_rule({ match = { namespace = "walker" }, blur = true, animation = "popin 88%", dim_around = true }) -- walker

hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("easeInOutSine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1.0 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "smooth", style = "slidevert" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "smooth", style = "slidevert" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "smooth", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "smooth", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "smooth", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "smooth", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 3, bezier = "smooth", style = "slidevert" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "smooth" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 20, bezier = "easeInOutSine", style = "loop" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "smooth", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "smooth", style = "fade" })

hl.config({
	dwindle = {
		force_split = 0,
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})
