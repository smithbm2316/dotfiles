#!/usr/bin/env bash
if [ ! "$(command -v xbps-install)" ]; then
  echo 'Not on a Void Linux system. Exiting...'
  exit 1
fi

# install some base-level packages i need just to get the system functioning
sudo xbps-install -S curl git stow vim wget

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

# set up timezone
sudo ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# create XDG BASE directory specification-related directories
mkdir -pv ~/.cache ~/.config ~/.local/bin ~/.local/share ~/.local/state \
  ~/desktop ~/documents ~/downloads ~/music ~/pictures ~/public ~/templates ~/videos

# create some other directories in $HOME that i use (also maybe ~/wiki?)
mkdir -pv ~/builds ~/code ~/notes ~/work

# clone my dotfiles into $HOME and symlink my dotfiles to `$XDG_CONFIG_HOME`
# (~/.config) using `~/stow`. Make sure to update git submodules
cd ~ || exit
git clone https://github.com/smithbm2316/dotfiles.git ~/dotfiles --recurse-submodules
stow -v -t ~/.config dotfiles

# install base packages from packages/base.txt, removing any comments first
sed 's/#.*$//' ~/dotfiles/bootstrap/void/base.txt | xargs sudo xbps-install -S -

# install neovim HEAD
~/dotfiles/scripts/build-neovim.sh

# update flatpak to use flathub and install flatpaks
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install io.github.ungoogled_software.ungoogled_chromium && echo 'Installed ungoogled-chromium!'
flatpak install flathub io.gitlab.librewolf-community && echo 'Installed librewolf!'
flatpak install flathub app.zen_browser.zen && echo 'Installed zen browser!'
flatpak install flathub com.brave.Browser && echo 'Installed brave browser!'

# symlink .zshenv to home directory so ZDOTDIR variable gets exported for my user
ln -s ~/dotfiles/zsh/.zshenv ~/.zshenv

# change user shell to zsh
chsh -s "$(which zsh)"

# if bat is installed, update the cache so that it installs custom themes
# already in my dotfiles for use
if command -v bat; then
  bat cache --build
fi

# SERVICE FILES

# set up logging
sudo ln -s /etc/sv/nanoklogd /var/service
sudo ln -s /etc/sv/socklog-unix /var/service

# set up keyd service after symlinking the config directory
sudo ln -s ~/dotfiles/keyd /etc/keyd
sudo ln -s /etc/sv/keyd /var/service

# set up default services
sudo ln -s /etc/sv/acpid /var/service
sudo ln -s /etc/sv/bluetoothd /var/service
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/NetworkManager /var/service

# set up session and login manager services
sudo ln -s /etc/sv/greetd /var/service
sudo ln -s /etc/sv/seatd /var/service
sudo ln -s /etc/sv/turnstiled /var/service

# set up pipewire and pulseaudio configs
sudo mkdir -pv /etc/pipewire/pipewire.conf.d
sudo cp -iv /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d
sudo cp -iv /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d

# set up user services (dbus, pipewire) 
# note: turnstile enables the use of per-user services in the `$XDG_CONFIG_HOME/service/` directory
# https://docs.voidlinux.org/config/services/user-services.html#turnstile
# set up turnstile user-service config
mkdir -pv ~/.config/service/turnstile-ready/
echo 'core_services="dbus"' > ~/.config/service/turnstile-ready/conf
# set up dbus service for user
mkdir -pv ~/.config/service/dbus
ln -s /usr/share/examples/turnstile/dbus.run ~/.config/service/dbus/run
ln -s /usr/share/examples/turnstile/dbus.check ~/.config/service/dbus/check
# set up pipewire service for user
mkdir -pv ~/.config/service/pipewire
echo '#!/usr/bin/env sh
pipewire' > ~/.config/service/pipewire

# disable closing laptop lid from putting laptop to sleep
# https://www.reddit.com/r/voidlinux/comments/hwkh8f/comment/fz17pzy/

# install uv and latest version of python
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install

# install pnpm, LTS node, and global npm packages
curl -fsSL https://get.pnpm.io/install.sh | sh -
pnpm env use --global lts
~/dotfiles/bootstrap/npm-pkgs.sh
