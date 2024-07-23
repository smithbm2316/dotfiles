#!/usr/bin/env bash
if [ ! "$(command -v apt)" ]; then
  echo 'Not on a Debian/Ubuntu/apt-based system. Exiting...'
  exit 1
fi

# set a variable to where this script is found
pwd="$HOME/dotfiles/bootstrap"

# use debian's `tasksel` command to install useful programs for laptops
sudo tasksel install laptop

# reconfigure console-UIs to have a bigger font size
# 1. select "UTF-8"
# 2. select "Latin1 and Latin5"
# 3. select "TerminusBold"
# 4. select "14x28"
sudo dpkg-reconfigure console-setup

# install some base-level packages i need just to get the system functioning
sudo apt install curl git stow vim wget

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
  echo "Couldn't find ~/dotfiles, skipping git submodules for that repo"

# additional useful packages
sudo apt install dhelp info lynx w3m

# https://github.com/jarun/buku for bookmarks management?

# bluetooth utils
sudo apt install -y blueman bluez
sudo systemctl enable bluetooth

# network management
sudo apt install -y policykit-1-gnome \
  network-manager network-manager-gnome network-manager-ssh

# browsers
# sudo apt install -y firefox
# fedora: gstreamer1-plugin-openh264 mozilla-openh264
# mediastreamer2-plugin-openh264

# common packages for building from source
sudo apt install -y build-essential cmake gcc g++ make manpages-dev

# terminal/shell stuff
sudo apt install -y kitty foot zsh
# keychain possibly

# audio
sudo apt install -y pamixer pavucontrol playerctl pulseaudio-utils

# theming
sudo apt install -y papirus-icon-theme

# window manager
sudo apt install -y dunst grim slurp sway wofi
# kazam obs-studio vokoscreen-ng
# systrays: battray pasystray nm-tray

# programming languages
sudo apt install -y python3 qalc qalculate-gtk

# core utilities (https://en.wikipedia.org/wiki/Util-linux)
sudo apt install -y jq pup xev util-linux wl-clipboard

# books / documents
sudo apt install -y foliate

# backports:
# kitty sway

source "$pwd/fonts.sh"
source "$pwd/keyd.sh"
source "$pwd/homebrew.sh"
source "$pwd/neovim.sh"

# mpv mpv-mpris smplayer smtube ytcc yt-dlp ytfzf

# aptgrep() {
#   apt list --installed | grep --color=always $@
# }
# 
# aptsearch() {
#   apt search --names-only $@ | less
# }
