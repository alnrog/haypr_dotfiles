#!/usr/bin/env bash
set -euo pipefail

# SwayNC launcher with theme check
# Ensures SwayNC uses the correct theme on startup

THEMES_DIR="$HOME/.config/hypr/themes"
SWAYNC_STYLE="$HOME/.config/swaync/style.css"
CURRENT_THEME_FILE="$HOME/.cache/current_theme"

# Get current theme
if [ -f "$CURRENT_THEME_FILE" ]; then
    CURRENT_THEME=$(cat "$CURRENT_THEME_FILE")
else
    CURRENT_THEME="nord"
fi

# Ensure symlink exists and points to correct theme
THEME_FILE="$THEMES_DIR/swaync-$CURRENT_THEME.css"

if [ -f "$THEME_FILE" ]; then
    # Remove old symlink if exists
    [ -L "$SWAYNC_STYLE" ] && rm "$SWAYNC_STYLE"
    [ -f "$SWAYNC_STYLE" ] && mv "$SWAYNC_STYLE" "$SWAYNC_STYLE.backup"
    
    # Create new symlink
    ln -sf "$THEME_FILE" "$SWAYNC_STYLE"
fi

# Kill existing swaync if running
if pgrep -x swaync >/dev/null 2>&1; then
    pkill -x swaync
    sleep 0.3
fi

# Start swaync
exec swaync
