#!/usr/bin/env sh
airpods="E8:85:4B:4A:82:86"

if [ "$1" = "connection" ]; then
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
elif [ "$1" = "codec" ]; then
  bluetooth_card_id=$(pactl list cards short | grep bluez | awk '{ print $1 }')

  if pactl list cards | grep 'Active Profile' | grep headset-head-unit; then
    pactl set-card-profile "$bluetooth_card_id" a2dp-sink
    notify-send "Disabled airpods mic, enabled high fidelity playback"
  elif pactl list cards | grep 'Active Profile' | grep aac; then
    pactl set-card-profile "$bluetooth_card_id" headset-head-unit
    notify-send "Enabled airpods mic, set airpods to headset mode"
  else
    notify-send "Something went wrong toggling the airpods mic..."
  fi
fi
