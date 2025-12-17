#!/usr/bin/env bash
set -euo pipefail

# Rofi Clipboard Manager using cliphist

# Get clipboard history and show in rofi
cliphist list | \
    rofi -dmenu \
        -p "📋 Clipboard" \
        -theme ~/.config/rofi/clipboard.rasi \
        -i \
        -no-custom | \
    cliphist decode | \
    wl-copy
