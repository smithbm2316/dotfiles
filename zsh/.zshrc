# automatically cd into a directory without the cd command
setopt autocd
setopt extendedglob
setopt nomatch
setopt notify
setopt prompt_subst
# don't write duplicate events to history file
setopt HIST_SAVE_NO_DUPS
# set case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*' menu select
setopt MENU_COMPLETE

# Push the current directory visited on the stack.
setopt AUTO_PUSHD
# Do not store duplicates in the stack.
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd.
setopt PUSHD_SILENT

# https://thevaluable.dev/zsh-install-configure-mouseless/
alias d="dirs -v"
for index ({1..9}) alias "$index"="cd +${index}"; unset index

zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

# load zsh completions
autoload -Uz compinit; compinit

# add completions for hidden/dot files
# and load my custom prompt
_comp_options+=(globdots)
fpath=("$ZDOTDIR" $fpath)
autoload -Uz prompt.zsh; prompt.zsh
# load vim bindings
autoload -Uz vim-bindings.zsh; vim-bindings.zsh

# add support for zsh completions via 
fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)

# add support for fish-style abbreviations in zsh
# typeset -A ZSH_HIGHLIGHT_REGEXP
# ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main regexp)
source "$ZDOTDIR/plugins/zsh-abbr/zsh-abbr.zsh"
# ZSH_HIGHLIGHT_REGEXP+=('^[[:blank:][:space:]]*('${(j:|:)${(k)ABBR_REGULAR_USER_ABBREVIATIONS}}')$' fg=green)
# ZSH_HIGHLIGHT_REGEXP+=('\<('${(j:|:)${(k)ABBR_GLOBAL_USER_ABBREVIATIONS}}')$' fg=blue)

# add auto-suggestions
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey -M viins '^e' autosuggest-accept
bindkey -v '^e' autosuggest-accept

# load fzf completions & keybindings
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# load aliases
autoload -Uz aliases.zsh; aliases.zsh

# load functions
autoload -Uz functions.zsh; functions.zsh

# load my ssh keys on startup
load_ssh_keys() {
  # start up ssh-agent if it's not been started yet
  if [ -z "$(pgrep ssh-agent)" ]; then
    eval "$(ssh-agent -c)"
  fi

  # setup keychain settings if not in tmux and you're in an interactive shell
  if [ -z "$TMUX" ] && [ -o interactive ]; then
    local zsh_cmd="$(command -v zsh)"
    local ls_cmd="$(command -v ls)"
    local keychain_cmd="$(command -v keychain)"
    local ssh_keys="$($ls_cmd ~/.ssh | grep -v -e pub -e known_hosts -e config)"
    # uncomment line below to debug
    echo "SHELL=$zsh_cmd $keychain_cmd --agents ssh --eval --quiet -Q $ssh_keys | source"
    SHELL="$zsh_cmd" "$keychain_cmd" --eval --quiet -Q "$ssh_keys" | source && echo "Loaded $ssh_keys from ~/.ssh"
  fi
}

# Linux settings
if [ "$(uname -s)" = "Linux" ]; then
  # load_ssh_keys

  # Debian settings
  if [ -f /etc/debian_version ]; then
    # Set `bat` as default man pager
    alias bat="batcat"
    # Alias for fd package
    alias fd="fdfind"
    # redefine for debian, where fd is renamed
    export FZF_DEFAULT_COMMAND="fdfind --type f --color=never"
    # Alias for ncal to use normal month formatting
    alias cal="ncal -b"
  fi
elif [ "$(uname -s)" = "Darwin" ]; then
  # setup keychain settings if not in tmux
  # if [ -z $TMUX && status --is-interactive ]; then
    # SHELL=/usr/bin/zsh /usr/local/bin/keychain --eval --quiet -Q gl_vincit gh_vincit gh_personal | source
  # fi

  # update $PATH to use gnu coreutils and commands instead of bsd defaults
  # export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  echo "On a mac, not linux >:("
fi

# load gitignored commands if it exists
if [ -e "$ZDOTDIR/hidden.zsh" ]; then
  source "$ZDOTDIR/hidden.zsh"
fi

# LOAD LAST
# load zsh syntax highlighting
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# References
# - [Configuring zsh without dependencies - mouseless dev's config + explanation](https://thevaluable.dev/zsh-install-configure-mouseless/)
# - [zsh expansion guide](https://thevaluable.dev/zsh-expansion-guide-example/)
# - [zsh completion guide](https://thevaluable.dev/zsh-completion-guide-examples/)
# - [zsh line editor guide](https://thevaluable.dev/zsh-line-editor-configuration-mouseless/)
