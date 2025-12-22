#!/usr/bin/env bash
set -euo pipefail

# Load translations
source ~/.config/hypr/scripts/locale.sh

# Screenshot script - select area and copy to clipboard
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

# Take screenshot of selected area
grim -g "$(slurp)" "$FILEPATH"

# Copy to clipboard
wl-copy < "$FILEPATH"

# Send notification with preview
notify-send "$(t "screenshot_captured")" "$(t "saved_to") $FILENAME" \
  --icon="$FILEPATH" \
  --urgency=low \
  --expire-time=3000
