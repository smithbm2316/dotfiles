#!/usr/bin/env sh
if [ "$(command -v apt)" ]; then
  sudo apt install abcde lame eyed3 imagemagick flac
else 
  echo 'apt is not installed, exiting...'
  exit 1
fi

# install musicbrainz picard for managing audio library + tagging files
sudo apt install picard
