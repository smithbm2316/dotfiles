#!/usr/bin/env sh
if [ "$(command -v apt)" ]; then
  sudo apt install -y build-essential gcc make python3 python3-xlib 
elif [ "$(command -v dnf)" ]; then
  sudo dnf install -y build-essential gcc make python3 python3-xlib 
else
  echo 'Neither `apt` or `dnf` is installed, exiting...'
  exit 1
fi

cd ~/builds || exit
git clone https://github.com/rvaiya/keyd
cd keyd || exit
# checkout the latest stable release
git checkout "$(git tag | sort -V | tail -n 1)"
make && sudo make install
sudo rm -rf /etc/keyd
sudo ln -s "$HOME/dotfiles/keyd" /etc/keyd
sudo systemctl enable keyd && sudo systemctl start keyd
