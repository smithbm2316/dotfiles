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
abbr -a lg lazygit
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
# pr review helper
alias prr "$HOME/dotfiles/scripts/prr.fish"
# ls/exa aliases
if command -v exa &>/dev/null
  alias l 'exa --icons -la'
  alias ls 'exa --icons'
  alias lsa 'exa --icons -a'
  alias tree 'exa --icons --tree --all --ignore-glob "node_modules|.git"'
else
  alias l 'ls -lA'
  alias lsa 'ls -A'
end
alias ss "ssh -p 23231 hunk-of-junk.local"
alias ytdl youtube-dl
# pactl
alias setvol50 "pactl set-sink-volume @DEFAULT_SINK@ 50%"
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
abbr -a pgnv 'pgrep nvim'
abbr -a nvgui 'neovide --multigrid'
# do all of the homebrew things please and update neovim nightly
alias brewmeup 'brew update; brew upgrade; brew cleanup -s; brew doctor'
# set an alias for docker-compose depending on the operating system
if test (uname -s) = 'Linux'
  abbr -a dcu 'docker compose up'
else
  abbr -a dcu 'docker-compose up'
end

# current work project quick shortcuts
# for project_file in (/usr/bin/ls $HOME/dotfiles/fish/projects | xargs);
#   source $HOME/dotfiles/fish/projects/$project_file
# end


##################################################
#
# function aliases
#
##################################################
# cd and dots
# function c
#  cd (fd -t d --color=never . $HOME | fzf --preview='tree -L 1 -I {}')
#  ls -A
# end
function dots
  set -l fileloc (fd -t f --color=never . $HOME/dotfiles | fzf --preview='head -80 {}')
  if test $fileloc
    $EDITOR $fileloc -c 'cd ~/dotfiles'
  end
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

# for running npm or yarn or pnpm scripts without remembering which package manager i'm using
function js
  if test -f 'yarn.lock' && test -f 'package-lock.json'
    echo 'Found multiple lockfiles, try using the specific package manager that you want instead.'
  else if test -f 'yarn.lock' && test -f 'pnpm-lock.yaml'
    echo 'Found multiple lockfiles, try using the specific package manager that you want instead.'
  else if test -f 'package-lock.json' && test -f 'pnpm-lock.yaml' 
    echo 'Found multiple lockfiles, try using the specific package manager that you want instead.'
  else if test -f 'pnpm-lock.yaml'
    pnpm $argv
  else if test -f 'yarn.lock'
    yarn $argv
  else if test -f 'package-lock.json'
    npm $argv
  else
    echo 'No npm or yarn project found'
  end
end
abbr -a pnpx 'pnpm dlx'

# js run ...
abbr -a jr 'js run'
alias jrd='js run dev'
alias jrb='js run build'
alias jri='js install'
alias jrl='js run lint'
alias jrs='js run start'
# alias jrv="js run validate"
function dt
  deno task -q $argv
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

# hard reset and wipe all docker containers and volumes
# https://stackoverflow.com/questions/34658836/docker-is-in-volume-in-use-but-there-arent-any-docker-containers#42116347
function docker-hardreset
  docker stop (docker ps -aq)
  docker rm (docker ps -aq)
  docker network prune -f
  docker rmi -f (docker images --filter dangling=true -qa)
  docker volume rm (docker volume ls --filter dangling=true -q)
  docker rmi -f (docker images -qa)
end

# delete an entry from my $PATH
function deleteFromPath
  # This only uses the first argument
  # if you want more, use a for-loop
  # Or you might want to error `if set -q argv[2]`
  # The "--" here is to protect from arguments or $PATH components that start with "-"
  set -l index (contains -i -- $argv[1] $PATH)
  # If the contains call fails, it returns nothing, so $index will have no elements
  # (all variables in fish are lists)
  if set -q index[1]
    set -e PATH[$index]
  else
    return 1
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
# load command completions for personal deno
# scripts
#
##################################################
if command -v wk &>/dev/null
  source (wk completions fish | psub)
end





##################################################
#
# os-specific settings
#
##################################################

# Linux settings
if test (uname -s) = 'Linux'
  # setup keychain settings if not in tmux
  if test -z $TMUX && status --is-interactive
    SHELL=/usr/bin/fish /usr/bin/keychain --eval --quiet -Q gl_vincit gh_vincit gh_personal | source
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

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux SUDO_EDITOR "nvim -u NORC"

# pnpm
set -gx PNPM_HOME "/home/smithbm/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

set -gx GOPATH $HOME/go; set -gx GOROOT $HOME/.go; set -gx PATH $GOPATH/bin $PATH; # g-install: do NOT edit, see https://github.com/stefanmaric/g
