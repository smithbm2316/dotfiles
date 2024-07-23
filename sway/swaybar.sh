#!/usr/bin/env sh

distro="$(sed -nE 's/^ID="?(.*)"?$/\1/p' /etc/os-release)"

date_and_time="$(date +'%c')"

battery_status="$(cat /sys/class/power_supply/BAT0/status)"
battery_percent="$(cat /sys/class/power_supply/BAT0/capacity)%"

volume="$(wpctl get-volume @DEFAULT_SINK@)"

echo "$distro | $volume | $battery_status - $battery_percent | $date_and_time"
