#!/bin/sh

USER_OS=$(sed -n "s/^NAME=\(.*\)$/\1/p" /etc/os-release)

if [ $(command -v dnf) ]; then
  echo "Fedora/CentOS-based system"
  # magic command for all user installed packages
  dnf repoquery --userinstalled | sed -n 's/\(.*\)-.:.*/\1/p'

  # vscodium
  rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg" | tee -a /etc/yum.repos.d/vscodium.repo
  dnf install codium

elif [ $(command -v apt)  ]; then
  echo "Ubuntu/Debian-based system"

  # vscodium
  wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg
  echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
  apt update && apt install codium

elif [ $(uname -s) = "Darwin" ]; then
  echo "MacOS system"
  # vscodium
  brew install --cask vscodium

elif [ $(command -v pacman)  ]; then
  echo "Arch-based system"

fi
