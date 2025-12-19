#!/usr/bin/env bash
set -euo pipefail

# Wallpaper switcher for swww with state persistence
# Usage: 
#   ./wallpaper.sh random    - set random wallpaper
#   ./wallpaper.sh next      - next wallpaper
#   ./wallpaper.sh prev      - previous wallpaper
#   ./wallpaper.sh <path>    - set specific wallpaper

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_wallpaper"

# Transition effects
TRANSITION_TYPE="fade"  # wave, simple, fade, wipe, outer, random
TRANSITION_DURATION=2

# Create wallpaper directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"
mkdir -p "$(dirname "$CACHE_FILE")"

# Get list of wallpapers
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Wallpaper" "No wallpapers found in $WALLPAPER_DIR" --urgency=critical
    exit 1
fi

# Get current wallpaper index
get_current_index() {
    if [ -f "$CACHE_FILE" ]; then
        current=$(cat "$CACHE_FILE")
        for i in "${!WALLPAPERS[@]}"; do
            if [ "${WALLPAPERS[$i]}" = "$current" ]; then
                echo "$i"
                return
            fi
        done
    fi
    echo "0"
}

# Set wallpaper
set_wallpaper() {
    local wallpaper="$1"
    
    # Set wallpaper with swww
    swww img "$wallpaper" \
        --transition-type "$TRANSITION_TYPE" \
        --transition-duration "$TRANSITION_DURATION"
    
    # Save current wallpaper path
    echo "$wallpaper" > "$CACHE_FILE"
    
    # Copy for SDDM (with error handling)
    if [ -w /tmp ]; then
        cp "$wallpaper" /tmp/hyprland-current-wallpaper.jpg 2>/dev/null || true
        chmod 644 /tmp/hyprland-current-wallpaper.jpg 2>/dev/null || true
    fi
    
    local filename=$(basename "$wallpaper")
    notify-send "Wallpaper changed" "$filename" \
        --icon="$wallpaper" \
        --urgency=low \
        --expire-time=2000
}

case "${1:-random}" in
    random)
        # Random wallpaper
        random_index=$((RANDOM % ${#WALLPAPERS[@]}))
        set_wallpaper "${WALLPAPERS[$random_index]}"
        ;;
    
    next)
        # Next wallpaper
        current_index=$(get_current_index)
        next_index=$(( (current_index + 1) % ${#WALLPAPERS[@]} ))
        set_wallpaper "${WALLPAPERS[$next_index]}"
        ;;
    
    prev)
        # Previous wallpaper
        current_index=$(get_current_index)
        prev_index=$(( (current_index - 1 + ${#WALLPAPERS[@]}) % ${#WALLPAPERS[@]} ))
        set_wallpaper "${WALLPAPERS[$prev_index]}"
        ;;
    
    *)
        # Specific wallpaper path
        if [ -f "$1" ]; then
            set_wallpaper "$1"
        else
            echo "File not found: $1"
            exit 1
        fi
        ;;
esac
