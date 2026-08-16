#!/usr/bin/env bash
# Prints mic mute state for Waybar's custom/mic module.
# Refreshed on an interval and on-demand via `pkill -RTMIN+10 waybar`
# (see the mic-mute keybind in hyprland.lua).

status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)

if [[ "$status" == *MUTED* ]]; then
    echo "MIC muted"
else
    echo "MIC live"
fi
