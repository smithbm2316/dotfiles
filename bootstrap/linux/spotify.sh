#!/usr/bin/env sh
# use spotify's official linux package for spotify if on Debian/Ubuntu
# https://www.spotify.com/us/download/linux/
if [ "$(command -v apt)" ]; then
  curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | \
    sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | \
    sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client
# use flatpak if on Fedora linux
elif [ "$(command -v dnf)" ]; then
  sudo dnf install -y flatpak
  flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak install flathub com.spotify.Client
else
  echo 'Neither `apt` or `dnf` is installed, exiting...'
  exit 1
fi
