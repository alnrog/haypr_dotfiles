#!/usr/bin/env bash
set -euo pipefail

state="$HOME/.cache/waybar_wifi_mode"
mkdir -p "$(dirname "$state")"

if [[ -f "$state" ]] && grep -qx "ssid" "$state"; then
  echo "icon" > "$state"
else
  echo "ssid" > "$state"
fi

pkill -x waybar
~/.config/hypr/scripts/waybar-launch.sh &
