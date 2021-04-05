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
export GOBIN="$HOME/code/go/bin"
export GOPATH="$HOME/code/go"
export LOCALBIN="$HOME/.local/bin"
export YARNBIN="$HOME/.yarn/bin"

# Default env variables that are useful
export EDITOR="nvim"
export VISUAL="nvim"

# Application env variables
export CALIBRE_USE_DARK_PALETTE=1
export FZF_DEFAULT_COMMAND="rg --files ."
export NEXT_TELEMETRY_DISABLED=1
export RANGER_LOAD_DEFAULT_RC=FALSE

# PATH configuration
export PATH="$CARGOBIN:$PATH"
export PATH="$GOBIN:$PATH"
export PATH="$GOEXEC:$PATH"
export PATH="$LOCALBIN:$PATH"
export PATH="$YARNBIN:$PATH"
