#!/bin/bash

USER_OS=$(awk -F = '$1=="ID" { print $2 ;}' /etc/os-release)
echo "This is a $USER_OS Linux system"

# emptty() {
#   cd ~/builds || exit
#   git clone https://github.com/tvrzna/emptty
#   cd emptty || exit
#   make
#   make build
#   make install
#   make install-pam-fedora
#   make install-manual
#   make install-config
#   make install-systemd
#   systemctl enable emptty.service
# }

# install lua 5.1, luajit, and luarocks
lua() {
  # lua
  cd ~/builds || exit
  curl -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
  tar xzfv lua-5.1.5.tar.gz
  cd lua-5.1.5 || exit
  make linux 
  make test
  make install
  cd ~/builds || exit
  rm lua-5.1.5.tar.gz

  # luajit
  luajit_latest_version=$(curl -sL https://api.github.com/repos/luajit/luajit/tags | jq -r '.[0].name' | cut -c 2-)
  luajit_latest_filename="LuaJIT-$luajit_latest_version.tar.gz"
  luajit_url="https://luajit.org/download/$luajit_latest_filename"
  curl -R -O "$luajit_url"
  cd "$luajit_latest_filename" || exit
  make && make install
  cd ~/builds || exit
  rm "$luajit_latest_filename"

  # luarocks
  luarocks_latest_version=$(curl -sL https://api.github.com/repos/luarocks/luarocks/tags | jq -r '.[0].name' | cut -c 2-)
  luarocks_latest_filename="luarocks-$luarocks_latest_version.tar.gz"
  luarocks_url="https://luarocks.github.io/luarocks/releases/$luarocks_latest_filename"
  curl -R -O "$luarocks_url"
  tar zxpf "$luarocks_latest_filename"
  cd "$luarocks_latest_filename" || exit
  ./configure && make && make install
  cd ~/builds || exit
  rm "$luarocks_latest_filename"
}

# install homebrew/linuxbrew
homebrew() {
  # homebrew/linuxbrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# install all programming languages and programming language runtimes that i will need
programming_languages() {
  # golang with "stefanmaric/g" version manager
  curl -sSL https://git.io/g-install | sh -s

  # rust/rustup/cargo
  
  # nodejs/npm with 'tj/n' version manager
  if [ ! -d "$HOME/n" ]; then
    curl -L https://git.io/n-install | /bin/bash -s -- -n
  fi
  eval "$HOME/n/bin/n lts"

  # deno
  curl -fsSL https://deno.land/install.sh | sh

  # call lua function
  lua
}

# packages
dnf_packages() {
  dnf install -y \
    arc-theme \
    blueman \
    dunst \
    flameshot \
    gstreamer1-plugin-openh264 \
    imwheel \
    keychain \
    kitty \
    lxappearance \
    mozilla-openh264 \
    NetworkManager \
    NetworkManager-wifi \
    nitrogen \
    papirus-icon-theme \
    picom \
    pip \
    polybar \
    python3 \
    qalculate \
    rofi \
    ShellCheck \
    vim \
    xclip \
    xset \
    xsetroot
}

homebrew_packages() {
  brew bundle install --file "$HOME/dotfiles/Brewfile"
}

# rofi calculator plugin with qalculate
rofi_calc() {
  dnf install -y rofi-devel qalculate
  cd ~/builds || exit
  git clone https://github.com/svenstaro/rofi-calc.git
  cd rofi-calc || exit
  autoreconf -i
  mkdir build
  cd build/ || exit
  ../configure
  make
  make install
  cd ~/builds || exit
}

# https://www.starkandwayne.com/blog/how-to-download-the-latest-release-from-github/
# $1=repo, $2=test_keyword
gh_release_latest() {
  release_url=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | jq -r ".assets[] | select(.name | test(\"$2\")) | .browser_download_url")
  curl -LO "$release_url"
  echo "$release_url" | awk -F/ '{print $NF}'
}

# install neovim from source on fedora
neovim() {
  yum -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl
  mkdir -pv ~/builds/neovim || exit
  cd ~/builds/neovim || exit
  git pull
  make distclean
  make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/nvim"
  make install
  cd ~/builds || exit
}

# if ~/builds dir doesn't exist, make it
echo "Creating the '~/builds' directory for manual in $USER's home directory"
mkdir -pv ~/builds
# then move into it
cd ~/builds || exit

if [ "$(command -v dnf)" ]; then
  # apparently git isn't installed by default?? make sure it is please
  dnf install -y git dnf-plugins-core

  programming_languages
  homebrew

  dnf_packages
  homebrew_packages

  neovim

  # ------------------------------------------------------------
  # TMUX
  # ------------------------------------------------------------
  # tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/dotfiles/tmux/plugins/tpm
  # open tmux and press `prefix + I` to install following plugins
  # tmux-resurrect: https://github.com/tmux-plugins/tmux-resurrect
  # tmux-continuum: https://github.com/tmux-plugins/tmux-continuum

  # luacheck
  luarocks install luacheck
  # teal
  luarocks install tl

  # ------------------------------------------------------------
  # NODE/NPM/YARN PACKAGES
  # ------------------------------------------------------------
  # yarn and pnpm
  npm i -g yarn pnpm

  # language servers for neovim (lsp)
  npm i -g \
    vscode-langservers-extracted \
    bash-language-server \
    typescript typescript-language-server \
    vim-language-server \
    @tailwindcss/language-server \
    @astrojs/language-server \
    graphql-language-service-cli \
    @prisma/language-server \
    stylelint-lsp \
    yaml-language-server

  # install tree-sitter-cli to complile the Teal Treesitter binary in Neovim
  npm i -g tree-sitter-cli

  # sqls
  go install github.com/lighttiger2505/sqls@latest

  # zk
  brew install zk

  # pylsp
  pip install python-lsp-server

  # gopls language server
  go install golang.org/x/tools/gopls@latest

  # sumneko_lua language server
  brew install lua-language-server

  # teal language server
  luarocks install --dev teal-language-server

  # lazygit
  brew install jesseduffield/lazygit/lazygit

  # vscodium
  rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
  dnf install -y codium

  # github cli (gh)
  # all distro options: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
  dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  dnf install -y gh

  # splatmoji
  splatmoji_rpm=$(gh_release_latest 'cspeterson/splatmoji' 'rpm')
  dnf install -y "$splatmoji_rpm"

  # rofi calc
  rofi_calc

  # obsidian
  mkdir -pv ~/appimages
  cd ~/appimages || exit
  obsidian_appimage=$(gh_release_latest 'obsidianmd/obsidian-releases' 'Obsidian-[0-9.]+AppImage')
  chmod +x "$obsidian_appimage"

  # docker
  dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  systemctl start docker
  docker run hello-world

# elif [ "$(command -v apt)"  ]; then
# elif [ "$(uname -s)" = "Darwin" ]; then
fi
