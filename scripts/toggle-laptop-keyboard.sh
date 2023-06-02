#!/bin/sh

kbd_info=$(xinput list | grep 'AT Translated')
floated=$(echo "$kbd_info" | grep 'floating slave')
id=$(echo "$kbd_info" | awk -F '=' '{ print $2 }' | awk '{ print $1 }')

if [ ! -z "$floated" ]; then
  slave_id=$(cat ~/internal-kbd.txt)
  xinput reattach "$id" "$slave_id"
  notify-send 'Enabled internal laptop keyboard'
else
  slave_id=$(echo "$kbd_info" | sed -n 's/.* (\([0-9]\+\))\]/\1/p')
  echo "$slave_id" > ~/internal-kbd.txt
  xinput float "$id"
  notify-send 'Disabled internal laptop keyboard'
fi
