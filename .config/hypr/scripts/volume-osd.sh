#!/usr/bin/env bash
set -euo pipefail

# Load translations
source ~/.config/hypr/scripts/locale.sh

# Volume OSD with visual notification
ACTION="${1:-up}"

case "$ACTION" in
    up)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 10%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

# Get current volume and mute status
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED" && echo "yes" || echo "no")

# Icon based on volume level
if [ "$MUTED" = "yes" ]; then
    ICON="󰖁"
    TEXT="$(t "muted")"
else
    if [ "$VOLUME" -ge 70 ]; then
        ICON="󰕾"
    elif [ "$VOLUME" -ge 30 ]; then
        ICON="󰖀"
    else
        ICON="󰕿"
    fi
    TEXT="$(t "volume"): ${VOLUME}%"
fi

# Create progress bar
BAR_LENGTH=20
FILLED=$((VOLUME * BAR_LENGTH / 100))
EMPTY=$((BAR_LENGTH - FILLED))
BAR=$(printf '█%.0s' $(seq 1 $FILLED))$(printf '░%.0s' $(seq 1 $EMPTY))

# Send notification
notify-send "$ICON $TEXT" "$BAR" \
    --urgency=low \
    --expire-time=2000 \
    --hint=string:x-canonical-private-synchronous:volume
