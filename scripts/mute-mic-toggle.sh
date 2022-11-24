#!/bin/sh
mic=$(pactl get-default-source)
mute_state=$(pactl get-source-mute "$mic")
if [ "$mute_state" = "Mute: yes" ]; then
  notify-send 'Unmuted mic'
else
  notify-send 'Muted mic'
fi
pactl set-source-mute "$mic" toggle
