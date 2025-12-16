#!/usr/bin/env bash
set -euo pipefail

PIDFILE="$HOME/.cache/hypr/super_tap.pid"

if [[ -f "$PIDFILE" ]]; then
  pid="$(cat "$PIDFILE" 2>/dev/null || true)"
  if [[ -n "${pid:-}" ]] && kill -0 "$pid" 2>/dev/null; then
    kill "$pid" 2>/dev/null || true
  fi
  rm -f "$PIDFILE"
fi
