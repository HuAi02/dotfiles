-- Keybinds (migrated from keybinds.conf)
-- See https://wiki.hypr.land/configuring/core/binds/
-- and https://wiki.hypr.land/configuring/core/dispatchers/
-- bind -> {}, bindl -> {locked=true}, binde -> {repeating=true},
-- bindel -> {locked=true, repeating=true}, bindm -> {mouse=true}

local SCRIPTS = os.getenv("HOME") .. "/dotfiles/scripts"

local terminal = "kitty"
local fileManager = "nemo"
local menu = "walker"
local browser = "zen-browser"
local private_browser = "zen-browser --private-window"
local music = "spotify"
local audioDevice = "pavucontrol"
local lock = "hyprlock"
-- kept for parity with old $vars (unused in binds below):
-- local discord = "vesktop"
-- local logout = "wlogout"

local mainMod = "SUPER"

-- Launch apps
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(SCRIPTS .. "/wlogout-singleton.sh"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(music))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(audioDevice))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(private_browser))
hl.bind("XF86Presentation", hl.dsp.exec_cmd(terminal .. " -e btop"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("missioncenter"))

-- Window actions
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- old: fullscreen,1 = maximized; fullscreen,0 = fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + K", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pin())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch / move workspaces with mainMod + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special workspace (scratchpad). Old config had two binds per key; combined to preserve order.
hl.bind(mainMod .. " + S", function()
	hl.dispatch(hl.dsp.workspace.toggle_special("magic"))
	-- hl.dispatch(hl.dsp.exec_cmd(SCRIPTS .. "/toggle_waybar.sh"))
end)
hl.bind(mainMod .. " + SHIFT + S", function()
	hl.dispatch(hl.dsp.exec_cmd(SCRIPTS .. "/toggle_waybar.sh"))
	hl.dispatch(hl.dsp.window.move({ workspace = "special:magic" }))
end)
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic", follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- Tab through existing workspaces with mainMod + tab, like Windows
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize windows with keyboard only
hl.bind(
	"CTRL + " .. mainMod .. " + right",
	hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
	{ repeating = true }
)
hl.bind(
	"CTRL + " .. mainMod .. " + left",
	hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
	{ repeating = true }
)
hl.bind(
	"CTRL + " .. mainMod .. " + up",
	hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
	{ repeating = true }
)
hl.bind(
	"CTRL + " .. mainMod .. " + down",
	hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
	{ repeating = true }
)

-- Media volume control
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd([[bash -c ' \
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; \
  VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk "{print int(\$2 * 100)}"); \
  ICON="audio-volume-medium"; \
  [ "$VOL" -lt 30 ] && ICON="audio-volume-low"; \
  [ "$VOL" -gt 60 ] && ICON="audio-volume-high"; \
  notify-send -u low -r 9993 -i "$ICON" "Volume Raised" "${VOL}%";']]),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd([[bash -c ' \
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; \
  VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk "{print int(\$2 * 100)}"); \
  ICON="audio-volume-medium"; \
  [ "$VOL" -lt 30 ] && ICON="audio-volume-low"; \
  [ "$VOL" -gt 60 ] && ICON="audio-volume-high"; \
  notify-send -u low -r 9993 -i "$ICON" "Volume Lowered" "${VOL}%";']]),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd([[bash -c ' \
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; \
  sleep 0.05; \
  OUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@); \
  if echo "$OUT" | grep -q "\[MUTED\]"; then \
    ICON="audio-volume-muted"; \
    TEXT="Muted"; \
  else \
    VOL=$(echo "$OUT" | awk "{print int(\$2 * 100)}"); \
    TEXT="${VOL}%"; \
    ICON="audio-volume-medium"; \
    [ "$VOL" -lt 30 ] && ICON="audio-volume-low"; \
    [ "$VOL" -gt 60 ] && ICON="audio-volume-high"; \
  fi; \
  notify-send -u low -r 9994 -i "$ICON" "Mute Toggled" "$TEXT";']]),
	{ locked = true, repeating = true }
)

-- Brightness control
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd([[bash -c ' \
  brightnessctl set +5%; \
  BRIGHT=$(brightnessctl get | awk -v max=$(brightnessctl max) "{printf \"%d\", (\$1 / max) * 100}"); \
  ICON="weather-clear"; \
  [ "$BRIGHT" -lt 20 ] && ICON="weather-clear-night"; \
  notify-send -u low -r 9995 -i "$ICON" "Brightness Increased" "${BRIGHT}%";']]),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd([[bash -c ' \
  brightnessctl set 5%-; \
  BRIGHT=$(brightnessctl get | awk -v max=$(brightnessctl max) "{printf \"%d\", (\$1 / max) * 100}"); \
  ICON="weather-clear"; \
  [ "$BRIGHT" -lt 20 ] && ICON="weather-clear-night"; \
  notify-send -u low -r 9995 -i "$ICON" "Brightness Decreased" "${BRIGHT}%";']]),
	{ locked = true, repeating = true }
)

