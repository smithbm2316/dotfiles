#!/bin/zsh

# zsh magic :)
setopt AUTO_CD

# auto-complete, use unique date for zcompdump files
autoload -Uz compinit; compinit -d $ZDOTDIR/zcompdump/zcompdump-"$(date +%FT%T%z)"
zstyle ':completion:*' menu select
_comp_options+=(globdots)  # include hidden files in autocomplete

# VIM POWAHHH
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
# Use C-p and C-n to go through shell history in insert mode
bindkey '^P' up-history
bindkey '^N' down-history
# Backwards delete word in insert mode
bindkey '^w' backward-kill-word
# Edit current shell command in neovim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Source cursor.zsh file for loading beam/bar cursor settings in zsh
source $ZDOTDIR/scripts/cursor.zsh

##################
# ALIASES
##################

# utility func for testing if commands exist
cmd_exists() {
  command -v $1 >/dev/null 2>&1 && return 0 || return 1
}

# I HAVE THE POWER
iamroot() {
  prevcmd=$(fc -ln -1)
  su -c "$prevcmd"
}

# .. commands
alias ...="../../"
alias ....="../../../"
alias .....="../../../../"
alias ......="../../../../../"
alias .......="../../../../../../"
alias ........="../../../../../../../"
alias .........="../../../../../../../../"

# apt
aptup() {
  sudo apt update
  apt list --upgradeable | rg --color=never -o '^[A-Za-z0-9-_.]*' | sed ':a;$!N;s/\n/, /;ta;P;D' -
  [ ! -z $@ ] && sudo apt upgrade
}

# take command
take() {
  mkdir $1 && cd $1
}

# yeet something into nonexistence
alias yeet="rm -rf"

# pandoc shortcuts
pandocHardBreak() {
  pandoc $1 --from markdown+hard_line_breaks -o $2
}

# browser-sync shortcut
alias bsync="browser-sync start --server --files '*.css, *.html, *.js' --no-open"

# lsd aliases
alias ls='lsd'
alias lsl='lsd -lA'
alias l='lsd -A'

# mv and cp and mkdir improvements
alias mv='mv -iv'
alias cp='cp -iv'
alias mkdir='mkdir -pv'
mkd(){ mkdir -pv $1 && cd $1 }

# use fzf to open a directory somewhere nested after $HOME
c() {
  cd "$(fd -t d --color=never . "$HOME" | fzf --preview='tree -L 1 -I {}')"
  cmd_exists lsd && lsd -A || ls -A
}

# open a specific dotfile in neovim, or vim if neovim isn't installed
dots() {
  file_loc="$(fd -t f --color=never . "$HOME/dotfiles" | fzf --preview='head -80 {}')"
  cmd_exists nvim && nvim "$file_loc" -c 'cd ~/dotfiles' || vim "$file_loc"
}

# open a file in neovim with fzf from current dir
f() {
  file_to_open="$(fzf --preview="head -80 {}")"
  [ -f "$(pwd)/$file_to_open" ] && nvim "$file_to_open"
}

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

# lazygit shortcut
alias lg="lazygit"

# git alias
g() {
  if [[ "$#" == 0 ]]; then
    git
  elif [[ "$1" == "sync" ]]; then
    curr_branch="$(git branch --show-current)"
    def_branch="$(git branch -r | sed -nr "s/\s*upstream.(.*)/\1/p")"
    git fetch upstream
    git switch "$def_branch"
    git pull
    git merge "upstream/$def_branch"
    git push "origin/$def_branch"
    git switch "$curr_branch"
  else
    git "$@"
  fi
}

# cf stow helper
cf() { eval "$HOME/dotfiles/scripts/cf.sh $@" }

