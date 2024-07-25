#!/usr/bin/env sh

if [ ! "$(command -v nmcli)" ]; then
  echo 'Please install the Network manager nmcli package.'
  exit 1
fi

if [ "$(nmcli radio | tail -n 1 | xargs | cut -d ' ' -f 2-4 | grep enabled)" ]; then
  nmcli radio all off
  notify-send 'Enabled airplane mode'
else
  nmcli radio all on
  notify-send 'Disabled airplane mode'
fi

nmcli radio
