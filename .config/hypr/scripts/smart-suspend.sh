#!/usr/bin/env bash
set -euo pipefail

# Smart suspend - only on battery power

# Check if running on battery
if [ -d /sys/class/power_supply/BAT* ]; then
    # Has battery
    status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null || echo "Unknown")
    
    if [ "$status" = "Discharging" ]; then
        # On battery - suspend
        systemctl suspend
    fi
else
    # Desktop PC - no battery, don't suspend
    exit 0
fi
