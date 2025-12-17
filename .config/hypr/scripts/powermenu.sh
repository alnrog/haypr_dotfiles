#!/usr/bin/env bash
set -euo pipefail

# Rofi Powermenu
# Beautiful power options menu

# Options with icons
#shutdown="⏻  Shutdown"
#reboot=" Reboot"
#lock=" Lock"
#suspend="󰤄 Suspend"
#logout="󰗽 Logout"
shutdown="⏻"
reboot=""
lock=""
suspend="󰤄"
logout="󰗽"

# Rofi prompt
chosen=$(echo -e "$lock\n$logout\n$suspend\n$reboot\n$shutdown" | \
    rofi -dmenu \
        -i \
        -p "Power Menu" \
        -theme ~/.config/rofi/powermenu.rasi \
        -selected-row 0)

# Execute action
case "$chosen" in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$lock")
        hyprlock
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
    *)
        exit 0
        ;;
esac
