#!/usr/bin/env sh
# add ZDOTDIR env variable to system so that zsh loads config from my dotfiles
sys_zshenv=""
if [ -e '/etc/zshenv' ]; then
  sys_zshenv='/etc/zshenv'
elif [ -e '/etc/zsh/zshenv' ]; then
  sys_zshenv='/etc/zsh/zshenv'
else
  echo 'Could not find /etc/zshenv or /etc/zsh/zshenv to export $ZDOTDIR from'
  exit 1
fi
echo "export ZDOTDIR=\"/home/$USER/.config/zsh\"" | sudo tee -a "$sys_zshenv"
echo "Exported \$ZDOTDIR from $sys_zshenv successfully"

# update the $USER shell to be zsh
chsh -s "$(which zsh)"
