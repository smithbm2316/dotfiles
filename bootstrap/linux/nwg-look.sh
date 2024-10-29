#!/usr/bin/env sh
# https://github.com/nwg-piotr/nwg-look
if [ "$(command -v go)" ]; then
  echo 'Need the go compiler installed to build. Exiting...'
  exit 1
fi
sudo apt install -y libgtk-3-dev libcairo2-dev libglib2.0-bin zip

cd ~/builds || exit
wget -q --show-progress \
  https://github.com/nwg-piotr/nwg-look/archive/refs/tags/v0.2.6.zip
unzip v0.2.6.zip
cd nwg-look-0.2.6
make build
sudo make install
cd ..
rm v0.2.6.zip
