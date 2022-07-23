#!/bin/sh

temp=$(curl -s 'https://wttr.in/94521?format=%t' | grep -o -E '[0-9]+')
if [ "$temp" -ge 76 ]; then
  notify-send "Time to close the windows, it's $temp°F out!"
fi
