#!/bin/sh
# script that will toggle the touchpad's scrolling direction between natural and the correct
# direction

touchpad_id=$(xinput list | grep -i 'touchpad' | sed -n 's/.*id=\([0-9]\+\).*/\1/p')
temp=$(xinput list-props "$touchpad_id" | sed -n 's/.*natural scrolling enabled (\([0-9]\+\)):.*\([0-9]\+\).*/\1 \2/pi')
libinput_event_id=$(echo "$temp" | awk '{ print $1 }')
natural_scrolling_enabled=$(echo "$temp" | awk '{ print $2 }')
if [ "$natural_scrolling_enabled" -eq '0' ]; then
  xinput set-prop "$touchpad_id" "$libinput_event_id" 1
  notify-send "Touchpad Scrolling" "set correct scrolling"
else
  xinput set-prop "$touchpad_id" "$libinput_event_id" 0
  notify-send "Touchpad Scrolling" "set natural scrolling"
fi
