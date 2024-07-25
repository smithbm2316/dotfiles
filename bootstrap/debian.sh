#!/usr/bin/env sh
if [ ! "$(command -v apt)" ]; then
  echo 'Not on a Debian/Ubuntu/apt-based system. Exiting...'
  exit 1
fi

# use debian's `tasksel` command to install useful programs for laptops
sudo tasksel install laptop

# reconfigure console-UIs to have a bigger font size
# 1. select "UTF-8"
# 2. select "Latin1 and Latin5"
# 3. select "TerminusBold"
# 4. select "14x28"
sudo dpkg-reconfigure console-setup

# install some base-level packages i need just to get the system functioning
sudo apt install -y curl git stow vim wget

# use restricted vim as $EDITOR for sudo
#
# further reading:
# https://stackoverflow.com/a/28382838/15089697
# https://wiki.archlinux.org/title/Security#Use_sudo_instead_of_su
# https://wiki.archlinux.org/title/Sudo#Using_visudo
echo '
# use a restricted version of vim (rvim) as $EDITOR for sudo
Defaults editor=/usr/bin/rvim' | \
  sudo EDITOR='tee -a' visudo

# create XDG BASE directory specification-related directories
mkdir -pv ~/.cache ~/.config ~/.local/bin ~/.local/share ~/.local/state \
  ~/desktop ~/documents ~/downloads ~/music ~/pictures ~/public ~/templates ~/videos

# create some other directories in $HOME that i use (also maybe ~/wiki?)
mkdir -pv ~/builds ~/code ~/notes ~/work

# TODO: use some coreutils to overwrite the git url to use ssh instead of https
#
# clone my dotfiles into $HOME and symlink my dotfiles to `$XDG_CONFIG_HOME`
# (~/.config) using `~/stow`. Make sure to update git submodules
cd ~ || exit
git clone https://github.com/smithbm2316/dotfiles.git ~/dotfiles
stow -v -t ~/.config dotfiles
cd ~/dotfiles && git submodule init && git submodule update || \
  echo "Couldn't find ~/dotfiles, skipping git submodules for that repo" && exit 1

# install base packages from packages/base.txt, removing any comments first
sed 's/#.*$//' ~/dotfiles/bootstrap/packages/base.txt | \
  xargs sudo apt install

# enable bluetooth
sudo systemctl enable bluetooth

# fedora: gstreamer1-plugin-openh264 mozilla-openh264
# https://docs.fedoraproject.org/en-US/quick-docs/openh264/
# h264 codec for firefox
# fedora instructions:
# sudo dnf config-manager --set-enabled fedora-cisco-openh264
# sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
# Afterwards you need open Firefox, go to menu → Add-ons → Plugins and enable OpenH264 plugin.

# backports:
# kitty sway

# set a variable to where this script is found
pwd="$HOME/dotfiles/bootstrap"
. "$pwd/deno.sh"
. "$pwd/firefox-dev.sh"
. "$pwd/firefox.sh"
. "$pwd/flatpak.sh"
. "$pwd/fonts.sh"
. "$pwd/git-delta.sh"
# . "$pwd/google-chrome-dev.sh"
. "$pwd/homebrew.sh"
. "$pwd/keyd.sh"
. "$pwd/lsp-servers.sh"
. "$pwd/lua.sh"
. "$pwd/ly.sh"
. "$pwd/neovim.sh"
. "$pwd/obsidian.sh"
. "$pwd/php.sh"
. "$pwd/spotify.sh"
. "$pwd/tldr.sh"
. "$pwd/tmux.sh"
. "$pwd/vscodium.sh"
. "$pwd/zsh.sh"
