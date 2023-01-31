#!/bin/sh
# background processes, applets, and screen config
/home/smithbm/dotfiles/scripts/displays.sh &
picom -b &
dunst &
xset r rate 250 25 &
nm-applet &
blueman-applet &
imwheel &
pasystray &
flameshot &
keyd-application-mapper -d &
pactl load-module module-switch-on-connect &
nitrogen --restore &
# systemctl --user enable --now darkman.service &

# apps to autostart
flatpak run com.github.Eloston.UngoogledChromium &
kitty --title=dev &
1password &
firefox &
slack &
spotify &
