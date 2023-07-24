#!/usr/bin/env sh
# https://askubuntu.com/a/1200953
dconf dump / | sed -n '/\[org.gnome.settings-daemon.plugins.media-keys/,/^$/p' > ~/dotfiles/gnome-custom-shortcuts/shortcuts.ini
# dconf load / < ~/dotfiles/gnome-custom-shortcuts/shortcuts.ini
