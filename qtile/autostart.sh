#!/bin/sh
# background processes, applets, and screen config
/home/smithbm/dotfiles/scripts/displays.sh &
picom -b &
dunst &
xset r rate 250 25 &
nm-applet &
blueman-applet &
pasystray &
flameshot &
keyd-application-mapper -d &
pactl load-module module-switch-on-connect &
nitrogen --restore &
# imwheel &
# systemctl --user enable --now darkman.service &

# apps to autostart
# flatpak run com.github.Eloston.UngoogledChromium &
kitty --title=dev &
google-chrome &
firefox &
slack &
# spotify &
/home/smithbm/appimages/obsidian.AppImage &

system76-power graphics power off
system76-power profile performance
