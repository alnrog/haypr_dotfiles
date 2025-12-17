#!/usr/bin/env bash
set -euo pipefail

# Initialize swww daemon and set wallpaper

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
DEFAULT_WALLPAPER="$WALLPAPER_DIR/default.jpg"

# Kill existing swww daemon if running
pkill -x swww-daemon 2>/dev/null || true
sleep 0.5

# Start swww daemon
swww-daemon &
sleep 1

# Set wallpaper
if [ -f "$DEFAULT_WALLPAPER" ]; then
    swww img "$DEFAULT_WALLPAPER" \
        --transition-type fade \
        --transition-duration 2
else
    # If no default wallpaper, set a solid color
    swww img <(convert -size 1920x1080 xc:"#1e1e2e" png:-) \
        --transition-type fade \
        --transition-duration 1
fi
