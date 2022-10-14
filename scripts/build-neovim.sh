#!/usr/bin/env sh
cd ~/builds/neovim || exit
git pull
make distclean
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/nvim"
make install
