#!/usr/bin/env bash

# Load translations
source ~/.config/hypr/scripts/locale.sh

# Keyboard layout indicator for Waybar
# Polling mode - updates every second

while true; do
    # Get current layout
    LAYOUT=$(hyprctl devices -j 2>/dev/null | jq -r '.keyboards[] | select(.main == true) | .active_keymap' 2>/dev/null || echo "English")
    
    # Determine layout and class
    if [[ "$LAYOUT" =~ [Rr]ussian ]]; then
        TEXT="ru"
        CLASS="russian"
        TOOLTIP="$(t "russian_layout")"
    else
        TEXT="en"
        CLASS="english"
        TOOLTIP="$(t "english_layout")"
    fi
    
    # Output JSON for Waybar
    echo "{\"text\":\"$TEXT\",\"class\":\"$CLASS\",\"tooltip\":\"$TOOLTIP\"}"
    
    sleep 1
done
