#!/usr/bin/env bash
set -euo pipefail

# принудительно rofi, без вопросов
exec networkmanager_dmenu -r
