#!/usr/bin/env bash
# Screenshot helper for grim/slurp, bound in hyprland.lua.
# Usage: screenshot.sh [region|window|full]
#
# Requires: grim, slurp, wl-clipboard, jq (for window mode), libnotify (notify-send)
set -euo pipefail

mode="${1:-region}"
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$mode" in
    region)
        geometry=$(slurp) || exit 0
        grim -g "$geometry" "$file"
        ;;
    window)
        geometry=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$geometry" "$file"
        ;;
    full)
        grim "$file"
        ;;
    *)
        echo "usage: screenshot.sh [region|window|full]" >&2
        exit 1
        ;;
esac

wl-copy < "$file"
notify-send "Screenshot saved" "$file"
