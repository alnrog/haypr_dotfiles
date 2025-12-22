#!/usr/bin/env bash
set -euo pipefail

# Load translations
source ~/.config/hypr/scripts/locale.sh

# Rofi Calendar - Three Button Navigation

CACHE_DIR="$HOME/.cache/rofi-calendar"
MONTH_FILE="$CACHE_DIR/current_month"

mkdir -p "$CACHE_DIR"

# Parse arguments
ACTION="${1:-show}"

# Get current month offset
if [ -f "$MONTH_FILE" ]; then
    MONTH_OFFSET=$(cat "$MONTH_FILE")
else
    MONTH_OFFSET=0
fi

# Handle actions
case "$ACTION" in
    prev)
        echo $((MONTH_OFFSET - 1)) > "$MONTH_FILE"
        exec "$0" show
        ;;
    next)
        echo $((MONTH_OFFSET + 1)) > "$MONTH_FILE"
        exec "$0" show
        ;;
    today)
        echo 0 > "$MONTH_FILE"
        exec "$0" show
        ;;
    show)
        # Continue to show calendar
        ;;
    *)
        exit 0
        ;;
esac

# Calculate target date
if [ "$MONTH_OFFSET" -eq 0 ]; then
    TARGET_DATE=$(date +%Y-%m-01)
else
    TARGET_DATE=$(date -d "$(date +%Y-%m-01) $MONTH_OFFSET months" +%Y-%m-01)
fi

MONTH_NAME=$(date -d "$TARGET_DATE" +"%B %Y")
CURRENT_DATE=$(date +%Y-%m-%d)

# Generate calendar
{
    echo "📅 $MONTH_NAME"
    echo ""
    
    # Get calendar for the month
    cal_output=$(cal -m $(date -d "$TARGET_DATE" +%m) $(date -d "$TARGET_DATE" +%Y) | tail -n +2)
    
    # If current month, highlight today
    if [ "$MONTH_OFFSET" -eq 0 ]; then
        current_day=$(date +%-d)
        echo "$cal_output" | sed "s/\b$current_day\b/[$current_day]/"
    else
        echo "$cal_output"
    fi
    
    # Navigation buttons (localized)
    echo "◀  $(t "previous")"
    echo "   $(t "today")"
    echo "▶  $(t "next")"
    
} | rofi -dmenu \
    -p " " \
    -theme ~/.config/rofi/calendar.rasi \
    -no-custom \
    -selected-row 0 \
    -format 's' | {
    
    read -r result
    
    case "$result" in
        *"$(t "previous")"*)
            exec "$0" prev
            ;;
        *"$(t "next")"*)
            exec "$0" next
            ;;
        *"$(t "today")"*)
            exec "$0" today
            ;;
        *)
            echo 0 > "$MONTH_FILE"
            exit 0
            ;;
    esac
}
