#!/usr/bin/env bash
set -euo pipefail

# Скрипт переключения раскладки клавиатуры
# Переключает между ru и us

# Получаем текущую раскладку
CURRENT_LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

# Переключаем
if [[ "$CURRENT_LAYOUT" == "Russian" ]]; then
    hyprctl switchxkblayout at-translated-set-2-keyboard 0  # EN
    notify-send "Keyboard" "English" --urgency=low --expire-time=1000
else
    hyprctl switchxkblayout at-translated-set-2-keyboard 1  # RU
    notify-send "Keyboard" "Русский" --urgency=low --expire-time=1000
fi
