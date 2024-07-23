#!/usr/bin/sh
if [ "$(command -v apt)" ]; then
  wget -q https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    -O - | sudo tee /etc/apt/keyrings/vscodium-archive-keyring.asc >/dev/null
  echo 'deb [ signed-by=/etc/apt/keyrings/vscodium-archive-keyring.asc ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
  sudo apt update && sudo apt install -y codium
  echo 'Installed vscodium!'
elif [ "$(command -v dnf)" ]; then
  rpmkeys --import \
    https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
  sudo dnf install -y codium
  echo 'Installed vscodium!'
else
  echo 'Not on a machine with `apt`, skipping tmux installation...'
  exit 1
fi