-- External monitor brightness (DDC/CI via ddcutil)
hl.bind(
	"SHIFT + XF86MonBrightnessUp",
	hl.dsp.exec_cmd([[bash -c ' \
  exec 9>"$HOME/.cache/monitor-brightness.lock"; flock -n 9 || exit 0; \
  ddcutil setvcp 10 + 5 >/dev/null 2>&1; \
  BRIGHT=$(ddcutil getvcp 10 --brief 2>/dev/null | awk "{print \$4}"); \
  notify-send -u low -r 9997 -i "video-display" "External Brightness Increased" "${BRIGHT}%";']]),
	{ locked = true, repeating = true }
)
hl.bind(
	"SHIFT + XF86MonBrightnessDown",
	hl.dsp.exec_cmd([[bash -c ' \
  exec 9>"$HOME/.cache/monitor-brightness.lock"; flock -n 9 || exit 0; \
  ddcutil setvcp 10 - 5 >/dev/null 2>&1; \
  BRIGHT=$(ddcutil getvcp 10 --brief 2>/dev/null | awk "{print \$4}"); \
  notify-send -u low -r 9997 -i "video-display" "External Brightness Decreased" "${BRIGHT}%";']]),
	{ locked = true, repeating = true }
)

-- Microphone gain
hl.bind(
	"SHIFT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd([[bash -c ' \
  wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+; \
  VOL=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk "{print int(\$2 * 100)}"); \
  ICON="microphone-sensitivity-medium"; \
  [ "$VOL" -lt 30 ] && ICON="microphone-sensitivity-low"; \
  [ "$VOL" -gt 60 ] && ICON="microphone-sensitivity-high"; \
  notify-send -u low -r 9996 -i "$ICON" "Mic Gain Increased" "${VOL}%";']]),
	{ locked = true, repeating = true }
)
hl.bind(
	"SHIFT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd([[bash -c ' \
  wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-; \
  VOL=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk "{print int(\$2 * 100)}"); \
  ICON="microphone-sensitivity-medium"; \
  [ "$VOL" -lt 30 ] && ICON="microphone-sensitivity-low"; \
  [ "$VOL" -gt 60 ] && ICON="microphone-sensitivity-high"; \
  notify-send -u low -r 9996 -i "$ICON" "Mic Gain Decreased" "${VOL}%";']]),
	{ locked = true, repeating = true }
)
hl.bind(
	"SHIFT + XF86AudioMute",
	hl.dsp.exec_cmd([[bash -c ' \
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle; \
  IS_MUTED=$(wpctl get-mute @DEFAULT_AUDIO_SOURCE@ | awk "{print \$2}"); \
  ICON="microphone-sensitivity-muted"; \
  TEXT="Unmuted"; \
  [ "$IS_MUTED" = "true" ] && TEXT="Muted"; \
  notify-send -u low -r 9997 -i "$ICON" "Mic Mute Toggled" "$TEXT";']]),
	{ locked = true, repeating = true }
)

-- Clipboard history
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd([[cliphist list | walker --dmenu | cliphist decode | wl-copy]]))

-- Media player control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl --player=spotify,%any next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl --player=spotify,%any previous"))

-- Screenshot
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		[[grim -g "$(slurp)" - | tee ~/Pictures/$(date +'%Y%m%d_%Hh%Mm%Ss')_grim.png | wl-copy && notify-send -i camera "Screenshot copied to clipboard"]]
	)
)
hl.bind(
	"CTRL + Print",
	hl.dsp.exec_cmd([[grim - | wl-copy && notify-send -i camera "Full screenshot copied to clipboard"]])
)
hl.bind(
	"ALT + SHIFT + P",
	hl.dsp.exec_cmd(
		[[grim -t png - | tee /home/huai/Pictures/Screenshots/$(date +'%Y%m%d_%Hh%Mm%Ss')_grim.png | wl-copy --type image/png && notify-send -i camera "Full screenshot saved & copied"]]
	)
)
hl.bind(
	"ALT + P",
	hl.dsp.exec_cmd(
		[[grim -g "$(slurp)" -t png - | tee /home/huai/Pictures/Screenshots/$(date +'%Y%m%d_%Hh%Mm%Ss')_grim.png | wl-copy --type image/png && notify-send -i camera "Screenshot saved & copied"]]
	)
)

-- Toggle waybar
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(SCRIPTS .. "/toggle_waybar.sh"))

-- Open hyprland configs in neovim w/ tofi
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(SCRIPTS .. "/conf.sh"))

-- Change wallpaper
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd(SCRIPTS .. "/wallpaper-select.sh"))
-- Sort wallpapers (renames to sequential numbers)
hl.bind("CTRL + ALT + SHIFT + W", hl.dsp.exec_cmd(SCRIPTS .. "/wallpaper-select.sh --sort"))

-- Close lid event (were commented out in old config)
-- hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })
-- hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms off"), { locked = true })
-- hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"), { locked = true })
