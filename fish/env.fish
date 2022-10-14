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
set -Ux BUN_INSTALL $HOME/.bun
set -Ux BUNBIN $HOME/.bun/bin
set -Ux CARGOBIN $HOME/.cargo/bin
set -Ux DENOBIN $HOME/.deno/bin
set -Ux GOEXEC /usr/local/go/bin
set -Ux GOBIN $HOME/go/bin
set -Ux GOPATH $HOME/go
set -Ux LOCALBIN $HOME/.local/bin
set -Ux PRETTIERD_DEFAULT_CONFIG $HOME/.config/prettier/.prettierrc
set -Ux NVIMBIN $HOME/.local/nvim/bin
set -Ux YARNBIN $HOME/.yarn/bin

# Default env variables that are useful
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux SUDO_EDITOR "nvim -u NORC"
set -Ux MANPAGER "nvim -c 'Man!' -"

# Application env variables
set -Ux I3_BLOCKLETS $XDG_CONFIG_HOME/i3/blocklets
set -Ux CALIBRE_USE_DARK_PALETTE 1
set -Ux FZF_DEFAULT_COMMAND "fd -t f --color=never"
set -Ux FZF_DEFAULT_OPTS '--multi --layout=reverse-list --border=rounded --tabstop=2 --bind ctrl-d:page-down,ctrl-u:page-up'
set -Ux NEXT_TELEMETRY_DISABLED 1
set -Ux RANGER_LOAD_DEFAULT_RC FALSE
set -Ux SRC_ENDPOINT 'https://sourcegraph.com'
set -Ux ZK_NOTEBOOK_DIR $HOME/wiki

if test (uname -s) = 'Linux'
  set -Ux HOMEBREW_CELLAR /home/linuxbrew/.linuxbrew/Cellar
  set -Ux HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
  set -Ux HOMEBREW_REPOSITORY /home/linuxbrew/.linuxbrew/Homebrew
  fish_add_path -a /home/linuxbrew/.linuxbrew/bin
  fish_add_path -a /home/linuxbrew/.linuxbrew/sbin
end

# PATH configuration
fish_add_path -a $BUNBIN
fish_add_path -a $CARGOBIN
fish_add_path -a $DENOBIN
fish_add_path -a $GOBIN
fish_add_path -a $GOEXEC
fish_add_path -a $LOCALBIN
fish_add_path -a $NVIMBIN
fish_add_path -a $YARNBIN
