#!/bin/bash

USER_OS=$(awk -F = '$1=="ID" { print $2 ;}' /etc/os-release)
echo "This is a $USER_OS Linux system"

# install lua 5.1, luajit, and luarocks
lua() {
  # lua
  sudo dnf install -y readline readline-devel
  cd ~/builds || exit
  curl -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
  tar zxpfv lua-5.1.5.tar.gz
  cd lua-5.1.5 || exit
  make linux 
  # make test && make install INSTALL_TOP="$HOME/.local"
  make test && sudo make install
  cd ~/builds || exit
  rm -rf lua-5.1.5.tar.gz

  # luajit
  # should be installed with neovim
  # cd ~/builds || exit
  # git clone https://luajit.org/git/luajit.git
  # cd luajit || exit
  # make PREFIX="$HOME/.local" && make install PREFIX="$HOME/.local"
  # ln -sf "$luajit_latest_filename" "$HOME/.local/bin/luajit"
  # cd ~/builds || exit

  # luarocks
  # luarocks_latest_version=$(curl -sL https://api.github.com/repos/luarocks/luarocks/tags | jq -r '.[0].name' | cut -c 2-)
  # luarocks_latest_filename="luarocks-$luarocks_latest_version"
  # luarocks_url="https://luarocks.github.io/luarocks/releases/$luarocks_latest_filename.tar.gz"
  # curl -R -O "$luarocks_url"
  # tar zxvpf "$luarocks_latest_filename.tar.gz"
  # cd "$luarocks_latest_filename" || exit
  # ./configure \
  #   --prefix="$HOME/.local" \
  #   --with-lua="$HOME/.local" \
  #   --lua-version='5.1'  \
  #   --with-lua-include="$HOME/.local/include" && make && make install
  # cd ~/builds || exit
  # rm "$luarocks_latest_filename.tar.gz"
  cd ~/builds || exit
  git clone https://github.com/luarocks/luarocks.git
  cd luarocks
  ./configure \
    --with-lua="/usr/local" \
    --lua-version='5.1'
  make && sudo make install
  cd ~/builds || exit

  # openresty + nginx + lapis
  cd ~/builds || exit
  openresty_tarball=$(gh_release_latest 'openresty/openresty' 'openresty-[0-9.]+.tar.gz')
  tar zxf "$openresty_tarball"
  openresty_folder="$(echo $openresty_tarball | awk -F '.tar.gz' '{ print $1 }')"
  cd "$openresty_folder"
  ./configure -j2
  make -j2 && sudo make install
  cd ~/builds || exit
  rm "$openresty_tarball"
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

  # deno
  curl -fsSL https://deno.land/install.sh | sh

  # call lua function
  lua

  # install php package manager (composer)
  EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
  then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
  fi

  php composer-setup.php --quiet
  rm composer-setup.php
  mv composer.phar ~/.local/bin/composer

  # setup laravel cli
  composer global require laravel/installer
}

# install these if you are going to use a window manager instead of Gnome/another desktop environment
dnf_packages_wm() {
  sudo dnf install -y \
    autorandr \
    battray \
    dunst \
    flameshot \
    lxappearance \
    nitrogen \
    pavucontrol \
    pasystray \
    picom \
    playerctl \
    qalculate \
    rofi
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
    bluez \
    calibre \
    chromium \
    discord \
    epiphany \
    eza \
    foliate \
    google-chrome-unstable \
    gstreamer1-plugin-openh264 \
    gcc \
    gcc-c++ \
    keychain \
    kitty \
    lynx \
    make \
    mozilla-openh264 \
    neovim \
    NetworkManager \
    NetworkManager-tui \
    NetworkManager-wifi \
    mpv \
    mpv-mpris \
    papirus-icon-theme \
    pip \
    python3 \
    python3-xlib \
    stow \
    util-linux-user \
    vim-minimal \
    vim-enhanced \
    w3m \
    wl-clipboard \
    xclip \
    xdotool \
    xev \
    xinput \
    xprop \
    xset \
    xsetroot \
    zsh

  # add ZDOTDIR environment variable to system so that zsh loads config from my dotfiles
  if [ -e '/etc/zshenv' ]; then
    echo 'export ZDOTDIR="/home/$USER/.config/zsh"' | sudo tee -a /etc/zshenv
  elif [ -e '/etc/zsh/zshenv' ]; then
    echo 'export ZDOTDIR="/home/$USER/.config/zsh"' | sudo tee -a /etc/zsh/zshenv
  else
    echo "Couldn't find /etc/zshenv or /etc/zsh/zshenv to add ZDOTDIR env var to"
  fi

  # https://docs.fedoraproject.org/en-US/quick-docs/openh264/
  # h264 codec for firefox
  sudo dnf config-manager --set-enabled fedora-cisco-openh264
  sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
  # Afterwards you need open Firefox, go to menu → Add-ons → Plugins and enable OpenH264 plugin.
}

