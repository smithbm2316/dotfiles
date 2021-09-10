#!/usr/bin/env fish

# XDG defaults
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $HOME/.local/share

# ZSH settings
set -Ux ZDOTDIR $XDG_CONFIG_HOME/zsh
set -Ux HISTFILE $ZDOTDIR/.zhistory
set -Ux HISTSIZE 10000
set -Ux SAVEHIST 10000

# Programming languages and their dependenices
set -Ux CARGOBIN $HOME/.cargo/bin
set -Ux DENO_INSTALL $HOME/.deno/bin
set -Ux GOEXEC /usr/local/go/bin
set -Ux GOBIN $HOME/go/bin
set -Ux GOPATH $HOME/go
set -Ux LOCALBIN $HOME/.local/bin
set -Ux NVIMBIN $HOME/.local/nvim/bin
set -Ux YARNBIN $HOME/.yarn/bin

# Default env variables that are useful
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux MANPAGER "nvim -c 'Man!' -"

# Application env variables
set -Ux CALIBRE_USE_DARK_PALETTE 1
set -Ux FZF_DEFAULT_COMMAND "fd -t f --color=never"
set -Ux FZF_DEFAULT_OPTS '--multi --layout=reverse-list --border=rounded --tabstop=2 --bind ctrl-d:page-down,ctrl-u:page-up'
set -Ux NEXT_TELEMETRY_DISABLED 1
set -Ux RANGER_LOAD_DEFAULT_RC FALSE

# PATH configuration
fish_add_path $CARGOBIN
fish_add_path $DENO_INSTALL
fish_add_path $GOBIN
fish_add_path $GOEXEC
fish_add_path $LOCALBIN
fish_add_path $NVIMBIN
fish_add_path $YARNBIN
