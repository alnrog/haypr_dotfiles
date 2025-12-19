#!/usr/bin/env bash

# Получаем активный workspace
ACTIVE=$(hyprctl workspaces -j 2>/dev/null | jq -r '.[] | select(.focused == true) | .id // "1"' 2>/dev/null || echo "1")

# Маппинг class -> icon (включая Dolphin!)
icon() {
  case "$1" in
    kitty) echo "" ;;
    firefox) echo "" ;;
    code|code-url-handler) echo "󰨞" ;;
    org.telegram.desktop) echo "" ;;
    discord) echo "" ;;
    obsidian) echo "󱓧" ;;
    pavucontrol) echo "󰕾" ;;
    blueman-manager) echo "󰂯" ;;
    org.kde.dolphin) echo "" ;;  # <-- добавлено!
    *) echo "" ;;
  esac
}

# Получаем клиентов
CLIENTS_JSON=$(hyprctl clients -j 2>/dev/null)

# Проверка валидности JSON
if ! jq empty <<< "$CLIENTS_JSON" 2>/dev/null; then
  # Аварийный режим
  for ws in $(seq 1 9); do
    [[ "$ws" == "$ACTIVE" ]] && echo -n "<span class='active'>$ws</span> " || echo -n "<span class='inactive'>$ws</span> "
  done
  exit 0
fi

# Инициализация
declare -A WS_ICONS WS_IDS

# Безопасная обработка БЕЗ пайпа
while IFS= read -r line; do
  ws=$(cut -d':' -f1 <<< "$line")
  cls=$(cut -d':' -f2- <<< "$line")
  if [[ -n "$ws" && -n "$cls" ]]; then
    icn=$(icon "$cls")
    WS_ICONS[$ws]="${WS_ICONS[$ws]}${icn}"
    WS_IDS[$ws]=1
  fi
done < <(jq -r '.[] | select(.mapped == true and .class and (.class | type == "string")) | "\(.workspace.id):\(.class)"' <<< "$CLIENTS_JSON" 2>/dev/null)

# Формируем вывод
for ws in $(seq 1 9); do
  if [[ -n "${WS_IDS[$ws]}" ]]; then
    text="${WS_ICONS[$ws]}"
  else
    text="$ws"
  fi
  if [[ "$ws" == "$ACTIVE" ]]; then
    echo -n "<span class='active'>$text</span> "
  else
    echo -n "<span class='inactive'>$text</span> "
  fi
done
