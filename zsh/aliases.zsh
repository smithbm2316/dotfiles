# ls/exa aliases
if [ -e "$(command -v exa)" ]; then
  alias l="exa --icons -la"
  alias ls="exa --icons"
  alias lsa="exa --icons -a"
  alias tree="exa --icons --tree --all --ignore-glob 'node_modules|.git'"
elif [ -e "$(command -v eza)" ]; then
  alias l="eza --icons -la"
  alias ls="eza --icons"
  alias lsa="eza --icons -a"
  alias tree="eza --icons --tree --all --ignore-glob 'node_modules|.git'"
else
  alias l="ls -lA"
  alias lsa="ls -A"
fi

# go version manager
alias goenv="$GOPATH/bin/g"
