# turn on automatic colors for ls
alias ls="ls --color=auto"
alias l="ls --color=auto -lhA"
alias tree="tree -a -I 'node_modules|.git|.venv|venv'"

# alias for "make" that suppresses all output (useful when using as a task runner)
alias mk="make -s"

# better default for fc-list
# https://github.com/danstoner/pandoc_samples/blob/master/fc-list-examples.md
alias fc-families="fc-list : family | cut -f1 -d"," | sort | uniq"

# add all to a wip commit
alias wip="git add . && git commit --no-verify --message 'wip'"

# always use color for grep
alias grep="grep --color=always"

# update dotfiles symlinks if necessary
alias dotsup="cd $HOME && stow -vt ~/.config dotfiles && cd -"
