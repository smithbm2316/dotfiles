#!/usr/bin/env sh
wpctl set-mute "$(wpctl status |\
  awk '/Audio/{f=1;next} /Video/{f=0} f' |\
  awk '/Sources:/{f=1;next} /Source endpoints:/{f=0} f' |\
  sed -nE 's/.*\*\s+([0-9]+)\..*$/\1/p')" \
  toggle
