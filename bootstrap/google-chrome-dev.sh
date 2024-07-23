#!/usr/bin/env sh

mkdir -pv ~/builds
cd ~/builds || exit
wget https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb
sudo dpkg -i google-chrome-unstable_current_amd64.deb
echo 'Installed google chrome dev!'
