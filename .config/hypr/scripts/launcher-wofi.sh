#!/usr/bin/env bash
set -euo pipefail

# Wofi launcher with toggle behavior
# If wofi is already running, kill it

if pgrep -x wofi >/dev/null 2>&1; then
  pkill -x wofi
  exit 0
fi

exec wofi --show drun \
  --location center \
  --width 500 \
  --height 400 \
  --prompt "Search apps..."
