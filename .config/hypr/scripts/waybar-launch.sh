#!/usr/bin/env bash
set -euo pipefail

mode_file="$HOME/.cache/waybar_wifi_mode"
mode="icon"
[[ -f "$mode_file" ]] && mode="$(cat "$mode_file")"

cfg="$HOME/.config/waybar/config"
tmp="$HOME/.cache/waybar_config.json"

mkdir -p "$(dirname "$tmp")"

if [[ "$mode" == "ssid" ]]; then
  # Подставляем формат с SSID
  sed 's/"format-wifi": "{icon}"/"format-wifi": "{icon} {essid}"/' "$cfg" > "$tmp"
else
  cp "$cfg" "$tmp"
fi

exec waybar -c "$tmp"
