#!/usr/bin/env sh
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
# nm-tray for a tray icon in a WM's bar

# fedora: gstreamer1-plugin-openh264 mozilla-openh264
# mediastreamer2-plugin-openh264
#
# https://docs.fedoraproject.org/en-US/quick-docs/openh264/
# h264 codec for firefox
# fedora instructions:
# sudo dnf config-manager --set-enabled fedora-cisco-openh264
# sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
# Afterwards you need open Firefox, go to menu → Add-ons → Plugins and enable OpenH264 plugin.

# common packages for building from source
sudo apt install -y build-essential cmake gcc g++ make manpages-dev unzip

# terminal/shell stuff
sudo apt install -y kitty foot zsh
# keychain possibly

# audio
# don't need pulseaudio utilities, use pipewire instead!
# sudo apt install -y pamixer pavucontrol pulseaudio-utils pasystray
sudo apt install -y libspa-0.2-bluetooth pipewire playerctl wireplumber

# theming
sudo apt install -y papirus-icon-theme

# window manager
sudo apt install -y dunst libnotify-bin grim slurp sway swaylock wofi
# kazam obs-studio vokoscreen-ng

# programming languages
sudo apt install -y python3 qalc qalculate-gtk

# programming dev tools
sudo apt install -y litecli mkcert pgcli 

# core utilities (https://en.wikipedia.org/wiki/Util-linux)
sudo apt install -y bat brightnessctl cloc fdfind ffmpeg fuzzel fzf httpie jq \
  libpam0g parallel pup ripgrep tree util-linux wev wl-clipboard xwayland
# x11 debian packages if i need them:
# autorandr, xbacklight, xclip, xdotool, xinput, x11-utils, x11-server-utils,
# xorg, xserver-org, xbindkeys, xvkbd
#
# x11-utils/x11-server-utils installs packages below:
# xdpyinfo, xev, xset, xsetroot, xmodmap, xprop, xrandr
#
# other x11-only programs that i have wayland versions for already
# battray, feh, scrot, rofi, lxappearance

# mpv/video
sudo apt install -y mpv mpv-mpris libavcodec-extra
# smplayer smtube ytcc yt-dlp ytfzf

# books / documents
sudo apt install -y foliate

# archive tools
sudo apt install -y file-roller unzip

# backports:
# kitty sway

source "$pwd/deno.sh"
source "$pwd/firefox-dev.sh"
source "$pwd/firefox.sh"
source "$pwd/fonts.sh"
source "$pwd/git-delta.sh"
source "$pwd/google-chrome-dev.sh"
source "$pwd/homebrew.sh"
source "$pwd/keyd.sh"
source "$pwd/lsp-servers.sh"
source "$pwd/lua.sh"
source "$pwd/ly.sh"
source "$pwd/neovim.sh"
source "$pwd/obsidian.sh"
source "$pwd/php.sh"
source "$pwd/spotify.sh"
source "$pwd/tmux.sh"
source "$pwd/vscodium.sh"
source "$pwd/zsh.sh"

# aptgrep() {
#   apt list --installed | grep --color=always $@
# }
# 
# aptsearch() {
#   apt search --names-only $@ | less
# }
||||||| parent of 7426f47 (wip: setup on thinkpad with debian)

# mpv mpv-mpris smplayer smtube ytcc yt-dlp ytfzf

# aptgrep() {
#   apt list --installed | grep --color=always $@
# }
# 
# aptsearch() {
#   apt search --names-only $@ | less
# }
=======
source "$pwd/php.sh"
source "$pwd/obsidian.sh"
source "$pwd/spotify.sh"
source "$pwd/tmux.sh"
source "$pwd/vscodium.sh"
source "$pwd/zsh.sh"
>>>>>>> 7426f47 (wip: setup on thinkpad with debian)
