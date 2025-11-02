#!/usr/bin/env sh
if [ "$(command -v apt)" ]; then
  sudo apt install \
    libgtk-4-dev \
    libgtk4-layer-shell-dev \
    libadwaita-1-dev \
    gettext \
    libxml2-utils
else
  echo 'Not a debian system, exiting...'
  exit 1
fi

cd ~/builds || exit
curl -LO https://release.files.ghostty.org/1.2.0/ghostty-1.2.0.tar.gz
cd ghostty-1.2.0/ || exit
