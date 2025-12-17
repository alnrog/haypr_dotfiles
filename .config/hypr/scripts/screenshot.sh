#!/usr/bin/env bash
set -euo pipefail

# Screenshot script - select area and copy to clipboard
# Also saves to ~/Pictures/Screenshots/

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

# Take screenshot of selected area
grim -g "$(slurp)" "$FILEPATH"

# Copy to clipboard
wl-copy < "$FILEPATH"

# Send notification with preview
notify-send "Screenshot captured" "Saved to $FILENAME" \
  --icon="$FILEPATH" \
  --urgency=low \
  --expire-time=3000
