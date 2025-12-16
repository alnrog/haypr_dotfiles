#!/usr/bin/env bash
set -euo pipefail

# Area screenshot -> clipboard
grim -g "$(slurp)" - | wl-copy
notify-send "Screenshot" "Copied selection to clipboard"
