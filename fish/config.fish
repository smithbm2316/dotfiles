# TODO: make a fun quote generator here
set fish_greeting
# TODO: set colors and syntax highlighting colors
# https://fishshell.com/docs/current/cmds/set_color.html#cmd-set-color
# https://fishshell.com/docs/current/index.html#variables-color
# TODO: look into custom completion
# https://medium.com/@fabioantunes/a-guide-for-fish-shell-completions-485ac04ac63c

# install fundle if it's not already installed
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
else # load fundle packages
  fundle plugin 'edc/bass'
  fundle plugin 'lilyball/nix-env.fish'
  fundle plugin 'wfxr/forgit'
  
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
abbr -a sosh 'source ~/dotfiles/fish/config.fish'
# shortcut to get to packer plugins directory
abbr -a nvpack 'cd ~/.local/share/nvim/site/pack/packer/start'
# `cd -` alias
abbr -a -- - 'cd -'
# lazygit
abbr -a g lazygit
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
alias cf "$HOME/dotfiles/scripts/cf.sh"
alias stowdots "$HOME/dotfiles/scripts/stowdots.fish"
# ls/exa aliases
if command -v exa &>/dev/null
  alias l 'exa --icons -a'
  alias ls 'exa --icons'
  alias ll 'exa --icons -l'
  alias tree 'exa --icons --tree --all --ignore-glob "node_modules|.git"'
else
  alias l 'ls -lA'
  alias ll 'ls -l'
end
# .. commands
abbr -a ... ../../
abbr -a .... ../../../
abbr -a ..... ../../../../
abbr -a ...... ../../../../../
abbr -a ....... ../../../../../../
abbr -a ........ ../../../../../../../
abbr -a ......... ../../../../../../../../
# nvim
abbr -a nv 'nvim'
abbr -a nvs '/usr/bin/nvim'



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
  $EDITOR $fileloc -c 'cd ~/dotfiles'
end
function f
  set -l file_to_open (fzf --preview='head -80 {}')
  if test -f $PWD/$file_to_open
    $EDITOR $file_to_open
  end
end

# shortcuts for shell configs
function shl
  set -l shlcmd "$EDITOR ~/dotfiles/fish"

  switch $argv
    case 'rc'
      eval "$shlcmd/config.fish"
    case 'env'
      eval "$shlcmd/env.fish"
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
alias tmls='tmux ls'
abbr -a tma 'tmux attach -t '

function tm -a session
  if test -z $session
    tmux attach 2>/dev/null
  else
    tmux attach -t $session 2>/dev/null
  end
  
  if test $status -ne 0
    tmux
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
    tmux \
      new -n code -s (basename $PWD) \; \
      send "$EDITOR" C-m \; \
      neww -n serve \; \
      splitw -h -c $idk -t serve
  else
    tmux new -s $session
  end
end

function tmnp -a session serve_command
  tmux \
    new -n code -s (basename $PWD) \; \
    send "$EDITOR" C-m \; \
    neww -n serve \; \
    splitw -h -c $idk -t serve \; \
    send -c $serve_command C-m
end

function tmns-fzf
  tmux display-popup -E "new-session -c (fd -E 'Library' --base-directory $HOME | fzf)"
end

# git alias
# function g
#   switch $argv
#     case 'sync'
#       set -l curr_branch (git branch --show-current)
#       set -l def_branch (git branch -r | sed -nr "s/\s*upstream.(.*)/\1/p")
#       git fetch upstream
#       git switch $def_branch
#       git pull
#       git merge upstream/$def_branch
#       git push
#       git switch $curr_branch
#     case '*'
#       git $argv
#   end
# end



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
    # SHELL=/usr/bin/fish keychain --eval --quiet -Q id_ed25519_gh | source
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
    SHELL=/usr/bin/fish /usr/local/bin/keychain --eval --quiet -Q gl_vincit gh_vincit gh_personal | source
  end

  # do all of the homebrew things please and update neovim nightly
  alias brewmeup 'brew update; brew upgrade; brew cleanup -s; brew reinstall neovim; brew doctor'

	# update $PATH to use gnu coreutils and commands instead of bsd defaults
	set -p PATH /usr/local/opt/gnu-sed/libexec/gnubin
end
fish_add_path /usr/local/sbin



##################################################
#
# load ssh keys
#
##################################################
function load_ssh_keys
  set -l fish_cmd (command -v fish)
  set -l ls_cmd (command -v ls)
  set -l keychain_cmd (command -v keychain)
  set -l ssh_keys ($ls_cmd ~/.ssh | grep -qv -e pub -e known_hosts -e config)
  echo "SHELL=$fish_cmd $keychain_cmd --agents ssh --eval --quiet -Q $ssh_keys | source"
  SHELL=$fish_cmd $keychain_cmd --eval --quiet -Q $ssh_keys | source
end

if test -z (pgrep ssh-agent | string collect)
  eval (ssh-agent -c)
end
