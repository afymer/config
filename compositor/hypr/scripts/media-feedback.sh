#!/usr/bin/env bash

set -euo pipefail

kind="${1:?missing kind}"
step="${2:?missing step}"

clamp_decimal() {
  awk -v value="$1" 'BEGIN {
    if (value < 0) value = 0
    if (value > 1) value = 1
    printf "%.3f", value
  }'
}

current_volume() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '/Volume:/ { print $2 }'
}

current_brightness() {
  local current max

  current="$(brightnessctl g)"
  max="$(brightnessctl m)"

  awk -v current="$current" -v max="$max" 'BEGIN {
    if (max <= 0) {
      print "0.000"
      exit
    }

    printf "%.3f", current / max
  }'
}

case "$kind" in
  volume)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$step"
    hyprosdctl --kind volume "$(clamp_decimal "$(current_volume)")"
    ;;
  brightness)
    brightnessctl s "$step"
    hyprosdctl --kind brightness "$(current_brightness)"
    ;;
  *)
    echo "usage: $0 <volume|brightness> <step>" >&2
    exit 1
    ;;
esac
