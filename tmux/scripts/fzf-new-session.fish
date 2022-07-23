#! /usr/bin/env fish
# for macos: fd -E 'Library' --base-directory $HOME
set -l startdir (fd --base-directory $HOME | fzf-tmux -xC -w '35%' -h '40%' -p)
if test $status -ne 130
  set -l sessionname (basename $startdir)
  tmux new-session -d -s $sessionname -c "$HOME/$startdir"
  tmux switch-client -t $sessionname
end
