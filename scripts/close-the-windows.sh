#!/usr/bin/env sh

statedir="$XDG_STATE_HOME/close-the-windows"
statefile="$statedir/state.txt"
if [ ! -f "$statefile" ]; then
  mkdir -p "$statedir"
  touch "$statefile"
fi

if [ ! -z $statefile ]; then
  exit 0
fi

temp="$(curl -s 'https://wttr.in/94521?format=%t' | grep -oE '[0-9]+')"
if [ "$temp" -ge 75 ]; then
  notify-send "Time to close the windows, it's $temp°F out!"
  echo 'true' > "$statefile"
fi
