# XDG defaults
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$XDG_DATA_HOME"
export XDG_STATE_HOME="$HOME/.local/state"

# ZSH settings
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000

# Programming languages and their dependencies
export BUNBIN="$HOME/.bun/bin"
export CARGOBIN="$HOME/.cargo/bin"
export DENOBIN="$HOME/.deno/bin"
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export GOROOT="$HOME/.go"
export LOCALBIN="$HOME/.local/bin"
export PHPENV_ROOT="/home/smithbm/.phpenv"
export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/prettier/.prettierrc"
export YARNBIN="$HOME/.yarn/bin"

# Default env variables that are useful
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim -u NORC"
export MANPAGER="nvim -u NORC -c 'Man!' -"

# Application env variables
export ABBR_USER_ABBREVIATIONS_FILE="$XDG_CONFIG_HOME/zsh/abbreviations.zsh"
export CALIBRE_USE_DARK_PALETTE=1
export FZF_DEFAULT_COMMAND="fd -t f='--color=never'"
export FZF_DEFAULT_OPTS="--multi --layout=reverse-list --border=rounded --tabstop=2 --bind='ctrl-d:page-down,ctrl-u:page-up'"
export HOMEBREW_NO_ANALYTICS=1
export NEXT_TELEMETRY_DISABLED=1

if [ "$(uname -s)" = "Linux" ]; then
  export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
fi

path+=("$LOCALBIN")
path+=("$GOBIN")
path+=("$BUNBIN")
path+=("$DENOBIN")
path+=("$BUNBIN")
path+=("$CARGOBIN")
path+=("$HOMEBREW_PREFIX/bin")
path+=("$YARNBIN")
