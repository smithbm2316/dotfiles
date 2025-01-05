#!/usr/bin/env sh
# use spotify's official linux package for spotify if on Debian/Ubuntu
if [ "$(command -v apt)" ]; then
  # you probably need to update the link you're downloading from for spotify:
  # https://www.spotify.com/us/download/linux/
  curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | \
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
