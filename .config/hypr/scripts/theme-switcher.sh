#!/usr/bin/env bash
set -euo pipefail

# Universal Theme Switcher
# Changes colors for: Hyprland, Waybar, Rofi, Hyprlock, SwayNC, SDDM

THEMES_DIR="$HOME/.config/hypr/themes"
CURRENT_THEME_FILE="$HOME/.cache/current_theme"
SDDM_THEME_FILE="/tmp/hyprland-current-theme"
SDDM_WALLPAPER="/tmp/hyprland-current-wallpaper.jpg"

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
    
    # 3. Hyprlock colors
    if [ -f "$THEMES_DIR/hyprlock-$THEME.conf" ]; then
        ln -sf "$THEMES_DIR/hyprlock-$THEME.conf" "$HOME/.config/hypr/hyprlock.conf"
    fi
    
    # 4. SwayNC colors
    if [ -f "$THEMES_DIR/swaync-$THEME.css" ]; then
        ln -sf "$THEMES_DIR/swaync-$THEME.css" "$HOME/.config/swaync/style.css"
    fi
    
    # 5. Rofi themes
    if [ -d "$HOME/.config/rofi/themes" ]; then
        # Launcher
        if [ -f "$HOME/.config/rofi/themes/launcher-$THEME.rasi" ]; then
            ln -sf "$HOME/.config/rofi/themes/launcher-$THEME.rasi" "$HOME/.config/rofi/launcher.rasi"
        fi
        
        # Powermenu
        if [ -f "$HOME/.config/rofi/themes/powermenu-$THEME.rasi" ]; then
            ln -sf "$HOME/.config/rofi/themes/powermenu-$THEME.rasi" "$HOME/.config/rofi/powermenu.rasi"
        fi
        
        # Calendar
        if [ -f "$HOME/.config/rofi/themes/calendar-$THEME.rasi" ]; then
            ln -sf "$HOME/.config/rofi/themes/calendar-$THEME.rasi" "$HOME/.config/rofi/calendar.rasi"
        fi
        
        # Clipboard
        if [ -f "$HOME/.config/rofi/themes/clipboard-$THEME.rasi" ]; then
            ln -sf "$HOME/.config/rofi/themes/clipboard-$THEME.rasi" "$HOME/.config/rofi/clipboard.rasi"
        fi
    fi
    
    # 6. Save theme for SDDM (world-readable) - with error handling
    if echo "$THEME" > "$SDDM_THEME_FILE" 2>/dev/null; then
        chmod 644 "$SDDM_THEME_FILE" 2>/dev/null || true
    fi
    
    # 7. Copy current wallpaper for SDDM - with error handling
    if [ -f "$HOME/.cache/current_wallpaper" ]; then
        WALLPAPER_PATH=$(cat "$HOME/.cache/current_wallpaper" 2>/dev/null || echo "")
        if [ -n "$WALLPAPER_PATH" ] && [ -f "$WALLPAPER_PATH" ]; then
            if cp "$WALLPAPER_PATH" "$SDDM_WALLPAPER" 2>/dev/null; then
                chmod 644 "$SDDM_WALLPAPER" 2>/dev/null || true
            fi
        fi
    fi
    
    # Save current theme
    echo "$THEME" > "$CURRENT_THEME_FILE"
    
    # Reload everything with error handling
    hyprctl reload 2>/dev/null || true
    
    # Restart waybar
    if pgrep -x waybar >/dev/null 2>&1; then
        pkill -x waybar
        sleep 0.2
    fi
    waybar &
    
    # Restart swaync
    if pgrep -x swaync >/dev/null 2>&1; then
        pkill -x swaync
        sleep 0.2
    fi
    swaync &
    
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
