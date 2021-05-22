set fish_greeting ''

function fish_user_key_bindings
  # vi-style bindings that inherit emacs-style bindings in all modes
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
# Set cursor style for different vim modes
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# yeet something into nonexistence
alias yeet='rm -rf'

# lsd aliases
alias ls='lsd'
alias lsa='lsd -A'
alias l='lsd -lA'
alias ll='lsd -l'
alias tree='ls --tree -I "node_modules"'

# mv and cp and mkdir improvements
alias mv='mv -iv'
alias cp='cp -iv'
alias mkdir='mkdir -pv'

alias nv='nvim'

# shortcuts for shell configs
function shl
  set -l cmd_base 'nvim ~/.config/fish'
  switch $argv
    case ''
      fish
    case 'rc'
      eval "$cmd_base/config.fish"
    case 'env'
      eval "$cmd_base/env"
    case 'hist'
      eval "$cmd_base/history"
    case 'fns'
      eval "$cmd_base/functions"
    case '*'
      echo 'Invalid usage of shl command'
  end
end

# for running npm or yarn scripts without remembering which package manager i'm using
function js
  switch $argv
  case 'package-lock.json'
    npm run $argv
  case 'yarn.lock'
    yarn run $argv
  case '*'
    echo 'No npm or yarn project found'
  end
end

# shortcut to get to packer plugins directory
alias nvpack='cd ~/.local/share/nvim/site/pack/packer/start'

# OBS virtual cam using v4l2loopback 
alias vcam='sudo modprobe v4l2loopback video_nr=7 card_label="OBS Virtual Cam"'

# Source fish
alias sosh='source ~/.config/fish/config.fish'
