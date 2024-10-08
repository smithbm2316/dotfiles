#!/usr/bin/env sh

device_id=""
device_name=""
if [ "$1" = "beats-flex" ]; then
  device_id="0C:53:B7:B7:C9:30"
  device_name="Beats Flex"
elif [ "$1" = "airpods" ]; then
  device_id="E8:85:4B:4A:82:86"
  device_name="Airpods"
fi

if [ "$2" = "connection" ]; then
  blocked=$(bluetoothctl info "$device_id" | grep Blocked | tr -s ' ' | cut -d ' ' -f 2)

  if [ "$blocked" = "yes" ]; then
    notify-send "Attempting to unblock and connect to $device_name..."

    if bluetoothctl unblock "$device_id" && bluetoothctl connect "$device_id";
    then
      notify-send "Unblocked and connected successfully!"
    else
      notify-send "Something went wrong..."
    fi
  else
    notify-send "Attempting to block and disconnect $device_name..."

    if bluetoothctl disconnect "$device_id" && bluetoothctl block "$device_id";
    then
      notify-send "Disconnected and blocked successfully!"
    else
      notify-send "Something went wrong..."
    fi
  fi
elif [ "$2" = "codec" ]; then
  bluetooth_card_id=$(pactl list cards short | grep bluez | awk '{ print $1 }')

  if pactl list cards | grep 'Active Profile' | grep headset-head-unit; then
    pactl set-card-profile "$bluetooth_card_id" a2dp-sink
    notify-send "Disabled $device_name mic, enabled high fidelity playback"
  elif pactl list cards | grep 'Active Profile' | grep aac; then
    pactl set-card-profile "$bluetooth_card_id" headset-head-unit
    notify-send "Enabled $device_name mic, set $device_name to headset mode"
  else
    notify-send "Something went wrong toggling the $device_name mic..."
  fi
fi
