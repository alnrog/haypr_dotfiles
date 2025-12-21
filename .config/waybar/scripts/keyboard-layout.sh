#!/usr/bin/env bash
set -euo pipefail

# Waybar keyboard layout indicator - polling mode
# Обновляется каждую секунду

get_layout() {
    LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' 2>/dev/null || echo "English")
    
    if [[ "$LAYOUT" =~ "Russian" ]]; then
        echo "ru"
    else
        echo "en"
    fi
}

print_output() {
    local LAYOUT=$(get_layout)
    local CLASS=""
    local TOOLTIP=""
    
    if [ "$LAYOUT" = "ru" ]; then
        CLASS="russian"
        TOOLTIP="Русская раскладка"
    else
        CLASS="english"
        TOOLTIP="English layout"
    fi
    
    echo "{\"text\":\"$LAYOUT\",\"class\":\"$CLASS\",\"tooltip\":\"$TOOLTIP\"}"
}

# Polling режим - обновление каждую секунду
while true; do
    print_output
    sleep 1
done
