#!/bin/sh

USER_OS=$(sed -n "s/^NAME=\(.*\)$/\1/p" /etc/os-release)

# if ~/clones dir doesn't exist, make it
mkdir ~/clones
# then move into it
cd clones

if [ $(command -v dnf) ]; then
  echo "Fedora/CentOS-based system"

  # xcape
  dnf install git gcc make pkgconfig libX11-devel libXtst-devel libXi-devel
  git clone https://github.com/alols/xcape.git
  cd xcape
  make
  sudo make install
  cd ..

  # emptty display manager
  git clone https://github.com/tvrzna/emptty
  cd emptty
  make build
  make install
  make install-manual
  make install-pam-fedora
  make install-config
  make install-systemd
  systemctl disable gdm.service
  systemctl enable emptty.service
  cd ..

  # TMUX
  # tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/dotfiles/tmux/plugins/tpm
  # open tmux and press `prefix + I` to install following plugins
  # tmux-resurrect: https://github.com/tmux-plugins/tmux-resurrect
  # tmux-continuum: https://github.com/tmux-plugins/tmux-continuum

  # MANUAL RPM PACKAGES
  # glow
  cd ~/downloads
  gh release download -R charmbracelet/glow -p "glow_*_linux_amd64.rpm"
  dnf install glow_*_linux_amd64.rpm
  rm glow_*_linux_amd64.rpm

  # splatmoji
  gh release download -R cspeterson/splatmoji -p "splatmoji*.rpm"
  dnf install splatmoji*.rpm
  rm splatmoji*.rpm

  # neovim
  gh release download nightly -R neovim/neovim -p "nvim.appimage"
  mv nvim.appimage /usr/local/bin/nvim

  # NODE/NPM/YARN PACKAGES
  # node version manager (nvm)
  cd ~/
  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"
  nvm install node --lts

  # yarn & language servers for neovim
  npm -g install bash-language-server typescript typescript-language-server vim-language-server vscode-css-languageserver-bin vscode-html-languageserver-bin yarn

elif [ $(command -v apt)  ]; then
  echo "Ubuntu/Debian-based system"

elif [ $(uname -s) = "Darwin" ]; then
  echo "MacOS system"

elif [ $(command -v pacman)  ]; then
  echo "Arch-based system"

fi
