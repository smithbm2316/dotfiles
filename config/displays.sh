#!/bin/sh
# could be DP-1 or DP-0, depends on your setup
# vertical right monitor
xrandr --output DisplayPort-1 --rate 144.00 --set TearFree on --primary --mode 1920x1080 --pos 0x410 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate right
# landscape right monitor
# xrandr --output DisplayPort-1 --rate 144.00 --set TearFree on --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate normal
# vertical stacked monitors setup
# xrandr --output DisplayPort-1 --rate 144.00 --set TearFree on --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal
