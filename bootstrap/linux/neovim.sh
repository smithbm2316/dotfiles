#!/usr/bin/env bash
if [ "$(command -v apt)" ]; then
  sudo apt install -y build-essential cmake curl gettext ninja-build unzip 
elif [ "$(uname -s)" = "Darwin" ] && [ "$(command -v brew)" ]; then
  brew install ninja cmake gettext curl
else
  echo 'Not a debian or macos system, exiting...'
  exit 1
fi

cd ~/builds || exit
if [ ! -d "neovim" ]; then
  git clone https://github.com/neovim/neovim
fi
cd neovim || exit
git checkout master
git pull
make distclean
# CMAKE_BUILD_TYPE=RelWithDebInfo if you want extra debug info for the build
# CMAKE_BUILD_TYPE=Release full optimized neovim build
make CMAKE_BUILD_TYPE=RelWithDebInfo \
  CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/nvim-nightly"
make install
