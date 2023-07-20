#! /usr/bin/env sh
start_dir="$(fd -E 'Library' --base-directory "$HOME" | fzf-tmux -xC -w '35%' -h '40%' -p)"
if [ "$?" -ne 130 ]; then
  session_name="$(basename "$start_dir")"
  tmux new-session -d -s "$session_name" -c "$HOME/$start_dir"
  tmux switch-client -t "$session_name"
fi
