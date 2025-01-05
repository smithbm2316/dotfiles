#!/usr/bin/env bash

sshkg() {
  mkdir -pv ~/.ssh
  cd ~/.ssh || exit

  echo "Enter your comment for the ssh key:"
  read -r comment
  echo "Enter the name for your key (will be saved to ~/.ssh):"
  read -r key_name

  ssh-keygen -t ed25519 -C "$comment" -f "$key_name"

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

# add ssh keys to keychain
mkdir -pv ~/.ssh
cp ~/dotfiles/bootstrap/ssh-default-config ~/.ssh/config

# link dotfiles to ~/.config
brew install stow
stow -vt ~/.config dotfiles

# symlink ~/.zshenv to home dir so that ZDOTDIR is exported early in the loading
# for zsh and it loads all my config from the ~/dotfiles/zsh folder
ln -s ~/dotfiles/zsh/.zshenv ~/.zshenv

# create some directories
mkdir -pv ~/code ~/work

# install homebrew dependencies
brew bundle install --file ~/dotfiles/bootstrap/Brewfile
brew bundle install --file ~/dotfiles/bootstrap/osx/Brewfile

# install node
curl https://get.volta.sh | bash
volta install node
volta install node@latest

npm i -g \
  @olrtg/emmet-language-server \
  @tailwindcss/language-server \
  bash-language-server \
  css-variables-language-server \
  eslint_d \
  fixjson \
  graphql-language-service-cli \
  pnpm \
  prettier \
  typescript \
  typescript-language-server \
  vscode-langservers-extracted \
  write-good \
  yarn

# install odin programming language and its LSP + formatter
mkdir -pv ~/builds
cd ~/builds || exit
git clone https://github.com/DanielGavin/ols.git
cd ols || exit
./build.sh
./odinfmt.sh
mkdir -pv ~/.local/bin
ln -s ~/builds/ols/ols ~/.local/bin/ols
ln -s ~/builds/ols/odinfmt ~/.local/bin/odinfmt
