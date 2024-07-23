#!/usr/bin/sh
if [ "$(command -v apt)" ]; then
  sudo apt install -y tmux
  echo 'Installed tmux!'
else
  echo 'Not on a machine with `apt`, skipping tmux installation...'
  exit 1
fi

# install the tmux plugin manager
# TODO: probably add this as a git submodule like the zsh plugins?
git clone https://github.com/tmux-plugins/tpm ~/dotfiles/tmux/plugins/tpm
echo 'Installed tpm/tmux plugin manager!'
