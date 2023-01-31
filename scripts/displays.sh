#!/bin/sh

# sys76_internal="AUO-38799"
# aoc_desktop="AOC-9218"

raw_edid_data=$(xrandr --prop |\
  grep -A 8 EDID |\
  xargs |\
  sed -nr 's/\s*EDID: ([ A-Za-z0-9]+)-*/\1\n/gp')

echo "$raw_edid_data" | while IFS= read -r raw_monitor_data
do
  decoded_monitor_data=$(echo "$raw_monitor_data" | edid-decode)
  manufacturer=$(echo "$decoded_monitor_data" | grep Manufacturer | sed -nr 's/^.*Manufacturer: ([A-Za-z0-9]+).*$/\1/p')
  model=$(echo "$decoded_monitor_data" | grep Model | sed -nr 's/^.*Model: ([A-Za-z0-9]+).*$/\1/p')

  # main AOC desktop monitor: AOC 9218
  if [ "$manufacturer" = "AOC" ] && [ "$model" = "9218" ]; then
    # set a custom error code so we can utilize it below outside of this subshell
    exit 20
  fi
done

if [ $? -eq 20 ]; then
  autorandr --load desktop 2>/dev/null
else
  xrandr --auto
fi
