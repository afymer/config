#!/bin/bash

BATTERY=$(upower -e | grep 'BAT')
PERCENTAGE=$(upower -i "$BATTERY" | grep --color=never 'percentage' | awk '{print $2}' | tr -d '%')
STATE=$(upower -i "$BATTERY" | grep --color=never 'state' | awk '{print $2}')

THRESHOLD_WARN=20
THRESHOLD_ERR=10

if [[ "$STATE" == "discharging" && "$PERCENTAGE" -le "$THRESHOLD_ERR" ]]; then
    hyprctl --instance 0 notify 3 5000 0 "batterie (${PERCENTAGE}%)"
elif [[ "$STATE" == "discharging" && "$PERCENTAGE" -le "$THRESHOLD_WARN" ]]; then
    hyprctl --instance 0 notify 0 5000 0 "batterie (${PERCENTAGE}%)"
fi

