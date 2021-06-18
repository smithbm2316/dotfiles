#!/bin/zsh

# XDG defaults
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# ZSH settings
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# Programming languages and their dependenices
export CARGOBIN="$HOME/.cargo/bin"
export GOEXEC="/usr/local/go/bin"
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export LOCALBIN="$HOME/.local/bin"
export NVIMBIN="$HOME/.local/nvim/bin"
export YARNBIN="$HOME/.yarn/bin"

# Default env variables that are useful
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim -c 'set ft=man' -"

# Application env variables
export CALIBRE_USE_DARK_PALETTE=1
export FZF_DEFAULT_COMMAND="fd -t f --color=never"
export FZF_DEFAULT_OPTS='--multi --layout=reverse-list --border=rounded --tabstop=2 --bind ctrl-d:page-down,ctrl-u:page-up'
export NEXT_TELEMETRY_DISABLED=1
export RANGER_LOAD_DEFAULT_RC=FALSE

# PATH configuration
export PATH="$CARGOBIN:$PATH"
export PATH="$GOBIN:$PATH"
export PATH="$GOEXEC:$PATH"
export PATH="$LOCALBIN:$PATH"
export PATH="$NVIMBIN:$PATH"
export PATH="$YARNBIN:$PATH"

# Linux settings
if [ "$(uname)" = "Linux" ]; then
  # setup keychain settings if not in tmux
  if [ -z "$TMUX" ]; then
    eval $(keychain --eval --quiet id_ed25519_gh)
  fi

  # Debian settings
  if [ -f "/etc/debian_version" ]; then
    # Set `bat` as default man pager
    alias bat="batcat"
    # Alias for fd package
    alias fd="fdfind"
    # redefine for debian, where fd is renamed
    export FZF_DEFAULT_COMMAND="fdfind --type f --color=never"
    # Alias for ncal to use normal month formatting
    alias cal="ncal -b"
  fi
# Mac settings
elif [ "$(uname)" = "Darwin" ]; then
  # setup keychain settings if not in tmux
  if [ -z "$TMUX" ]; then
    eval $(/usr/local/bin/keychain --eval --quiet id_rsa id_rsa_gl)
  fi
fi

# load luaver
[ -s ~/.luaver/luaver ] && source ~/.luaver/luaver
if [ -e /home/smithbm/.nix-profile/etc/profile.d/nix.sh ]; then . /home/smithbm/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