spotify() {
  sudo dnf install -y flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak install flathub com.spotify.Client
}

homebrew_packages() {
  brew bundle install --file "$HOME/dotfiles/Brewfile"
  # install fzf keybindings and completions for zsh
  "$(brew --prefix)/opt/fzf/install" --xdg --key-bindings --completion --no-update-rc --no-fish --no-bash
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

keyd() {
  sudo dnf install -y python3 python3-xlib
  cd ~/builds || exit
  git clone https://github.com/rvaiya/keyd
  cd keyd || exit
  make && sudo make install
  sudo rm -rf /etc/keyd
  sudo ln -s /home/smithbm/dotfiles/keyd /etc/keyd
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

# https://github.com/ungoogled-software/ungoogled-chromium
ungoogled_chromium() {
  flatpak install com.github.Eloston.UngoogledChromium
  # give flatpak permission to read GTK themes from the GTK ~/.themes directory
  # sudo flatpak override --filesystem="$HOME/.themes"
  # sudo flatpak override --env=GTK_THEME=rose-pine-moon-gtk
}

ssh_keygen() {
  mkdir -pv ~/.ssh
  cd ~/.ssh || exit

  echo "Enter your email for the ssh key:"
  read -r email
  echo "Enter the name for your key (will be saved to ~/.ssh):"
  read -r key_name

  ssh-keygen -t ed25519 -C "$email" -f "$key_name"
  copy_cmd=""

  if [ "$(uname -s)" = "Darwin" ]; then
    copy_cmd="pbcopy"
  elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
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

# terminal TUI spotify
ncspot() {
  sudo dnf install -y \
    dbus-devel \
    libxcb-devel \
    ncurses-devel \
    openssl-devel \
    pulseaudio-libs-devel

  cd ~/builds || echo "Couldn't find ~/builds"; return 1
  git clone https://github.com/hrkfdn/ncspot
  cd ncspot || echo "Couldn't find ~/builds/ncspot"; return 1
  cargo build --release --features cover
  ln -sf "$HOME/builds/ncspot/target/release/ncspot" "$HOME/.local/bin/ncspot"
}

# https://linuxconfig.org/how-to-install-firefox-developer-edition-on-linux
firefox_dev() {
  cd ~/downloads || exit
  curl --location \
    "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" \
    | tar --extract --verbose --preserve-permissions --bzip2
  mkdir -pv ~/.local
  mv -v firefox ~/.local/firefox-dev
  ln -sv ~/.local/firefox-dev/firefox ~/.local/bin/firefox-dev
  ln -sv ~/dotfiles/config/applications/firefox-dev.desktop ~/.local/share/applications/firefox-dev.desktop
}

stow_dotfiles() {
  cd ~ || exit
  # create all home directories that i use, remove all uppercase original ones
  mkdir -pv appimages \
    books \
    builds \
    code \
    desktop \
    documents \
    downloads \
    games \
    music \
    notes \
    pictures/screenshots \
    public \
    templates \
    videos \
    wiki
  rmdir Desktop \
    Documents \
    Downloads \
    Music \
    Pictures \
    Public \
    Templates \
    Videos

  rm ~/.config/user-dirs.dirs
  # rm ~/.config/user-dirs.locale
  stow -v -t ~/.config dotfiles
  # install git submodules for zsh plugins
  cd ~/dotfiles || exit
  git submodule init
  git submodule update
  cd ~ || exit
}

# if ~/builds dir doesn't exist, make it
echo "Creating the '~/builds' directory for manual in $USER's home directory"
mkdir -pv ~/builds
# then move into it
cd ~/builds || exit

if [ "$(command -v dnf)" ]; then
  # update all packages first before installing the rest
  sudo dnf update

  # volta installs node
  curl https://get.volta.sh | bash

  homebrew
  homebrew_packages
  dnf_packages
  stow_dotfiles
  programming_languages
  keyd
  spotify

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
  # sudo luarocks install tl
  # sudo luarocks install cyan

  # ------------------------------------------------------------
  # NODE/NPM/YARN/PNPM PACKAGES
  # ------------------------------------------------------------
  # global npm packages
  npm i -g \
    @astrojs/language-server \
    @fsouza/prettierd \
    @olrtg/emmet-language-server \
    @tailwindcss/language-server \
    bash-language-server \
    blade-formatter \
    cssmodules-language-server \
    css-variables-language-server \
    custom-elements-languageserver \
    fixjson \
    intelephense \
    pnpm \
    prettier \
    typescript \
    typescript-language-server \
    vim-language-server \
    vscode-langservers-extracted \
    write-good \
    yarn
  
  # phpactor
  curl -Lo phpactor.phar https://github.com/phpactor/phpactor/releases/latest/download/phpactor.phar
  chmod +x phpactor.phar
  mv -iv phpactor.phar ~/.local/bin/phpactor

  # sqls
  go install github.com/sql-server/sqls@latest

  # gopls language server
  go install golang.org/x/tools/gopls@latest

  # templ lsp
  go install github.com/a-h/templ/cmd/templ@latest

  # python - lsp (pyright/python-lsp-server), formatter (blue, djlint), etc
  pip install \
    blue \
    djlint \
    jedi \
    python-lsp-server

  # sumneko_lua language server is installed with Brewfile

  # teal language server
  # sudo luarocks install --dev teal-language-server

  # proselint for linting prose/markdown
  # sudo dnf install -y proselint

  # vscodium
  rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
  sudo dnf install -y codium

  # github cli (gh)
  # all distro options: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
  # sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  # sudo dnf install -y gh

  # splatmoji
  # splatmoji_rpm=$(gh_release_latest 'cspeterson/splatmoji' 'rpm')
  # sudo dnf install -y "$splatmoji_rpm"
  # rm -rf "$splatmoji_rpm"

  # rofi calc
  # rofi_calc

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

  # symbols nerd font
  symbols_nerd_font_zipfile=$(gh_release_latest 'ryanoasis/nerd-fonts' 'NerdFontsSymbolsOnly.zip')
  mkdir -pv ~/.local/share/fonts/SymbolsNerdFont
  unzip -d ~/.local/share/fonts/SymbolsNerdFont "$symbols_nerd_font_zipfile"
  rm "$symbols_nerd_font_zipfile"

  # inter font
  inter_zipfile=$(gh_release_latest 'rsms/inter' 'Inter')
  mkdir -pv ~/.local/share/fonts/Inter
  unzip -d ~/.local/share/fonts/Inter "$inter_zipfile"
  rm "$inter_zipfile"

  # ibm plex mono font
  ibm_plex_mono_zipfile=$(gh_release_latest 'IBM/plex' 'IBM-Plex-Mono.zip')
  mkdir -pv ~/.local/share/fonts/IBM-Plex-Mono
  unzip -d ~/.local/share/fonts/IBM-Plex-Mono "$ibm_plex_mono_zipfile"
  rm "$ibm_plex_mono_zipfile"

  # ibm plex sans font
  ibm_plex_sans_zipfile=$(gh_release_latest 'IBM/plex' 'IBM-Plex-Sans.zip')
  mkdir -pv ~/.local/share/fonts/IBM-Plex-Sans
  unzip -d ~/.local/share/fonts/IBM-Plex-Sans "$ibm_plex_sans_zipfile"
  rm "$ibm_plex_sans_zipfile"

  # GTK THEME
  mkdir -pv ~/.themes
  mkdir -pv ~/.icons
fi
