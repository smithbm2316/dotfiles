#!/usr/bin/env bash
# Use rofi to call systemctl for shutdown, reboot, etc
# Adapted from https://github.com/orestisfl/dotfiles/blob/b2a0c96034f9a837389322e33ee176706f895b13/executables/bin/i3-rofi-actions
set -e

declare -A options
declare -a options_order

function add_option() {
  options["$1"]="$2"
  options_order+=("$1")
}

# Fill options.
add_option 'Sleep' 'swaylock -f -c 0f172a && zzz'
add_option 'Shutdown' 'shutdown -h now'
add_option 'Reboot' 'shutdown -r now'
add_option 'Log out' 'swaymsg exit'
add_option 'Lock' 'swaylock -f -c 0f172a'
# add_option "Hibernate" "systemctl hibernate"
options_keys=$(printf '%s\n' "${options_order[@]}")  # Get keys as a string, seperated by newlines.
options_len=$(echo -e "$options_keys"|wc -l)
echo -e "$options_keys"

launcher="rofi -matching fuzzy -l $options_len -dmenu -i -p 'Pick action: '"
selection=$(echo -e "$options_keys" | eval "$launcher" | tr -d '\r\n')
echo "$selection : ${options[$selection]}"

eval "${options[$selection]}"
