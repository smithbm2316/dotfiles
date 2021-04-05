function fish_user_key_bindings
  fish_vi_key_bindings insert
end

set fish_greeting ""

if test -f "/etc/debian_version"
  eval (keychain --eval --quiet id_ed25519_gh id_ed25519_gl)
  alias bat="batcat"
  set -x MANPAGER "nvim -c 'set ft=man' -"
  alias fd="fdfind"
  alias cal="ncal -b"
else if (uname) = "Darwin"
  eval (keychain --eval --quiet id_rsa id_rsa_gl)
end

# I HAVE THE POWER
function IAMROOT
  set prevcmd (fc -ln -1)
  su -c $prevcmd
end

# .. commands
alias ...="../../"
alias ....="../../../"
alias .....="../../../../"
alias ......="../../../../../"
alias .......="../../../../../../"
alias ........="../../../../../../../"
alias .........="../../../../../../../../"

# apt
function aptup
  sudo apt update
  apt list --upgradeable | rg --color=never -o '^[A-Za-z0-9-_.]*' | sed ':a;$!N;s/\n/, /;ta;P;D' -
  if test ! -z $@
    sudo apt upgrade
  end
end

# take command
function take
  mkdir $argv[1] && cd $argv[1]
end

# yeet something into nonexistence
alias yeet="rm -rf"

# pandoc shortcuts
function pandocHardBreak
  pandoc $argv[1] --from markdown+hard_line_breaks -o $2
end

# browser-sync shortcut
alias bsync="browser-sync start --server --files '*.css, *.html, *.js' --no-open"

# lsd aliases
alias ls="lsd"
alias lsa="lsd -A"
alias l="lsd -lA"
alias ll="lsd -l"
alias tree="ls --tree -I 'node_modules'"

# mv and cp and mkdir improvements
alias mv="mv -iv"
alias cp="cp -iv"
alias mkdir="mkdir -pv"

# Configuration Files
alias i3c="nvim ~/.config/i3/config +'cd ~/.config/i3'"
alias alac="nvim ~/.config/alacritty/alacritty.yml"
alias awmc="nvim ~/.config/awesome/rc.lua +'cd ~/.config/awesome'"
alias kitc="nvim ~/.config/kitty/kitty.conf  +'cd ~/.config/kitty'"
alias tmc="nvim ~/.config/tmux/tmux.conf"
alias vimc="nvim ~/.config/.vimrc"
alias xinc="nvim ~/.config/x11/xinitrc"
alias xmob="nvim ~/.config/xmonad/xmobar0.hs +'cd ~/.config/xmonad'"
alias xmoc="nvim ~/.config/xmonad/xmonad.hs +'cd ~/.config/xmonad'"

# shortcuts for shell configs
function shl
  set cmd "nvim ~/.config/fish/file -c 'cd ~/.config/fish'"
  if test count $argv = 0
    zsh
  else if test $argv[1] = "c"
    eval ${cmd/file/config.fish}
  else if test $argv[1] = "env"
    eval ${cmd/file/.zshenv}
  else if test $argv[1] = "hist"
    eval ${cmd/file/.zhistory}
  else if test $argv[1] = "scripts"
    eval ${cmd/file/scripts}
  else
    echo "Invalid usage of shl command"
  end
end

alias telecheck="luacheck --config ~/code/neovim/telescope.nvim/.luacheckrc ~/code/neovim/telescope.nvim/lua/telescope/*"

# short command for dumping links quickly and easily
function dump
  if test count $argv = 0
    ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -
    echo -n "Dump to file: "
    read dumpfile
    echo -n "Link: "
    read link
    echo -n "Title: "
    read title
    echo "- [$title]($link)" >> ~/code/braindump/$dumpfile.md
    echo "Dumped successfully! Get back to work punk!"
  else if test $argv[1] = "r"
    set files "(ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -)"
    set i 1

    echo -n "Dump all to same file? (y/n): "
    read samefile
    set dumpfile ""

    while test $i -gt 0
      if test $samefile = "n"
        echo $files
        echo -n "Dump to file: "
        read dumpfile
        ((i++))
      end

      echo -n "Link: "
      read link

      if test $link = "done"
        break
      end

      echo -n "Title: "
      read title
      echo "- [$title]($link)" >> ~/code/braindump/$dumpfile.md
      echo "Dumped successfully, onto the next link!"
    end
  else if test $argv[1] = "o"
    ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -
    echo -n "Which file to open: "
    read dumpfile
    nvim ~/code/braindump/$dumpfile.md -c "cd ~/code/braindump"
  else
    echo "Choose a valid option: no args, (o)pen, (r)epeat"
  end
end

# for running npm or yarn scripts without remembering which package manager i'm using
function js
  if test -f "package-lock.json"
    npm run $@
  else if test -f "yarn.lock"
    yarn run $@
  else
    echo "No npm or yarn project found"
  end
end

# nvim aliases 
function nv
  if test count $argv = 0
    nvim
  else
    local nvim_config_path="nvim ~/.config/nvim/lua/my/filedir -c 'cd ~/.config/nvim'"

    if test $argv[1] = "plug"
      eval ${nvim_config_path/filedir/plugins.lua}
    else if test $argv[1] = "plugs"
      eval ${nvim_config_path/filedir/plugconfigs}
    else if test $argv[1] = "maps"
      eval ${nvim_config_path/filedir/maps.lua}
    else if test $argv[1] = "sets"
      eval ${nvim_config_path/filedir/settings.lua}
    else
      nvim $@
    end
  end
end
# shortcut to get to packer plugins directory
alias nvpack="cd ~/.local/share/nvim/site/pack/packer/start"
alias nvs="nvim -S"

# OBS virtual cam using v4l2loopback 
alias vcam="sudo modprobe v4l2loopback video_nr=7 card_label='OBS Virtual Cam'"

# thefuck alias
eval (thefuck --alias)

# Tmux
alias tmls='tmux list-sessions'
function tma
  if test -z $@
    tmux attach
  else
    tmux attach -t $@
  end
end

function tmks
  if test -z $@
    tmux kill-server
  else
    tmux kill-session -t $argv[1]
  end
end
# tmux new session command
function tmn
  tmux new-session -s $@
end
# tmux new project command
function tmnp
  tmux \
    new -c $2 -n code -s $argv[1] \; \
    send 'nvim' C-m \; \
    neww -c $2 -n serve \; \
    splitw -h -c $2 -t serve \; \
    send 'js dev' C-m
end

# Source fish
alias sosh='source ~/.config/fish/config.fish'
