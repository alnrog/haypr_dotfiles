#!/usr/bin/env bash
set -euo pipefail

# Brightness OSD with visual notification
# Shows brightness level with progress bar

ACTION="${1:-up}"  # up, down

case "$ACTION" in
    up)
        brightnessctl set +10%
        ;;
    down)
        brightnessctl set 10%-
        ;;
esac

# Get current brightness
BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PERCENT=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Icon
ICON="󰃠"

# Create progress bar
BAR_LENGTH=20
FILLED=$((PERCENT * BAR_LENGTH / 100))
EMPTY=$((BAR_LENGTH - FILLED))
BAR=$(printf '█%.0s' $(seq 1 $FILLED))$(printf '░%.0s' $(seq 1 $EMPTY))

# Send notification
notify-send "$ICON Яркость: ${PERCENT}%" "$BAR" \
    --urgency=low \
    --expire-time=2000 \
    --hint=string:x-canonical-private-synchronous:brightness
