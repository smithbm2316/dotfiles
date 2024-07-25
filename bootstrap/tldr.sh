#!/usr/bin/env sh
# https://github.com/tldr-pages/tldr-c-client
if [ "$(command -v apt)" ]; then
  sudo apt install -y curl gcc libcurl-dev libcurl4-openssl-dev libzip-dev pkg-config
elif [ "$(command -v brew)" ]; then
  brew install tldr
  echo 'Installed tldr with brew!'
  exit 0
else
  echo 'No `apt` or `brew` found, skipping install of tldr...'
  exit 1
fi

cd ~/builds || exit
git clone https://github.com/tldr-pages/tldr-c-client.git
cd tldr-c-client || exit
sudo ./deps.sh
make
sudo make install
mv autocomplete/complete.zsh "$ZDOTDIR/completions/tldr-complete.zsh"
