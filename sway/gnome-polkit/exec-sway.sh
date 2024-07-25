#!/usr/bin/env sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
/usr/bin/sway
