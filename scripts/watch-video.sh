#!/bin/sh
link="$(xclip -sel clip -o)"

# validate that we passed a youtube link to the program first, exit early if we didn't
if echo "$link" | grep 'youtube.com'; then
  # check if this is a valid watch later youtube link, if so transform it to a normal video link without the playlist details attached
  if echo "$link" | grep 'list=WL'; then
    link="https://youtube.com/watch?v=$(echo "$link" | sed -nr 's/^.*[?&]v=([^?&]+?)[?&].*$/\1/p')"
    notify-send 'Opening mpv with youtube video from watch later...' "$link"
  else
    notify-send 'Opening mpv with youtube video...' "$link"
  fi
else
  notify-send 'Link was not a valid youtube video' "$link"
  exit 1
fi

mpv --title='mpv' "$link"
