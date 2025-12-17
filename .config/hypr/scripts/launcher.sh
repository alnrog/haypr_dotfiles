#!/usr/bin/env bash
set -euo pipefail

# Rofi launcher with toggle behavior

if pgrep -x rofi >/dev/null 2>&1; then
  pkill -x rofi
  exit 0
fi

rofi -show drun \
  -theme ~/.config/rofi/launcher.rasi \
  -show-icons \
  -drun-display-format "{name}" \
  -disable-history \
  -hide-scrollbar \
  -display-drun "Applications"
