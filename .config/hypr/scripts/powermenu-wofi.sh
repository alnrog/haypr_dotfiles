#!/usr/bin/env bash
set -euo pipefail

# Power menu using wofi

choice="$(printf "⏻  Shutdown\n  Reboot\n  Lock\n󰗽  Logout\n  Suspend\n" | \
  wofi --dmenu \
    --prompt "Power" \
    --width 300 \
    --height 250 \
    --location center)"

case "$choice" in
  "⏻  Shutdown") systemctl poweroff ;;
  "  Reboot") systemctl reboot ;;
  "  Lock") "$HOME/.config/hypr/scripts/lock.sh" ;;
  "󰗽  Logout") hyprctl dispatch exit ;;
  "Suspend") systemctl suspend ;;
  *) exit 0 ;;
esac
