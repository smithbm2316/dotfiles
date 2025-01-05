#!/usr/bin/env sh
# install homebrew to the default location
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# set up vars for the brew's install dir and the brew binary
brew_home_dir="/home/linuxbrew/.linuxbrew"
brew="$brew_home_dir/bin/brew"

# https://docs.brew.sh/Analytics#opting-out
$brew analytics off
# install dependencies checked into my dotfiles repo's Brewfile
$brew bundle install --file $HOME/dotfiles/bootstrap/linux/Brewfile
# install fzf keybindings and completions for zsh
$brew_home_dir/opt/fzf/install --xdg --key-bindings --completion \
  --no-update-rc --no-fish --no-bash
