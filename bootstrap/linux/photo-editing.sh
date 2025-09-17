#!/usr/bin/env sh
if [ "$(command -v apt)" ]; then
  # Darktable latest stable: https://www.darktable.org/install/
  echo 'deb http://download.opensuse.org/repositories/graphics:/darktable/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/graphics:darktable.list
  curl -fsSL https://download.opensuse.org/repositories/graphics:darktable/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/graphics_darktable.gpg > /dev/null
  sudo apt update
  sudo apt install darktable

  # gimp photo editor
  sudo apt install gimp
else 
  echo 'apt is not installed, exiting...'
  exit 1
fi
