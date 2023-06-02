#!/bin/sh
link="$(xclip -sel clip -o)"

# check if the link is a youtube link, if so transform it properly from a potential playlist link
if echo "$link" | grep 'youtube.com'; then
  link="$(echo "$link" | sed -nr 's/^(.*?v=[A-Za-z0-9\-]+)&?.*/\1/p')"
fi

notify-send 'Opening mpv with video from clipboard...' "$link"
mpv --title='mpv' "$link"
