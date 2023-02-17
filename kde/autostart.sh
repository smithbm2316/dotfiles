#!/bin/sh
# background processes, applets, and screen config
xset r rate 250 25
pactl load-module module-switch-on-connect
imwheel &
flameshot &
keyd-application-mapper -d &
