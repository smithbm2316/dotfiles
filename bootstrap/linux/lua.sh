#!/usr/bin/env sh
# lua
if [ "$(command -v apt)" ]; then
  sudo apt install -y readline-common libreadline-dev
elif [ "$(command -v apt)" ]; then
  sudo dnf install -y readline readline-devel
else 
  echo 'Neither `apt` or `dnf` is installed, exiting...'
  exit 1
fi

cd ~/builds || exit
curl -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
tar zxpfv lua-5.1.5.tar.gz
cd lua-5.1.5 || exit
make linux 
# make test && make install INSTALL_TOP="$HOME/.local"
make test && sudo make install
cd ~/builds || exit
rm -rf lua-5.1.5.tar.gz

# luarocks
cd ~/builds || exit
git clone https://github.com/luarocks/luarocks.git
cd luarocks || exit
git checkout "$(git tag | sort -V | tail -n 1)"
./configure \
  --with-lua="/usr/local" \
  --lua-version='5.1'
make && sudo make install
