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

# load tldr completions
[ -f "$ZDOTDIR/completions/tldr-complete.zsh" ] && source \
  "$ZDOTDIR/completions/tldr-complete.zsh"

# load aliases
autoload -Uz aliases.zsh; aliases.zsh

# load functions
autoload -Uz functions.zsh; functions.zsh

# Linux settings
if [ "$(uname -s)" = "Linux" ]; then
  # Debian settings
  if [ -f /etc/debian_version ]; then
    # Set `bat` as default man pager
    alias bat="batcat"
    # Alias for fd package
    alias fd="fdfind"
    # redefine for debian, where fd is renamed
    export FZF_DEFAULT_COMMAND="fdfind --type f --color=never"
  fi
elif [ "$(uname -s)" = "Darwin" ]; then
  # load ruby and rbenv
  if [ "$(command -v rbenv)" ]; then
    eval "$(rbenv init - zsh)"
  fi

  # update $PATH to use gnu coreutils and commands instead of bsd defaults
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  # echo "On a mac, not linux >:("
fi

# load luarocks if it's installed
if [ "$(command -v luarocks)" ]; then
  eval "$(luarocks path --no-bin)"
fi
# load fzf completions and shortcuts
if [ "$(command -v fzf)" ]; then
  if [ -f '/usr/share/doc/fzf/examples/completion.zsh' ] &&  [ -f '/usr/share/doc/fzf/examples/key-bindings.zsh' ]; then
    source /usr/share/doc/fzf/examples/completion.zsh
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  else
    source <(fzf --zsh)
  fi
fi

# load gitignored commands if it exists
if [ -e "$ZDOTDIR/hidden.zsh" ]; then
  source "$ZDOTDIR/hidden.zsh"
fi

# LOAD LAST
# load zsh syntax highlighting
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# disable auto-cd into directories
unsetopt autocd

# References
# - [Configuring zsh without dependencies - mouseless dev's config + explanation](https://thevaluable.dev/zsh-install-configure-mouseless/)
# - [zsh expansion guide](https://thevaluable.dev/zsh-expansion-guide-example/)
# - [zsh completion guide](https://thevaluable.dev/zsh-completion-guide-examples/)
# - [zsh line editor guide](https://thevaluable.dev/zsh-line-editor-configuration-mouseless/)

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
