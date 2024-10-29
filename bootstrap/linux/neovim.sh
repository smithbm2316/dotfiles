#!/usr/bin/env sh
if [ "$(command -v apt)" ]; then
  sudo apt install -y build-essential cmake curl gettext ninja-build unzip 
elif [ "$(command -v dnf)" ]; then
  sudo dnf -y install ninja-build cmake gcc make unzip gettext curl glibc-gconv-extra
else
  echo 'Neither `apt` or `dnf` is installed, exiting...'
  exit 1
fi

cd ~/builds || exit
if [ ! -d "neovim" ]; then
  git clone https://github.com/neovim/neovim
fi
cd neovim || exit
git checkout stable
git pull
make distclean
# CMAKE_BUILD_TYPE=RelWithDebInfo if you want extra debug info for the build
make CMAKE_BUILD=Release \
  CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/nvim"
make install
