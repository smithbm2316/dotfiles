#!/bin/bash

USER_OS=$(awk -F = '$1=="ID" { print $2 ;}' /etc/os-release)
echo "This is a $USER_OS Linux system"

emptty() {
  sudo dnf install -y pam \
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
  tar zxpfv lua-5.1.5.tar.gz
  cd lua-5.1.5 || exit
  sudo make linux 
  make test
  sudo make install
  cd ~/builds || exit
  rm -rf lua-5.1.5.tar.gz

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
  luarocks_latest_filename="luarocks-$luarocks_latest_version"
  luarocks_url="https://luarocks.github.io/luarocks/releases/$luarocks_latest_filename.tar.gz"
  curl -R -O "$luarocks_url"
  tar zxvpf "$luarocks_latest_filename.tar.gz"
  cd "$luarocks_latest_filename" || exit
  ./configure --with-lua-include=/usr/local/include && make && make install
  cd ~/builds || exit
  rm "$luarocks_latest_filename.tar.gz"
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
    autorandr \
    battray \
    blueman \
    discord \
    dunst \
    fish \
    flameshot \
    gstreamer1-plugin-openh264 \
    gcc \
    gcc-c++ \
    imwheel \
    keychain \
    kitty \
    lxappearance \
    make \
    mozilla-openh264 \
    NetworkManager \
    NetworkManager-tui \
    NetworkManager-wifi \
    mpv \
    nitrogen \
    papirus-icon-theme \
    pavucontrol \
    pasystray \
    picom \
    pip \
    playerctl \
    python3 \
    python3-xlib \
    qalculate \
    rofi \
    stow \
    util-linux-user \
    vim-minimal \
    vim-enhanced \
    wl-clipboard \
    xclip \
    xdotool \
    xev \
    xinput \
    xprop \
    xset \
    xsetroot \
    zsh

  # https://docs.fedoraproject.org/en-US/quick-docs/openh264/
  # h264 codec for firefox
  sudo dnf config-manager --set-enabled fedora-cisco-openh264
  sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
  # Afterwards you need open Firefox, go to menu → Add-ons → Plugins and enable OpenH264 plugin.
}

spotify() {
  # sudo dnf install lpf-spotify-client -y
  # # logout after adding yourself to the proper usermod group
  # lpf update
  sudo flatpak install flathub com.spotify.Client
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
  sudo dnf install -y dnf-plugins-core
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install -y brave-browser
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
  sudo dnf install -y python3 python3-xlib
  cd ~/builds || exit
  git clone https://github.com/rvaiya/keyd
  cd keyd || exit
  make && sudo make install
  rm -rf /etc/keyd
  ln -s /home/smithbm/dotfiles/keyd /etc/keyd
  systemctl enable keyd && systemctl start keyd
}

warpd() {
  sudo dnf install -y libXi-devel \
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
  sudo dnf install -y glow gum skate
}

# https://github.com/ungoogled-software/ungoogled-chromium
ungoogled_chromium() {
  flatpak install com.github.Eloston.UngoogledChromium
  # give flatpak permission to read GTK themes from the GTK ~/.themes directory
  # sudo flatpak override --filesystem="$HOME/.themes"
  # sudo flatpak override --env=GTK_THEME=rose-pine-moon-gtk
}

bitwarden() {
  # bw cli
  npm i -g @bitwarden/cli
  # linux desktop app
  # https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=appimage
}

qtile() {
  sudo dnf install -y \
    python3-cffi \
    python3-cairocffi \
    python3-dbus-next \
    pango \
    python3-xcffib
  pip install --no-cache-dir cairocffi
  # get .desktop file from https://raw.githubusercontent.com/qtile/qtile/master/resources/qtile.desktop
  # and overwrite the `qtile start` part with the location of the qtile binary, and put it in
  # /usr/share/xsessions folder
  pip install qtile
  # widget dependencies
  pip install psutil dbus-next
} 

ssh_keygen() {
  cd ~/.ssh || exit

  echo "Enter your email for the ssh key:"
  read -r email
  echo "Enter the name for your key (will be saved to ~/.ssh):"
  read -r key_name

  ssh-keygen -t ed25519 -C "$email" -f "$key_name"
  copy_cmd=""

  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if [ "$(command -v wl-copy)" ]; then
      copy_cmd="wl-copy"
    else
      echo "Couldn't find 'wl-copy', please try installing it"
      exit
    fi
  else
    if [ "$(command -v xclip)" ]; then
      copy_cmd="xclip -sel clip"
    else
      echo "Couldn't find 'xclip', please try installing it"
      exit
    fi
  fi

  "$copy_cmd" < "$HOME/.ssh/$key_name.pub" \
    && echo "Copied public key for $key_name to clipboard" \
    || exit
  
  cd - || exit
}

