# XDG defaults
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$XDG_DATA_HOME:/var/lib/flatpak/exports/share/applications"
export XDG_STATE_HOME="$HOME/.local/state"

# ZSH settings
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000

# Default env variables that are useful
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim --cmd 'lua vim.g.minimal=true' -c 'Man!' -"
# https://wiki.archlinux.org/title/Man_page#Page_width
export MANWIDTH=80

# Application env variables
export ABBR_USER_ABBREVIATIONS_FILE="$XDG_CONFIG_HOME/zsh/abbreviations.zsh"
export ASTRO_TELEMETRY_DISABLED=1
export CALIBRE_USE_DARK_PALETTE=1
export FZF_DEFAULT_COMMAND="fd --type f --color=never"
export FZF_DEFAULT_OPTS="--multi --layout=reverse-list --border=rounded --tabstop=2 --bind='ctrl-d:page-down,ctrl-u:page-up'"
export GLOW_STYLE="$XDG_CONFIG_HOME/glow/catppuccin-macchiato.json"
export GOPROXY=direct
export GOTELEMETRY=off
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export KIT_DISABLE_TELEMETRY=true
export LLM_USER_PATH="$XDG_CONFIG_HOME/io.datasette.llm"
export NEXT_TELEMETRY_DISABLED=1
export OLLAMA_NO_CLOUD=1
export PI_CODING_AGENT_DIR="$HOME/dotfiles/pi"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
export SHOPIFY_CLI_NO_ANALYTICS=1
export STORYBOOK_DISABLE_TELEMETRY=1

if [ "$(uname -s)" = "Linux" ]; then
  export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
elif [ "$(uname -s)" = "Darwin" ]; then
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_REPOSITORY="/opt/homebrew/Homebrew"
fi

path+=("$HOMEBREW_PREFIX/bin")
path+=("$HOME/.local/nvim/bin")
path+=("$HOME/.local/bin")
path+=("$CWD_BIN")
