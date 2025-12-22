#!/usr/bin/env bash
set -euo pipefail

# Load translations
source ~/.config/hypr/scripts/locale.sh

# Media player control with track info
ACTION="${1:-toggle}"

# Get player info
get_player_info() {
    ARTIST=$(playerctl metadata artist 2>/dev/null || echo "Unknown Artist")
    TITLE=$(playerctl metadata title 2>/dev/null || echo "Unknown Track")
    ALBUM=$(playerctl metadata album 2>/dev/null || echo "")
    STATUS=$(playerctl status 2>/dev/null || echo "Stopped")
    
    # Limit string lengths
    ARTIST=$(echo "$ARTIST" | cut -c1-30)
    TITLE=$(echo "$TITLE" | cut -c1-40)
    ALBUM=$(echo "$ALBUM" | cut -c1-30)
}

# Execute action
case "$ACTION" in
    toggle)
        playerctl play-pause
        ;;
    next)
        playerctl next
        ;;
    prev)
        playerctl previous
        ;;
    stop)
        playerctl stop
        ;;
esac

# Get updated info
get_player_info

# Icon based on status
if [ "$STATUS" = "Playing" ]; then
    ICON=""
    STATUS_TEXT="$(t "playing")"
elif [ "$STATUS" = "Paused" ]; then
    ICON=""
    STATUS_TEXT="$(t "paused")"
else
    ICON=""
    STATUS_TEXT="$(t "stopped")"
fi

# Format message
if [ -n "$ALBUM" ]; then
    MESSAGE="$ARTIST - $TITLE\n$ALBUM"
else
    MESSAGE="$ARTIST - $TITLE"
fi

# Send notification
notify-send "$ICON $STATUS_TEXT" "$MESSAGE" \
    --urgency=low \
    --expire-time=3000 \
    --hint=string:x-canonical-private-synchronous:media
