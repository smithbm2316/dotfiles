#!/bin/sh
notify-send 'Opening mpv with video from clipboard...'
mpv --title=mpv "$(xclip -o)"
