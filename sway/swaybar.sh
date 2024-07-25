#!/usr/bin/env sh

distro="$(sed -nE 's/^ID="?(.*)"?$/\1/p' /etc/os-release)"
volume=""
battery_status=""
battery_percent=""
date_and_time=""
cpu_usage=""
memory_usage=""
while true; do
  i=0
  while [ $i -lt 120 ]; do
    sleep 0.5
    even=$(( $i % 2 == 0 ))

    if [ $even -eq 0 ] || [ $i -eq 0 ]; then
      date_and_time="$(date +'%c')"
    fi
    if [ $i -eq 0 ]; then
      battery_status="$(cat /sys/class/power_supply/BAT0/status)"
      battery_percent="$(cat /sys/class/power_supply/BAT0/capacity)%"
    fi

    cpu_usage="cpu: $(mpstat | tail -n 1 | tr -s ' ' '+' | cut -d '+' -f 4-12 | bc)"
    memory_usage="mem: $(free -h | sed -n 2p | awk '{ print $3 }')"
    volume="$(wpctl get-volume @DEFAULT_SINK@)"
    echo "$distro | $volume | $cpu_usage | $memory_usage | $battery_status - $battery_percent | $date_and_time"
    i=$((i + 1))
  done
done
