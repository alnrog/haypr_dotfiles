#!/usr/bin/env bash
set -euo pipefail

# toggle: если wofi уже открыт — закрыть
if pgrep -x wofi >/dev/null 2>&1; then
  pkill -x wofi
  exit 0
fi

# top_left позволяет и xoffset, и yoffset (важно) :contentReference[oaicite:1]{index=1}
exec wofi --show drun --location top_left --xoffset 5 --yoffset 43

