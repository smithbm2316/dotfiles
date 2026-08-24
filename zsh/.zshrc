setopt extendedglob
# don't enable the zsh glob pattern '^' to negate matches, it messes with the
# common git pattern of using 'HEAD^' for the most recent commit
# https://github.com/ohmyzsh/ohmyzsh/issues/449
unsetopt nomatch
setopt notify
setopt prompt_subst
# don't write duplicate events to history file
setopt HIST_SAVE_NO_DUPS
# set case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*' menu select
setopt MENU_COMPLETE

zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

# my custom prompt
function get_prompt() {
  local user='%B%F{blue}%n%f%b'
  local host_name='%F{magenta}%m%f'
  local cwd='%F{red}%~%f'
  local user_or_superuser='%#'
  local newline=$'\n'
  echo "$user@$host_name:$cwd${newline}$user_or_superuser "
}
PROMPT="$(get_prompt)"

# add completions for hidden/dot files
_comp_options+=(globdots)
fpath=("$ZDOTDIR" $fpath)

# load zsh completions
autoload -Uz compinit; compinit

# load vim bindings if not in a Neovim terminal session
if [ -z "$NVIM" ]; then
  autoload -Uz vim-bindings.zsh; vim-bindings.zsh
fi

# add support for zsh completions via 
fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
if [ -d "$HOME/.docker/completions" ]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

# load fzf completions
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# mise
eval "$($HOME/.local/bin/mise activate zsh)"

# opencode
if command -v opencode &>/dev/null; then
  source <(opencode --completions zsh)
fi

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

# set up directory shortcuts
# https://www.arp242.net/zshrc.html#directory-shortcuts
# hash -d astra=$HOME/work/astra
# hash -d code=$HOME/code
# hash -d dots=$HOME/dotfiles
# hash -d nvim=$HOME/dotfiles/nvim
# hash -d pack=$HOME/.local/share/nvim/site/pack/core/opt
# hash -d notebook=$HOME/notebook
# set up a temporary bookmarked directory aliased to $1
# hashcwd() { hash -d "$1"="$PWD" }

# load aliases
autoload -Uz aliases.zsh; aliases.zsh

# load functions
autoload -Uz functions.zsh; functions.zsh

# load hidden file if exists
if [ -f "$ZDOTDIR/hidden.zsh" ]; then
  autoload -Uz hidden.zsh; hidden.zsh
fi

# load jj completions
if command -v jj &> /dev/null; then
  source <(COMPLETE=zsh jj)
fi

# os-specific adjustments
case "$OSTYPE" in
  darwin*)
    # make sure that gnu coreutils are at the end of $PATH so that they are
    # prioritized over the BSD versions of these utilities on OSX
    # https://gist.github.com/andreajparker/ed3b15fd670caa6e4f7e4da18ce398ac
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/diffutils/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-getopt/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-time/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-units/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnutls/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/man-db/libexec/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/rsync/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/util-linux/bin:$PATH"
    # and do so for latest git too
    export PATH="$HOMEBREW_PREFIX/opt/git/bin:$PATH"

    # and prioritize their respective man paths
    export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/diffutils/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/findutils/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gawk/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gnu-getopt/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gnu-sed/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gnu-tar/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gnu-time/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gnu-units/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gnu-which/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/gnutls/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/grep/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/man-db/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/rsync/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/util-linux/share/man:$MANPATH"
    # and do so for latest git too
    export MANPATH="$HOMEBREW_PREFIX/opt/git/share/man:$MANPATH"
    ;;
  linux*)
    ;;
  *)
    ;;
esac

# LOAD LAST
# load zsh syntax highlighting
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
