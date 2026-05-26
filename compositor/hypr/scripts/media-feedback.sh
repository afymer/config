#!/usr/bin/env bash

set -euo pipefail

kind="${1:?missing kind}"
action="${2:?missing action}"

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

volume_muted() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]'
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

show_volume_osd() {
  local value

  value="$(clamp_decimal "$(current_volume)")"

  if volume_muted; then
    hyprosdctl --kind volume --muted "$value"
    return
  fi

  hyprosdctl --kind volume "$value"
}

case "$kind" in
  volume)
    if [[ "$action" == "mute-toggle" ]]; then
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      show_volume_osd
      exit 0
    fi

    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$action"
    show_volume_osd
    ;;
  brightness)
    brightnessctl s "$action"
    hyprosdctl --kind brightness "$(current_brightness)"
    ;;
  *)
    echo "usage: $0 <volume|brightness> <action>" >&2
    exit 1
    ;;
esac
