#!/usr/bin/env bash
set -euo pipefail

# Если rofi уже открыт — закрываем и выходим
if pgrep -x rofi >/dev/null 2>&1; then
  pkill -x rofi
  exit 0
fi

# Проверяем, какие клавиши сейчас зажаты.
# Открываем меню ТОЛЬКО если НЕ зажаты другие клавиши (кроме SUPER).
keys_json="$(hyprctl -j devices)"
pressed="$(echo "$keys_json" | jq -r '.keyboards[]? | .active_keymap? // empty' >/dev/null 2>&1 || true)"

# Более надёжно: проверим именно "pressed keys" через "hyprctl -j devices" (если есть)
pressed_keys="$(echo "$keys_json" | jq -r '
  [.keyboards[]? | (.pressed_keys // [])[]] | length
' 2>/dev/null || echo 0)"

# Если были нажаты какие-то клавиши вместе с Super — не открываем меню
# (в момент отпускания Super pressed_keys обычно 0, но при комбинациях может быть >0)
if [[ "${pressed_keys:-0}" != "0" ]]; then
  exit 0
fi

exec "$HOME/.config/hypr/scripts/launcher.sh"
