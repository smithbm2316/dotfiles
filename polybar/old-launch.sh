#!/bin/bash
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bensbar &
  done
else
  polybar --reload example &
fi

echo "Polybar launched..."
