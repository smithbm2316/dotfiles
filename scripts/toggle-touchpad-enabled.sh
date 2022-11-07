#!/bin/sh
touchpad_name='PNP0C50:00 2808:0102 Touchpad'

if [ "$(xinput list-props "$touchpad_name" | grep 'Device Enabled' | sed -n 's/.*:.*\([0-9]\)/\1/p')" -eq 0 ]; then
  xinput enable "$touchpad_name"
  notify-send --icon=/usr/share/icons/Papirus-Dark/16x16/actions/checkmark.svg "Enabled" "Your computer's touchpad is enabled."
else
  xinput disable "$touchpad_name"
  notify-send --icon=/usr/share/icons/Papirus-Dark/16x16/actions/cancel.svg "Disabled" "Your computer's touchpad is disabled."
fi
