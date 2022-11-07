#!/bin/bash

USER_OS=$(awk -F = '$1=="ID" { print $2 ;}' /etc/os-release)
echo "This is a $USER_OS Linux system"

emptty() {
  sudo dnf install pam \
   pam-devel \
   libX11 \
   libX11-devel \
   gcc
  cd ~/builds || exit
  git clone https://github.com/tvrzna/emptty
  cd emptty || exit
  make
  sudo make build
  sudo make install
  sudo make install-pam-fedora
  sudo make install-manual
  sudo make install-config
  sudo make install-systemd
  sudo systemctl enable emptty.service
}

# install lua 5.1, luajit, and luarocks
lua() {
  # lua
  sudo dnf install -y readline readline-devel
  cd ~/builds || exit
  curl -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
  tar xzfv lua-5.1.5.tar.gz
  cd lua-5.1.5 || exit
  sudo make linux 
  make test
  sudo make install
  cd ~/builds || exit
  rm lua-5.1.5.tar.gz

  # luajit
  luajit_latest_version=$(curl -sL https://api.github.com/repos/luajit/luajit/tags | jq -r '.[0].name' | cut -c 2-)
  luajit_latest_filename="LuaJIT-$luajit_latest_version"
  luajit_url="https://luajit.org/download/$luajit_latest_filename.tar.gz"
  curl -R -O "$luajit_url"
  tar zxvpf "$luajit_latest_filename.tar.gz"
  cd "$luajit_latest_filename" || exit
  make && sudo make install
  sudo ln -sf "luajit_latest_filename" /usr/local/bin/luajit
  cd ~/builds || exit
  rm "$luajit_latest_filename"

  # luarocks
  luarocks_latest_version=$(curl -sL https://api.github.com/repos/luarocks/luarocks/tags | jq -r '.[0].name' | cut -c 2-)
  luarocks_latest_filename="luarocks-$luarocks_latest_version.tar.gz"
  luarocks_url="https://luarocks.github.io/luarocks/releases/$luarocks_latest_filename.tar.gz"
  curl -R -O "$luarocks_url"
  tar zxvpf "$luarocks_latest_filename"
  cd "$luarocks_latest_filename" || exit
  ./configure && make && make install
  cd ~/builds || exit
  rm "$luarocks_latest_filename"
}

# install homebrew/linuxbrew
homebrew() {
  # homebrew/linuxbrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # https://docs.brew.sh/Analytics#opting-out
  brew analytics off
}

# install all programming languages and programming language runtimes that i will need
programming_languages() {
  # golang with "stefanmaric/g" version manager
  curl -sSL https://git.io/g-install | sh -s

  # rust/rustup/cargo
  
  # nodejs/npm with 'nodenv' version manager
  if [ ! -d "$HOME/.nodenv" ]; then
    # install node & nodenv if not already here
    # we need a system-wide node version from homebrew, so that we can globally install npm binaries
    # like language servers, yarn/pnpm, etc down below and have them persist across versions
    brew install node nodenv
  fi

  # deno
  curl -fsSL https://deno.land/install.sh | sh

  # call lua function
  lua
}

# packages
dnf_packages() {
  # https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/
  # free rpm repos
  sudo dnf install -y \
      "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
  # nonfree rpm repos
  sudo dnf install -y \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

  sudo dnf install -y \
    battray \
    blueman \
    discord \
    dunst \
    flameshot \
    gstreamer1-plugin-openh264 \
    imwheel \
    keychain \
    kitty \
    lxappearance \
    mozilla-openh264 \
    NetworkManager \
    NetworkManager-tui \
    NetworkManager-wifi \
    mpv \
    nitrogen \
    papirus-icon-theme \
    pavucontrol \
    pasystray # https://github.com/christophgysin/pasystray \
    picom \
    pip \
    playerctl \
    python3 \
    python3-xlib \
    qalculate \
    rofi \
    vim \
    xclip \
    xdotool \
    xev \
    xinput \
    xprop \
    xset \
    xsetroot

  # https://docs.fedoraproject.org/en-US/quick-docs/openh264/
  # h264 codec for firefox
  sudo dnf config-manager --set-enabled fedora-cisco-openh264
  sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
  # Afterwards you need open Firefox, go to menu → Add-ons → Plugins and enable OpenH264 plugin.
}

spotify() {
  sudo dnf install lpf-spotify-client -y
  # logout after adding yourself to the proper usermod group
  lpf update
}

homebrew_packages() {
  brew bundle install --file "$HOME/dotfiles/Brewfile"
}

# rofi calculator plugin with qalculate
rofi_calc() {
  sudo dnf install -y rofi-devel qalculate
  cd ~/builds || exit
  git clone https://github.com/svenstaro/rofi-calc.git
  cd rofi-calc || exit
  autoreconf -i
  mkdir build
  cd build/ || exit
  ../configure
  make
  sudo make install
  libtool --finish /usr/lib64/rofi/
  cd ~/builds || exit
}

# https://brave.com/linux/#release-channel-installation
brave_browser() {
  sudo dnf install dnf-plugins-core
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install brave-browser
}

# https://support.1password.com/install-linux/#centos-fedora-or-red-hat-enterprise-linux
1password() {
  sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
  sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
  sudo dnf install 1password -y
}

# https://zoom.us/support/download
zoom() {
  cd ~/downloads || exit
  wget https://zoom.us/client/latest/zoom_x86_64.rpm
  sudo dnf install -y zoom_x86_64.rpm
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
  sudo yum -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl
  git clone https://github.com/neovim/neovim
  cd ~/builds/neovim || exit
  git checkout stable
  git pull
  make distclean
  make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/nvim"
  sudo make install
  cd ~/builds || exit
}

keyd() {
  sudo dnf install python3 python3-xlib
  cd ~/builds || exit
  git clone https://github.com/rvaiya/keyd
  cd keyd || exit
  make && sudo make install
  rm -rf /etc/keyd
  ln -s /home/smithbm/dotfiles/keyd /etc/keyd
  systemctl enable keyd && systemctl start keyd
}

warpd() {
  sudo dnf install libXi-devel \
    libXinerama-devel \
    libXft-devel \
    libXfixes-devel \
    libXtst-devel \
    libX11-devel \
    cairo-devel \
    libxkbcommon-devel \
    libwayland-client \
    wayland-devel
  cd ~/builds || exit
  git clone https://github.com/rvaiya/warpd
  cd warpd || exit
  make && sudo make install
}

# https://charm.sh
charm_sh() {
  # add charm.sh's fedora repositories
  echo '[charm]
  name=Charm
  baseurl=https://repo.charm.sh/yum/
  enabled=1
  gpgcheck=1
  gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
  sudo dnf install glow gum skate
}

# if ~/builds dir doesn't exist, make it
echo "Creating the '~/builds' directory for manual in $USER's home directory"
mkdir -pv ~/builds
# then move into it
cd ~/builds || exit

if [ "$(command -v dnf)" ]; then
  homebrew
  homebrew_packages
  dnf_packages
  programming_languages

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
  sudo luarocks install luacheck
  # teal and cyan (teal build system)
  sudo luarocks install tl
  sudo luarocks install cyan

  # ------------------------------------------------------------
  # NODE/NPM/YARN/PNPM PACKAGES
  # ------------------------------------------------------------
  # global npm packages
  # make sure to use the system version of node in order to install the global binaries here
  # https://github.com/nodenv/nodenv/issues/183
  NODENV_VERSION=system npm i -g \
    # language servers for neovim (lsp)
    @astrojs/language-server \
    @prisma/language-server \
    @tailwindcss/language-server \
    bash-language-server \
    graphql \
    graphql-language-service-cli \
    stylelint-lsp \
    tree-sitter-cli \
    typescript \
    typescript-language-server \
    vim-language-server \
    vscode-langservers-extracted \
    yaml-language-server \
    # prettier daemon
    @fsouza/prettierd \
    # rustywind for tailwind formatting
    rustywind \
    # tree-sitter-cli to complile the Teal Treesitter binary in Neovim
    tree-sitter-cli \
    # yarn
    yarn
    # pnpm
    pnpm

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
  sudo luarocks install --dev teal-language-server

  # marksman markdown server
  mkdir ~/.local/bin
  marksman_appimage=$(gh_release_latest 'artempyanykh/marksman' 'marksman-linux')
  chmod +x "$marksman_appimage"
  mv -v "$marksman_appimage" "$HOME/.local/bin/marksman"

  # vscodium
  rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
  sudo dnf install -y codium

  # github cli (gh)
  # all distro options: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install -y gh

  # splatmoji
  splatmoji_rpm=$(gh_release_latest 'cspeterson/splatmoji' 'rpm')
  sudo dnf install -y "$splatmoji_rpm"
  rm -rf "$splatmoji_rpm"

  # rofi calc
  rofi_calc

  # ------------------------------------------------------------
  # APPIMAGES
  # ------------------------------------------------------------
  mkdir -pv ~/appimages
  cd ~/appimages || exit
  # obsidian
  obsidian_appimage=$(gh_release_latest 'obsidianmd/obsidian-releases' 'Obsidian-[0-9.]+AppImage')
  chmod +x "$obsidian_appimage"
  mv -v "$obsidian_appimage" 'obsidian.AppImage'
  ln -s \
    ~/dotfiles/config/applications/obsidian.desktop \
    ~/.local/share/applications/obsidian.desktop

  # beekeeper-studio
  beekeeper_appimage=$(gh_release_latest 'beekeeper-studio/beekeeper-studio' 'Beekeeper-Studio-[0-9.]+AppImage')
  chmod +x "$beekeeper_appimage"
  mv -v "$beekeeper_appimage" 'beekeeper-studio.AppImage'
  ln -s \
    ~/dotfiles/config/applications/beekeeper-studio.desktop \
    ~/.local/share/applications/beekeeper-studio.desktop

  # docker
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo systemctl start docker
  sudo docker run hello-world
  sudo groupadd docker
  sudo usermod -aG docker "$USER" # give my user docker permissions, logout to take effect

  # ------------------------------------------------------------
  # FONTS
  # ------------------------------------------------------------
  mkdir -pv ~/.local/share/fonts
  mkdir -pv ~/downloads
  cd ~/downloads || exit

  # BlexMono nerd font
  gh_release_latest 'ryanoasis/nerd-fonts' 'IBMPlexMono.zip'
  mkdir -pv ~/.local/share/fonts/BlexMono
  unzip -d ~/.local/share/fonts/BlexMono IBMPlexMono.zip
  rm IBMPlexMono.zip

  # inter font
  inter_zipfile=$(gh_release_latest 'rsms/inter' 'Inter')
  mkdir -pv ~/.local/share/fonts/Inter
  unzip -d ~/.local/share/fonts/Inter "$inter_zipfile"
  rm "$inter_zipfile"

  # GTK THEME
  # rose pine moon
  mkdir -pv ~/.themes
  mkdir -pv ~/.icons
  # gtk3 theme
  rose_pine_gtk3=$(gh_release_latest 'rose-pine/gtk' 'gtk3.tar.gz')
  tar zxvf "$rose_pine_gtk3"
  mv "$rose_pine_gtk3/rose-pine-moon-gtk" ~/.themes
  rm -rf gtk3
  # gtk4 theme
  rose_pine_gtk4=$(gh_release_latest 'rose-pine/gtk' 'gtk4.tar.gz')
  tar zxvf "$rose_pine_gtk4"
  mv "$rose_pine_gtk4/rose-pine-moon.css" "$XDG_CONFIG_HOME/gtk-4.0/gtk.css"
  rm -rf gtk4
  # icons
  rose_pine_icons=$(gh_release_latest 'rose-pine/gtk' 'rose-pine-moon-icons.tar.gz')
  tar zxvf "$rose_pine_icons"
  mv "$rose_pine_icons/rose-pine-moon-icons" ~/.icons
  rm -rf icons

  # elif [ "$(command -v apt)"  ]; then
  # elif [ "$(uname -s)" = "Darwin" ]; then
fi
