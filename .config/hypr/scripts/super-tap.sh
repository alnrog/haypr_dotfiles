#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="$HOME/.cache/hypr"
PIDFILE="$STATE_DIR/super_tap.pid"
mkdir -p "$STATE_DIR"

# Если rofi уже открыт — закрываем (как toggle)
if pgrep -x rofi >/dev/null 2>&1; then
  pkill -x rofi
  exit 0
fi

# Убьём старый таймер, если остался
if [[ -f "$PIDFILE" ]]; then
  oldpid="$(cat "$PIDFILE" 2>/dev/null || true)"
  if [[ -n "${oldpid:-}" ]] && kill -0 "$oldpid" 2>/dev/null; then
    kill "$oldpid" 2>/dev/null || true
  fi
  rm -f "$PIDFILE"
fi

# Запускаем таймер: откроем меню, только если не было отмены
(
  sleep 0.18
  exec "$HOME/.config/hypr/scripts/launcher.sh"
) &
echo $! > "$PIDFILE"
