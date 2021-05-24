# TODO: make a fun quote generator here
set fish_greeting
# TODO: set colors and syntax highlighting colors
# https://fishshell.com/docs/current/cmds/set_color.html#cmd-set-color
# https://fishshell.com/docs/current/index.html#variables-color

# install fundle if it's not already installed
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
else # load fundle packages
  fundle plugin 'edc/bass'
  
  fundle init
end



##################################################
#
# simple abbreviations/aliases
#
##################################################
# OBS virtual cam using v4l2loopback 
abbr -a vcam 'sudo modprobe v4l2loopback video_nr=7 card_label="OBS Virtual Cam"'
# Source fish
abbr -a sosh 'source ~/.config/fish/config.fish'
# shortcut to get to packer plugins directory
abbr -a nvpack 'cd ~/.local/share/nvim/site/pack/packer/start'
# browser-sync
abbr -a bsync "browser-sync start --server --files '*.css, *.html, *.js' --no-open"
# `cd -` alias
abbr -a -- - 'cd -'
# lazygit
abbr -a lg lazygit
# shortcut for `clear` command
abbr -a cl clear
# mv and cp and mkdir improvements
abbr -a mv 'mv -iv'
abbr -a cp 'cp -iv'
abbr -a mkdir 'mkdir -pv'
abbr -a cwd "basename $PWD"
function mkd; mkdir -pv $argv[1] && cd $argv[1]; end
# yeet something into nonexistence
abbr -a yeet 'rm -rf'
# stow helper for dotfiles and cronjobs
abbr -a cf "$HOME/dotfiles/scripts/cf.sh"
# exa aliases
alias l 'exa --icons -a'
alias ls 'exa --icons'
alias ll 'exa --icons -l'
alias lla 'exa --icons -la'
alias tree 'exa --icons --tree --all'
# .. commands
abbr -a ... ../../
abbr -a .... ../../../
abbr -a ..... ../../../../
abbr -a ...... ../../../../../
abbr -a ....... ../../../../../../
abbr -a ........ ../../../../../../../
abbr -a ......... ../../../../../../../../



##################################################
#
# function aliases
#
##################################################
# cd and dots
function c
  cd (fd -t d --color=never . $HOME | fzf --preview='tree -L 1 -I {}')
  ls -a
end
function dots
  set -l fileloc (fd -t f --color=never . $HOME/dotfiles | fzf --preview='head -80 {}')
  nvim $fileloc -c 'cd ~/dotfiles'
end
function f
  set -l file_to_open (fzf --preview='head -80 {}')
  if test -f $PWD/$file_to_open
    nvim $file_to_open
  end
end

# nvim
function nv
  set -l nvstart 'nvim ~/.config/nvim/lua/my'
  set -l nvend '-c "cd ~/.config/nvim"'

  switch $argv
    case 'plug'
      eval "$nvstart/plugins.lua $nvend"
    case 'plugs'
      eval "$nvstart/plugs/init.lua $nvend"
    case 'maps'
      eval "$nvstart/maps.lua $nvend"
    case 'sets'
      eval "$nvstart/settings.lua $nvend"
    case 's'
      nvim -c 'RestoreSession<cr>'
    case '*'
      nvim $argv
  end
end

# shortcuts for shell configs
function shl
  set -l shlcmd 'nvim ~/.config/fish'

  switch $argv
    case 'rc'
      eval "$shlcmd/config.fish"
    case 'env'
      eval "$shlcmd/env"
    case 'hist'
      eval "$shlcmd/history"
    case 'fns'
      eval "$shlcmd/functions"
    case ''
      fish
    case '*'
      echo 'Invalid usage of shl command'
  end
end

# for running npm or yarn scripts without remembering which package manager i'm using
function js
  if test -f 'yarn.lock' && test -f 'package-lock.json'
    echo 'Found both yarn.lock and package-lock.json. Use yarn or npm?'
    read pkgman
    eval "$pkgman run $argv"
  else if test -f 'yarn.lock'
    yarn run $argv
  else if test -f 'package-lock.json'
    npm run $argv
  else
    echo 'No npm or yarn project found'
  end
end

# make tmux easier to use
alias tml='tmux ls'

function tma -a session
  if test -z $session
    tmux attach
  else
    tmux attach -t $session
  end
end

function tmks -a session
  if test -z $session
    tmux kill-server
  else
    tmux kill-session -t $session
  end
end

function tmn -a session
  if test -z $session
    tmux new -s (basename $PWD)
  else
    tmux new -s $session
  end
end

function tmnp -a session serve_command
  tmux \
    new -n code -s (basename $PWD) \; \
    send 'nvim' C-m \; \
    neww -n serve \; \
    splitw -h -c $idk -t serve \; \
    send -c $serve_command C-m
end

# git alias
function g
  switch $argv
    case 'sync'
      set -l curr_branch (git branch --show-current)
      set -l def_branch (git branch -r | sed -nr "s/\s*upstream.(.*)/\1/p")
      git fetch upstream
      git switch $def_branch
      git pull
      git merge upstream/$def_branch
      git push
      git switch $curr_branch
    case '*'
      git $argv
  end
end



##################################################
#
# bash utilities wrapped as functions with bass
#
##################################################
function luaver
  if test -s ~/.luaver/luaver
    bass source ~/.luaver/luaver --no-use ';' luaver $argv
  end
end

# install n for managing nodejs/npm if it's not already installed
# and set the environment variable for it
# https://github.com/mklement0/n-install
if test ! -d ~/n
  curl -L https://git.io/n-install | bash -s -- -n
end
set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"



##################################################
#
# load functions
#
##################################################
# source ~/dotfiles/fish/functions/prompt.fish
# source ~/dotfiles/fish/functions/keybindings.fish
# Set cursor style for different vim modes
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block



##################################################
#
# os-specific settings
#
##################################################
# Linux settings
if test (uname -s) = 'Linux'
  # setup keychain settings if not in tmux
  if test -z $TMUX && status --is-interactive
    SHELL=/usr/bin/fish keychain --eval --quiet -Q id_ed25519_gh | source
  end

  # Debian settings
  if test -f '/etc/debian_version'
    # Set `bat` as default man pager
    alias bat batcat
    # Alias for fd package
    alias fd fdfind
    # redefine for debian, where fd is renamed
    set -Ux FZF_DEFAULT_COMMAND 'fdfind --type f --color=never'
    # Alias for ncal to use normal month formatting
    alias cal 'ncal -b'
  end
else if test (uname -s) = 'Darwin'
  # setup keychain settings if not in tmux
  if test -z $TMUX && status --is-interactive
    SHELL=/usr/bin/fish /usr/local/bin/keychain --eval --quiet -Q id_rsa id_rsa_gl | source
  end
end