# shortcuts for shell configs
shl() {
  cmd="nvim ~/.config/zsh/file -c 'cd ~/.config/zsh'"
  if [[ $# == 0 ]]; then
    zsh
  elif [[ $1 == "rc" ]]; then
    eval ${cmd/file/.zshrc}
  elif [[ $1 == "env" ]]; then
    eval ${cmd/file/.zshenv}
  elif [[ $1 == "hist" ]]; then
    eval ${cmd/file/.zhistory}
  elif [[ $1 == "scripts" ]]; then
    eval ${cmd/file/scripts}
  elif [[ $1 == "." ]]; then
    source $ZDOTDIR/.zshrc
  else
    echo "Invalid usage of shl command"
  fi
}

# watch a youtube video or twitch vod with mpv
vod() {
  mpv "$(xclip -sel clip -o)"
}

# short command for dumping links quickly and easily
dump() {
  if [[ $# == 0 ]]; then
    ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -
    echo -n "Dump to file: "
    read dumpfile
    echo -n "Link: "
    read link
    echo -n "Title: "
    read title
    echo "- [$title]($link)" >> ~/code/braindump/$dumpfile.md
    echo "Dumped successfully! Get back to work punk!"
  elif [[ $1 == "r" ]]; then
    files="$(ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -)"
    i=1

    echo -n "Dump all to same file? (y/n): "
    read samefile
    dumpfile=""

    while [ $i -gt 0 ]; do
      if [[ $samefile == "n" || $i == 1 ]]; then
        echo $files
        echo -n "Dump to file: "
        read dumpfile
        ((i++))
      fi
      echo -n "Link: "
      read link
      [[ $link == "done" ]] && break
      echo -n "Title: "
      read title
      echo "- [$title]($link)" >> ~/code/braindump/$dumpfile.md
      echo "Dumped successfully, onto the next link!"
    done
  elif [[ $1 == "o" ]]; then
    ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -
    echo -n "Which file to open: "
    read dumpfile
    nvim ~/code/braindump/$dumpfile.md -c "cd ~/code/braindump"
  else
    echo "Choose a valid option: no args, (o)pen, (r)epeat"
  fi
}

# for running npm or yarn scripts without remembering which package manager i'm using
js() {
  if [ -f "package-lock.json" ]; then npm run $@
  elif [ -f "yarn.lock" ]; then yarn run $@
  else echo "No npm or yarn project found"
  fi
}

# nvim aliases 
nv() {
  if [[ $# == 0 ]]; then
    nvim
  else
    local nvim_config_path="nvim ~/.config/nvim/lua/my/filedir -c 'cd ~/.config/nvim'"

    if [[ $1 == "plug" ]]; then
      eval ${nvim_config_path/filedir/plugins.lua}
    elif [[ $1 == "plugs" ]]; then
      eval ${nvim_config_path/filedir/plugs/init.lua}
    elif [[ $1 == "maps" ]]; then
      eval ${nvim_config_path/filedir/maps.lua}
    elif [[ $1 == "sets" ]]; then
      eval ${nvim_config_path/filedir/settings.lua}
    else
      nvim $@
    fi
  fi
}
# shortcut to get to packer plugins directory
alias nvpack="cd ~/.local/share/nvim/site/pack/packer/start"
alias nvs="nvim -S"

# OBS virtual cam using v4l2loopback 
alias vcam="sudo modprobe v4l2loopback video_nr=7 card_label='OBS Virtual Cam'"

# Tmux
alias tmls='tmux list-sessions'
tma() {
  if [ -z $@ ]; then
    tmux attach
  else
    tmux attach -t $@
  fi
}
tmks() {
  if [ -z $@ ]; then
    tmux kill-server
  else
    tmux kill-session -t $1
  fi
}
# tmux new session command
tmn() {
  tmux new-session -s $@
}
# tmux new project command
tmnp() {
  tmux \
    new -c $2 -n code -s $1 \; \
    send 'nvim' C-m \; \
    neww -c $2 -n serve \; \
    splitw -h -c $2 -t serve \; \
    send 'js dev' C-m
}

# Source zshrc
alias sosh='source $ZDOTDIR/.zshrc'

# Prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%F{#74dfc4} %b %F{#ffe261}%u%F{#b381c5}%c %F{#40b4c4} %r/%S'
# staged:   unstaged: ﯇  
PROMPT="%F{#eb64b9}%1/ %B%F{#b381c5}$%f%b "
RPROMPT=\$vcs_info_msg_0_

##################
# PLUGINS
##################

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Load zsh-autosuggestions plugin
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting plugin
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
