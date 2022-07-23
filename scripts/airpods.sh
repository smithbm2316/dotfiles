#!/usr/bin/env sh
airpods="E8:85:4B:4A:82:86"
connected=$(bluetoothctl info "$airpods" | grep Connected | cut -c 13-)
if [ "$connected" = "no" ]; then
  bluetoothctl unblock "$airpods"
  bluetoothctl connect "$airpods"
else
  bluetoothctl disconnect "$airpods"
  bluetoothctl block "$airpods"
fi
