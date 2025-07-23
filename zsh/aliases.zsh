# ls/exa aliases
if [ -e "$(command -v eza)" ]; then
  alias l="eza --icons -la"
  alias ls="eza --icons"
  alias lsa="eza --icons -a"
  alias tree="eza --icons --tree --all --ignore-glob 'node_modules|.git|.venv|venv'"
elif [ -e "$(command -v exa)" ]; then
  alias l="exa --icons -la"
  alias ls="exa --icons"
  alias lsa="exa --icons -a"
  alias tree="exa --icons --tree --all --ignore-glob 'node_modules|.git|.venv|venv'"
else
  alias ls="ls --color=always"
  alias l="ls --color=always -lA"
  alias lsa="ls --color=always -A"
fi

# go version manager: https://github.com/stefanmaric/g
alias gvm="$GOPATH/bin/g"

# alias for "make" that suppresses all output (useful when using as a task runner)
alias mk="make -s"

# better default for fc-list
# https://github.com/danstoner/pandoc_samples/blob/master/fc-list-examples.md
alias fc-families="fc-list : family | cut -f1 -d"," | sort | uniq"

# add all to a wip commit
alias wip="git add . && git commit --no-verify --message 'wip'"
