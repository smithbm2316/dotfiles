#!/usr/bin/env bash
theme="$HOME/dotfiles/rofi/themes/default.rasi"
case "$1" in
  'calc')
    rofi -show calc -modi calc -no-show-match -no-sort \
      -calc-command "echo -n '{result}' | xclip -sel clip" \
      -theme "$theme"
    ;;
  'emoji')
    splatmoji copy
    ;;
  'run')
    rofi -show run -theme "$theme"
    ;;
  'drun')
    rofi -show drun -theme "$theme"
    ;;
  'powermenu')
    ~/dotfiles/rofi/powermenu.sh
    ;;
  'window')
    rofi -show window -theme "$theme"
    ;;
esac
