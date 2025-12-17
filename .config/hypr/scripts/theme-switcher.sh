#!/usr/bin/env bash
set -euo pipefail

# Universal Theme Switcher
# Changes colors for: Hyprland, Waybar, SwayNC, Wofi, Rofi

THEMES_DIR="$HOME/.config/hypr/themes"
CURRENT_THEME_FILE="$HOME/.cache/current_theme"

# Available themes
THEMES=("nord" "catppuccin" "tokyonight" "gruvbox")

# Get current theme
if [ -f "$CURRENT_THEME_FILE" ]; then
    CURRENT_THEME=$(cat "$CURRENT_THEME_FILE")
else
    CURRENT_THEME="nord"
fi

# Parse argument
ACTION="${1:-menu}"

apply_theme() {
    local THEME=$1
    
    # Check if theme exists
    if [ ! -f "$THEMES_DIR/theme-$THEME.conf" ]; then
        notify-send "Theme Error" "Theme '$THEME' not found" --urgency=critical
        exit 1
    fi
    
    # 1. Hyprland colors
    ln -sf "$THEMES_DIR/theme-$THEME.conf" "$HOME/.config/hypr/theme.conf"
    
    # 2. Waybar colors
    if [ -f "$THEMES_DIR/waybar-$THEME.css" ]; then
        ln -sf "$THEMES_DIR/waybar-$THEME.css" "$HOME/.config/waybar/style.css"
    fi
    
    # 3. SwayNC colors (if exists)
    if [ -f "$THEMES_DIR/swaync-$THEME.css" ]; then
        ln -sf "$THEMES_DIR/swaync-$THEME.css" "$HOME/.config/swaync/style.css"
    fi
    
    # 4. Wofi colors (if exists)
    if [ -f "$THEMES_DIR/wofi-$THEME.css" ]; then
        ln -sf "$THEMES_DIR/wofi-$THEME.css" "$HOME/.config/wofi/style.css"
    fi
    
    # Save current theme
    echo "$THEME" > "$CURRENT_THEME_FILE"
    
    # Reload everything
    hyprctl reload
    pkill waybar && sleep 0.2 && waybar &
    pkill swaync && sleep 0.2 && swaync &
    
    notify-send "Theme Applied" "Switched to $THEME theme" \
        --urgency=low \
        --expire-time=2000
}

case "$ACTION" in
    menu)
        # Show rofi menu with current theme highlighted
        current_index=0
        for i in "${!THEMES[@]}"; do
            if [ "${THEMES[$i]}" = "$CURRENT_THEME" ]; then
                current_index=$i
                break
            fi
        done
        
        chosen=$(printf "%s\n" "${THEMES[@]}" | \
            rofi -dmenu \
                -p "Select Theme" \
                -theme ~/.config/rofi/launcher.rasi \
                -selected-row $current_index)
        
        if [ -n "$chosen" ]; then
            apply_theme "$chosen"
        fi
        ;;
    
    set)
        THEME="${2:-nord}"
        apply_theme "$THEME"
        ;;
    
    next)
        # Get current index
        current_index=0
        for i in "${!THEMES[@]}"; do
            if [ "${THEMES[$i]}" = "$CURRENT_THEME" ]; then
                current_index=$i
                break
            fi
        done
        
        # Get next theme
        next_index=$(( (current_index + 1) % ${#THEMES[@]} ))
        next_theme="${THEMES[$next_index]}"
        
        apply_theme "$next_theme"
        ;;
    
    *)
        echo "Usage: $0 [menu|set THEME|next]"
        echo "Available themes: ${THEMES[*]}"
        exit 1
        ;;
esac
