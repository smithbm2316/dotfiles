#!/usr/bin/env sh

# https://linuxconfig.org/how-to-install-firefox-developer-edition-on-linux
mkdir -pv ~/.local/share/applications
cd ~/.local || exit
curl --location \
  "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" \
  | tar xvpj
mv -v firefox ~/.local/firefox-dev
ln -sv ~/.local/firefox-dev/firefox ~/.local/bin/firefox-dev
ln -sv ~/dotfiles/config/applications/firefox-dev.desktop ~/.local/share/applications/firefox-dev.desktop
