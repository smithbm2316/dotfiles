#!/usr/bin/env sh
# https://github.com/fairyglade/ly
if [ "$(command -v apt)" ] && [ "$(command -v brew)" ]; then
  sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev
  brew install zig
elif [ "$(command -v dnf)" ]; then
  sudo dnf install -y kernel-devel pam-devel libxcb-devel zig
else
  echo 'No `apt`, or `dnf`, skipping `ly`...'
  exit 1
fi

# Install Ly Console Display Manager
cd ~/builds || exit
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly || exit
sudo zig build installsystemd
sudo systemctl enable ly.service
# might need to disable this to get proper tty support with ly
# systemctl disable getty@tty2.service
echo 'Installed and enabled `ly`!'

# https://wiki.debian.org/DebianMed
# https://stackoverflow.com/a/2929502
# git grep <regexp> $(git rev-list -all)
# git rev-list --all | xargs git grep <regexp>
