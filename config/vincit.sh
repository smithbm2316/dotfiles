#!/bin/sh
# eDP-1 Gazelle Laptop + DP-1 AOC USB-C port monitor

# if we supply an override value of "internal", use the internal monitor
if [ "$1" = "internal" ]; then
  xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144.03 \
    --output DP-1 --off
# if the external monitor is connected
elif xrandr -q | grep -qE '^DP-1 connected'; then
  # xrandr --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 120.00 \
  xrandr --output DP-1 --primary --mode 2560x1080 --pos 0x0 --rotate normal --rate 74.99 \
    --output eDP-1 --off
# otherwise just use the internal monitor
else
  xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144.03 \
    --output DP-1 --off
fi

# dual monitors
# xrandr --output DP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 120.00 \
#   --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --rate 144.03
