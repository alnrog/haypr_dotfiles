#!/usr/bin/env bash
set -euo pipefail

THEME="$HOME/.config/rofi/arch-launcher.rasi"

choice="$(printf "⏻  Shutdown\n  Reboot\n  Lock\n󰗽  Logout\n" | \
  wofi --dmenu \
    --promt "Power" \
    --location top_right \
    --xoffset -5 \
    --yoffset 43)"

case "$choice" in
  "⏻  Shutdown") systemctl poweroff ;;
  "  Reboot") systemctl reboot ;;
  "  Lock") "$HOME/.config/hypr/scripts/lock.sh" ;;
  "󰗽  Logout") hyprctl dispatch exit ;;
  *) exit 0 ;;
esac
