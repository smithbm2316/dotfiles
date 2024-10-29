#!/bin/bash
sudo dnf install -y fish git stow dnf-plugins-core
chsh -s /bin/fish
sudo chsh -s /bin/fish

# https://support.system76.com/articles/system76-driver
sudo dnf copr enable szydell/system76
sudo dnf install system76*
sudo systemctl enable --now system76-power.service
sudo systemctl enable --now com.system76.PowerDaemon.service

# https://support.system76.com/articles/system76-software/
sudo dnf install firmware-manager
sudo systemctl enable --now system76-firmware-daemon
sudo gpasswd -a $USER adm

sudo systemctl enable system76-power system76-power-wake
sudo systemctl start system76-power

sudo dnf install system76-dkms
sudo systemctl enable dkms

# https://www.reddit.com/r/Fedora/comments/wo9wli/system76power_failed_to_preset_unit_unit_file/

# maybe
# sudo systemctl mask power-profiles-daemon.service

# git clone https://github.com/pop-os/gnome-shell-extension-system76-power.git
# cd gnome-shell-extension-system76-power || exit
# sudo dnf install nodejs-typescript
# make
# make install
