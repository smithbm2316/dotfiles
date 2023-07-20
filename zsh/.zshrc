# automatically cd into a directory without the cd command
setopt autocd
setopt extendedglob
setopt nomatch
setopt notify
setopt prompt_subst
# don't write duplicate events to history file
setopt HIST_SAVE_NO_DUPS

# Push the current directory visited on the stack.
setopt AUTO_PUSHD
# Do not store duplicates in the stack.
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd.
setopt PUSHD_SILENT

# https://thevaluable.dev/zsh-install-configure-mouseless/
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

# load zsh completions
autoload -Uz compinit; compinit

# add completions for hidden/dot files
# and load my custom prompt
_comp_options+=(globdots)
fpath=("$XDG_CONFIG_HOME/zsh" $fpath)
autoload -Uz prompt; prompt
# load vim bindings
autoload -Uz vim-bindings; vim-bindings

# add support for zsh completions via 
fpath=("$XDG_CONFIG_HOME/zsh/plugins/zsh-completions/src" $fpath)

# add support for fish-style abbreviations in zsh
# typeset -A ZSH_HIGHLIGHT_REGEXP
# ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main regexp)
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-abbr/zsh-abbr.zsh"
# ZSH_HIGHLIGHT_REGEXP+=('^[[:blank:][:space:]]*('${(j:|:)${(k)ABBR_REGULAR_USER_ABBREVIATIONS}}')$' fg=green)
# ZSH_HIGHLIGHT_REGEXP+=('\<('${(j:|:)${(k)ABBR_GLOBAL_USER_ABBREVIATIONS}}')$' fg=blue)

# load fzf completions & keybindings
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# load zsh syntax highlighting
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
