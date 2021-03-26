#!/bin/bash

killall dunst

BAT_C=$(cat /sys/class/power_supply/BAT0/capacity)
BAT_S=$(cat /sys/class/power_supply/BAT0/status)
DATE=$(date "+%a %b %d")
TIME=$(date "+%I:%M %p")
case "$BAT_S" in
  Charging)
    BAT_S="+"
    ;;
  Discharging)
    BAT_S="-"
    ;;
  Full|*)
    BAT_S=""
    ;;
esac

notify-send -t 3000 "$TIME" "$DATE\n$BAT_C$BAT_S"
