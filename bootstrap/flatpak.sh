#!/usr/bin/env sh
# flatpak `.desktop` files will be installed to:
# /var/lib/flatpak/exports/share/applications

# install flatpak, configure it to use dl.flathub.org
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo

# install ungoogled-chromium from flathub
flatpak install io.github.ungoogled_software.ungoogled_chromium
ln -s ~/dotfiles/config/applications/ungoogled-chromium.desktop \
  ~/.local/share/applications/ungoogled-chromium.desktop
echo 'Installed ungoogled-chromium!'

# install thunderbird
flatpak install flathub org.mozilla.Thunderbird
ln -s ~/dotfiles/config/applications/thunderbird.desktop \
  ~/.local/share/applications/thunderbird.desktop
echo 'Installed thunderbird!'

# install slack
flatpak install flathub com.slack.Slack
ln -s ~/dotfiles/config/applications/slack.desktop \
  ~/.local/share/applications/slack.desktop
echo 'Installed slack!'
