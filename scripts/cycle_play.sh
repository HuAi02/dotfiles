#!/bin/bash

STATE_FILE="/tmp/playerctl_cycle_state"
ORDER_FILE="/tmp/playerctl_cycle_order"
players=($(playerctl -l 2>/dev/null | sort))

if [ ${#players[@]} -eq 0 ]; then
    notify-send -u low -i media-playback-stop "Media Control" "No media players found."
    exit 1
fi

if [ -f "$STATE_FILE" ] && [ -f "$ORDER_FILE" ]; then
    current_index=$(<"$STATE_FILE")
    current_order=($(<"$ORDER_FILE"))
else
    current_index=-1
    current_order=()
fi

# If we don't have an order or we're starting fresh, create a new order
if [ ${#current_order[@]} -eq 0 ] || [ "$current_index" -eq -1 ]; then
    # Find the first playing player to determine cycle order
    first_player=""
    for p in "${players[@]}"; do
        status=$(playerctl -p "$p" status 2>/dev/null)
        if [ "$status" = "Playing" ]; then
            first_player="$p"
            break
        fi
    done

    # If no player is playing, pick the *second* player (if possible)
    if [ -z "$first_player" ]; then
        if [ "${#players[@]}" -ge 2 ]; then
            first_player="${players[1]}"
        else
            first_player="${players[0]}"
        fi
    fi


    # Create the order based on the first player
    current_order=("$first_player")
    for p in "${players[@]}"; do
        if [ "$p" != "$first_player" ]; then
            current_order+=("$p")
        fi
    done

    # Save the order
    printf "%s\n" "${current_order[@]}" > "$ORDER_FILE"

    # Set index to 0 so that next_index becomes 1 and second player is played
    echo "0" > "$STATE_FILE"
    current_index=-1
fi

# Pause all players
for p in "${players[@]}"; do
    playerctl -p "$p" pause 2>/dev/null
done

# Calculate next index
next_index=$((current_index + 1))

if [ "$next_index" -ge "${#current_order[@]}" ]; then
    echo "-1" > "$STATE_FILE"
    notify-send -u low -i media-playback-pause "Media Control" "All players paused."
    exit 0
fi

# Play next player in the current order
player="${current_order[$next_index]}"
echo "Attempting to play: $player" >> /tmp/playerctl_debug.log
playerctl -p "$player" status >> /tmp/playerctl_debug.log
playerctl -p "$player" metadata title >> /tmp/playerctl_debug.log

playerctl -p "$player" play 2>/dev/null
echo "$next_index" > "$STATE_FILE"

# Get metadata
title=$(playerctl -p "$player" metadata title 2>/dev/null)
artist=$(playerctl -p "$player" metadata artist 2>/dev/null)
album=$(playerctl -p "$player" metadata album 2>/dev/null)
art_url=$(playerctl -p "$player" metadata mpris:artUrl 2>/dev/null)

# Determine icon to show
if [[ "$art_url" == file://* ]]; then
    icon_path="${art_url#file://}"
elif [[ "$art_url" == http* ]]; then
    # Download the image to a temporary file if it's a URL
    icon_path="/tmp/player_art_$(basename "$art_url")"
    curl -s -o "$icon_path" "$art_url"
else
    icon_path="media-playback-start"  # Fallback icon
fi

# Notification
notify-send -u low -i "$icon_path" "Now Playing ($player)" "$title\n$artist\n$album"
