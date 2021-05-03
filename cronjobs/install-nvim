#!/bin/bash
echo "checking if there is a fresh neovim nightly"
# published="$(gh release view nightly -R neovim/neovim | \
#   sed -rn "s/published:\s*(.*)/\1/p")"
published="$(curl -sH 'Accept: application/vnd.github.v3+json' \
  https://api.github.com/repos/neovim/neovim/releases/tags/nightly \
  sed -rn 's/.*published_at.*"(.*)T.*/\1/p')"

if [[ ! -z "$published" ]]; then
  echo "could not fetch data on neovim nightly"
elif [[ "$published" != "$(date -I)" ]]; then
  rm -f /usr/local/bin/nvim
  curl -s -L -o /usr/local/bin/nvim https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  # gh release download nightly -R neovim/neovim -p "nvim.appimage"
  chmod +x /usr/local/bin/nvim
  echo "updated to latest neovim nightly"
else
  echo "already using the latest neovim nightly"
fi
