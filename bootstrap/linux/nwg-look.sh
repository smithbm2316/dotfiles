#!/usr/bin/env sh

# https://github.com/nwg-piotr/nwg-look
if [ ! "$(command -v go)" ]; then
  echo 'Need the go compiler installed to build. Exiting...'
  exit 1
fi
sudo apt install -y libgtk-3-dev libcairo2-dev libglib2.0-bin

cd ~/builds || exit
git clone https://github.com/nwg-piotr/nwg-look
cd nwg-look || exit
# checkout the latest stable release
git checkout "$(git tag | sort -V | tail -n 1)"
make build && sudo make install
