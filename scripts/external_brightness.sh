#!/usr/bin/env bash
# External monitor brightness via DDC/CI (ddcutil)
# Usage: external_brightness.sh [get|up|down|set VALUE]

case "${1:-get}" in
get)
  v=$(ddcutil getvcp 10 --brief 2>/dev/null)
  if [ -n "$v" ]; then
    pct=$(echo "$v" | awk '{print $4}')
    icons=("󰃞" "󰃟" "󰃝" "󰃠")
    idx=$((pct * 4 / 100))
    [ "$idx" -gt 3 ] && idx=3
    icon=${icons[$idx]}
    printf '{"text":"%s\\n%02d%%","tooltip":"External Brightness: %02d%%"}' "$icon" "$pct" "$pct"
  else
    printf '{"text":""}'
  fi
  ;;
up) ddcutil setvcp 10 + 5 >/dev/null 2>&1 ;;
down) ddcutil setvcp 10 - 5 >/dev/null 2>&1 ;;
set) ddcutil setvcp 10 "$2" >/dev/null 2>&1 ;;
esac
