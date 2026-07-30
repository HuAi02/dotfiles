#!/bin/bash
# Hyprland Wallpaper Selector
# Usage: wallpaper-select.sh [--sort]
# Dependencies: rofi, imagemagick, notify-send, hyprpaper, jq

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
FIXED_JPG="$WALLPAPER_DIR/wallpaper.jpg"
LAST_SELECTED_FILE="$HOME/.cache/hyprland_last_wallpaper_path.txt"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
CACHE_DIR="$HOME/.cache/rofi_wallpapers"
ROFI_THEME="$HOME/.config/rofi/themes/wallpaper-select-theme.rasi"

# ── sort mode ───────────────────────────────────────────────────────────
if [[ "${1:-}" == "--sort" ]]; then
  mapfile -t images < <(
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
      \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \
      -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) \
      ! -iname "wallpaper.*" -printf '%f\n' | sort
  )

  count=${#images[@]}
  if [[ $count -eq 0 ]]; then
    echo "No image files found."
    exit 0
  fi

  width=1
  [[ $count -ge 10 ]] && width=2
  [[ $count -ge 100 ]] && width=3

  for i in "${!images[@]}"; do
    file="${images[$i]}"
    ext="${file##*.}"
    ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
    [[ "$ext_lower" == "jpeg" ]] && ext_lower="jpg"

    new_name="$(printf "%0${width}d" $((i + 1))).${ext_lower}"

    [[ "$file" == "$new_name" ]] && continue
    [[ -e "$WALLPAPER_DIR/$new_name" ]] && { echo "  Skip: '$new_name' exists"; continue; }

    mv -- "$WALLPAPER_DIR/$file" "$WALLPAPER_DIR/$new_name"
    echo "  '$file' -> '$new_name'"
  done

  rm -rf "$CACHE_DIR"
  echo "Done. Thumbnails cleared."
  exit 0
fi

# ── helpers ─────────────────────────────────────────────────────────────
get_focused_monitor_res() {
  hyprctl monitors -j | jq -r '.[] | select(.focused==true) | "\(.width) \(.height)"'
}

# returns "w h" for a file (single identify invocation)
get_img_dims() {
  identify -format '%w %h' "$1"
}

suggest_fit_mode() {
  read -r img_w img_h < <(get_img_dims "$1")
  if (( img_h > img_w )); then
    echo "tile-candidate"
  else
    echo "cover"
  fi
}

generate_tiled_wallpaper() {
  local src="$1" out="$2"
  read -r mon_w mon_h < <(get_focused_monitor_res)
  local resized="/tmp/_tile_resized_$$.png"
  convert "$src" -resize x"${mon_h}" "$resized"
  convert "$resized" -write mpr:TILE +delete -size "${mon_w}x${mon_h}" tile:mpr:TILE "$out"
  rm -f "$resized"
}

# ── preflight ───────────────────────────────────────────────────────────
mkdir -p "$WALLPAPER_DIR" "$CACHE_DIR" "$(dirname "$HYPRPAPER_CONF")"

# build file list once
mapfile -t files < <(
  find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    ! -iname "wallpaper.jpg" -printf '%f\n' | sort
)

# ── thumbnail helpers ───────────────────────────────────────────────────
needs_thumb() {
  local src="$1" dst="$2"
  [[ ! -f "$dst" ]] || [[ "$src" -nt "$dst" ]]
}

# fast placeholder: no strip, no extent, small output
make_placeholder() {
  local src="$1" dst="$2"
  convert "$src" -resize 300x170 "$dst" 2>/dev/null
}

# full quality for cache
make_thumb() {
  local src="$1" dst="$2"
  convert -strip "$src" -resize 600x340^ -gravity center -extent 600x340 "$dst" 2>/dev/null
}

run_parallel() {
  local fn="$1"; shift
  local max_jobs=$(nproc) running=0
  for name in "${files[@]}"; do
    local src="$WALLPAPER_DIR/$name" dst="$CACHE_DIR/$name"
    needs_thumb "$src" "$dst" || continue
    "$fn" "$src" "$dst" &
    (( ++running >= max_jobs )) && { wait -n; (( running-- )); }
  done
  wait
}

# ── pass 1: fast placeholders so rofi appears instantly ──────────────────
run_parallel make_placeholder

# ── rofi selector ───────────────────────────────────────────────────────
rofi_override='
window {
    background-color: rgba(0,0,0,0.8);
    width: 15%;
    height: 100%;
    location: west;
    anchor: west;
    border-radius: 0px;
    border: 0px;
}
mainbox {
    padding: 6% 0px 0% 0px;
}
listview {
    layout: vertical;
    lines: 100;
    columns: 1;
    scrollbar: false;
    spacing: 0px;
}
element {
    orientation: vertical;
    padding: 2px;
    border-radius: 8px;
}
element-icon {
    size: 230px;
    horizontal-align: 0.5;
    vertical-align: 0.5;
}
element-text {
    enabled: false;
}
'

selected=$(for name in "${files[@]}"; do
  echo -en "${name}\x00icon\x1f${CACHE_DIR}/${name}\n"
done | rofi -dmenu -theme "$ROFI_THEME" -theme-str "$rofi_override" -p "Wallpapers" -show-icons)

[[ -z "$selected" ]] && exit 0
selected_path="$WALLPAPER_DIR/$selected"

# ── apply wallpaper ─────────────────────────────────────────────────────
[[ -f "$FIXED_JPG" ]] && cp "$FIXED_JPG" "$FIXED_JPG.bak"

mode=$(suggest_fit_mode "$selected_path")
if [[ "$mode" == "tile-candidate" ]]; then
  tiled_path="$CACHE_DIR/tiled_$(basename "$selected_path").png"
  generate_tiled_wallpaper "$selected_path" "$tiled_path"
  convert "$tiled_path" "$FIXED_JPG"
  fit_mode="tile"
else
  convert "$selected_path" "$FIXED_JPG"
  fit_mode="cover"
fi

echo "$selected_path" > "$LAST_SELECTED_FILE"

cat > "$HYPRPAPER_CONF" <<EOF
wallpaper {
    monitor =
    path = $FIXED_JPG
    fit_mode = $fit_mode
}
splash = false
EOF

killall hyprpaper 2>/dev/null
hyprpaper &
notify-send "Wallpaper Changed" "$selected"

# ── pass 2: upgrade placeholders to full quality in background ───────────
run_parallel make_thumb &
disown
