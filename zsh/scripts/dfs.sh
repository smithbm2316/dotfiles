#!/bin/sh

######################################################################
#
#  Automation script for running tmux for working on the DFS codebase
#  
#  setup web window with neovim
#  setup api window with neovim
#  setup servers window
#  start front-end server in top-left
#  start storybook server in top-right
#  start backend api server in bottom-left
#  launch scratch terminal in bottom-right
#  change layout of servers window to tiled to space everything evenly
#
#######################################################################

# Check if tmux already has dfs session running
if [ "$(tmux list-sessions | rg -o dfs)" = "dfs" ]; then
  tmux attach -t dfs
# start a fresh instance of the dfs session :)
else
  dirweb=~/code/uci/dfs/web
  dirapi=~/code/uci/dfs/api
  tmux \
    new -c $dirweb -n web -s dfs \; \
    send 'nvim -S' C-m \; \
    neww -c $dirapi -n api \; \
    send 'nvim -S' C-m \; \
    neww -c $dirweb -n servers \; \
    send 'yarn dev' C-m \; \
    splitw -h -c $dirapi -t servers \; \
    send 'yarn dev' C-m
fi
    # splitw -c $dirweb -t servers \; \
    # send 'yarn storybook-nop' C-m \; \
    # splitw -c $dirapi -t servers \; \
    # selectl tiled
