#!/bin/bash
# get the volume, will show left and right audio levels (i.e. "30 30")
bothVolumes=$(pulsemixer --get-volume)
# take just the first value using a substring
volumeLevel="${bothVolumes:0:2}"
# use the correct icon and color for if pulse is muted or not
[ $(pulsemixer --get-mute) -eq 0 ] \
  && volFormat="<fc=#40b4c4>ﱘ </fc>" \
  || volFormat="<fc=#ffe261>ﱙ </fc>"
echo $volFormat$volumeLevel
