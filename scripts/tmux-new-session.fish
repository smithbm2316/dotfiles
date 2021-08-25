#! /usr/bin/env fish
set -l startdir (fd -E 'Library' --base-directory $HOME | fzf-tmux -p)
if test $status -ne 130
  set -l sessionname (basename $startdir)
  tmux new-session -d -s $sessionname -c "$HOME/$startdir"
  tmux switch-client -t $sessionname
end