# set a bunch of gnome keybindings and settings
gnome() {
  # equivalent of `xset r rate 250 25` in Xorg
  gsettings set org.gnome.desktop.peripherals.keyboard delay 250
  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25

  # gsettings list-recursively | grep -i "<Super>o"
  # https://askubuntu.com/questions/1179858/disable-orientation-lock-shortcut-super-o-in-ubuntu-18-04-gnome
  # turn off orientation rotation key for Super + O shortcut
  gsettings set org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static "[]"
  # so that you can set your "search" shortcut to Super + O
  gsettings set org.gnome.settings-daemon.plugins.media-keys search '["<Super>o"]'

  gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>w']"
  gsettings set org.gnome.desktop.wm.keybindings maximize "[]"
  gsettings set org.gnome.mutter center-new-windows true

  gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Super>j']"
  gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "['<Super>k']"

  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>a']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>s']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>d']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>f']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>g']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Control><Super>a']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Control><Super>s']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Control><Super>d']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Control><Super>f']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Control><Super>g']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>comma']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>semicolon']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Super>comma']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Super>semicolon']"
  gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"
  gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>h']"
  gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>l']"
  gsettings set org.gnome.shell.keybindings screenshot "['Print']"
  gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Super>Print']"
  gsettings set org.gnome.shell.keybindings show-screen-recording-ui "['<Control><Super>Print']"
  gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>n']"
  gsettings set org.gnome.shell.keybindings focus-active-notification "['<Control><Super>n']"

  gsettings set org.gnome.desktop.wm.keybindings close "['<Super>c']"
  gsettings set org.gnome.desktop.wm.preferences audible-bell false
  gsettings set org.gnome.desktop.wm.preferences visual-bell true
  gsettings set org.gnome.desktop.wm.preferences visual-bell-type "fullscreen-flash"

  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Super>h']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Super>l']"
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
    @astrojs/language-server \
    @prisma/language-server \
    @tailwindcss/language-server \
    bash-language-server \
    cssmodules-language-server \
    graphql \
    graphql-language-service-cli \
    stylelint-lsp \
    svelte-language-server \
    tree-sitter-cli \
    typescript \
    typescript-language-server \
    vim-language-server \
    vscode-langservers-extracted \
    yaml-language-server \
    @fsouza/prettierd \
    tree-sitter-cli \
    yarn \
    pnpm \
    fixjson

  # sqls
  go install github.com/lighttiger2505/sqls@latest

  # pylsp
  pip install python-lsp-server

  # gopls language server
  go install golang.org/x/tools/gopls@latest

  # sumneko_lua language server
  brew install lua-language-server

  # teal language server
  sudo luarocks install --dev teal-language-server

  # proselint for linting prose/markdown
  sudo dnf install -y proselint

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
  mkdir -pv ~/.local/share/fonts/BlexMonoNF
  unzip -d ~/.local/share/fonts/BlexMonoNF IBMPlexMono.zip
  rm IBMPlexMono.zip

  # JetBrainsNF nerd font
  gh_release_latest 'ryanoasis/nerd-fonts' 'JetBrainsMono.zip'
  mkdir -pv ~/.local/share/fonts/JetBrainsMonoNF
  unzip -d ~/.local/share/fonts/JetBrainsMonoNF JetBrainsMono.zip
  rm JetBrainsMono.zip

  # SpaceMono nerd font
  gh_release_latest 'ryanoasis/nerd-fonts' 'SpaceMono.zip'
  mkdir -pv ~/.local/share/fonts/SpaceMonoNF
  unzip -d ~/.local/share/fonts/SpaceMonoNF SpaceMono.zip
  rm SpaceMono.zip

  # UbuntuNF nerd font
  gh_release_latest 'ryanoasis/nerd-fonts' 'Ubuntu.zip'
  mkdir -pv ~/.local/share/fonts/UbuntuNF
  unzip -d ~/.local/share/fonts/UbuntuNF Ubuntu.zip
  rm Ubuntu.zip

  # UbuntuMonoNF nerd font
  gh_release_latest 'ryanoasis/nerd-fonts' 'UbuntuMono.zip'
  mkdir -pv ~/.local/share/fonts/UbuntuMonoNF
  unzip -d ~/.local/share/fonts/UbuntuMonoNF UbuntuMono.zip
  rm UbuntuMono.zip

  # iA-Writer nerd font
  gh_release_latest 'ryanoasis/nerd-fonts' 'iA-Writer.zip'
  mkdir -pv ~/.local/share/fonts/iA-WriterNF
  unzip -d ~/.local/share/fonts/iA-WriterNF iA-Writer.zip
  rm iA-Writer.zip

  # inter font
  inter_zipfile=$(gh_release_latest 'rsms/inter' 'Inter')
  mkdir -pv ~/.local/share/fonts/Inter
  unzip -d ~/.local/share/fonts/Inter "$inter_zipfile"
  rm "$inter_zipfile"

  # GTK THEME
  # rose pine moon
  mkdir -pv ~/.themes
  mkdir -pv ~/.icons
fi
