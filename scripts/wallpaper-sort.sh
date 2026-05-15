#!/bin/bash

# Directory to process - change this to your target directory
TARGET_DIR="/home/huai/Pictures/Wallpapers/"

cd "$TARGET_DIR" || {
  echo "Error: Cannot cd into '$TARGET_DIR'"
  exit 1
}

# Collect image files, excluding wallpaper.jpg
mapfile -t images < <(
  find . -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \
    -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) \
    ! -iname "wallpaper.*" |
    sed 's|^\./||' | sort
)

count=${#images[@]}

if [[ $count -eq 0 ]]; then
  echo "No image files found (excluding current wallpaper)"
  exit 0
fi

echo "Found $count image(s) to rename in '$TARGET_DIR'."

# Determine zero-padding width
if [[ $count -ge 100 ]]; then
  width=3
elif [[ $count -ge 10 ]]; then
  width=2
else
  width=1
fi

# Rename each file
for i in "${!images[@]}"; do
  file="${images[$i]}"
  ext="${file##*.}"
  ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
  # Normalise jpeg -> jpg
  [[ "$ext_lower" == "jpeg" ]] && ext_lower="jpg"

  num=$(printf "%0${width}d" $((i + 1)))
  new_name="${num}.${ext_lower}"

  if [[ "$file" == "$new_name" ]]; then
    echo "  Skipping '$file' (already correctly named)"
    continue
  fi

  # Avoid clobbering an existing file
  if [[ -e "$new_name" ]]; then
    echo "  Warning: '$new_name' already exists — skipping '$file'"
    continue
  fi

  mv -- "$file" "$new_name"
  echo "  '$file'  →  '$new_name'"
done

echo "Done."
