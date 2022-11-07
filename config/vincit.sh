#!/bin/sh
# eDP-1 Gazelle Laptop + HDMI-1-1 AOC HDMI port monitor
# xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --rate 144.03 \
#  --output HDMI-1-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 144.00

# eDP-1 Gazelle Laptop + DP-1 AOC USB-C port monitor
# if the external monitor is connected
if [ "$(xrandr -q | grep -E '^DP-1 connected')" ]; then
  xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --rate 144.03 \
    --output DP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 120.00
# otherwise just use the internal monitor
else
  xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --rate 144.03 --primary \
    --output DP-1 --off
fi
