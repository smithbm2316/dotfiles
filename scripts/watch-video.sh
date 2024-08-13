#!/usr/bin/env sh
if [ ! "$(command -v mpv)" ]; then
  notify-send 'Need mpv installed to launch a video.'
  exit 1
fi
# TODO: make sure to install youtube-dl into a system dir, not with brew where
# the shell $PATH doesn't see it
#
# if [ ! "$(command -v youtube-dl)" ]; then
#   notify-send 'Need youtube-dl installed to run a youtube video with mpv.'
#   exit 1
# fi

link=""
if [ "$XDG_SESSION_TYPE" = 'wayland' ] && [ "$(command -v wl-paste)" ]; then
  link="$(wl-paste)"
elif [ "$XDG_SESSION_TYPE" = 'x11' ] && [ "$(command -v xclip)" ]; then
  link="$(xclip -sel clip -o)"
else
  notify-send 'Check $XDG_SESSION_TYPE and if xclip/wl-paste is installed.'
  exit 1
fi

# validate that we passed a youtube link to the program first, exit early if we didn't
if echo "$link" | grep 'youtube.com\|youtu.be'; then
  # check if this is a valid watch later youtube link, if so transform it to a normal video link without the playlist details attached
  if echo "$link" | grep 'list=WL'; then
    link="https://youtube.com/watch?v=$(echo "$link" | sed -nr 's/^.*[?&]v=([^?&]+?)[?&].*$/\1/p')"
    notify-send 'Opening mpv with youtube video from watch later...' "$link"
  else
    notify-send 'Opening mpv with youtube video...' "$link"
  fi
elif echo "$link" | grep 'youtu.be'; then
  notify-send 'Opening mpv with youtube video...' "$link"
else
  notify-send 'Link was not a valid youtube video' "$link"
  exit 1
fi

if [ "$1" = 'audio' ]; then
  if [ "$(command -v foot)" ]; then
    term="foot"
    foot mpv --title=mpv --no-video "$link"
  elif [ "$(command -v kitty)" ]; then
    term="kitty"
  else
    notify-send 'Please install the foot or kitty terminal to run this script.'
    exit 1
  fi

  $term mpv --no-video "$link"
else
  mpv --title='mpv youtube' "$link"
fi
