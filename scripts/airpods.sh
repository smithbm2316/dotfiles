#!/usr/bin/env sh
airpods="E8:85:4B:4A:82:86"
connected=$(bluetoothctl info "$airpods" | grep Connected | cut -c 13-)

if [ "$connected" = "no" ]; then
  notify-send "Attempting to unblock and connect to Airpods..."

  if bluetoothctl unblock "$airpods" && bluetoothctl connect "$airpods";
  then
    notify-send "Unblocked and connected successfully!"
  else
    notify-send "Something went wrong..."
  fi
else
  notify-send "Attempting to block and disconnect Airpods..."

  if bluetoothctl disconnect "$airpods" && bluetoothctl block "$airpods";
  then
    notify-send "Disconnected and blocked successfully!"
  else
    notify-send "Something went wrong..."
  fi
fi
