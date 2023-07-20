# OBS virtual cam using v4l2loopback 
# abbr "vcam"="sudo modprobe v4l2loopback video_nr=7 card_label='OBS Virtual Cam'"
# Source fish
abbr "sosh"="source ~/dotfiles/fish/config.fish"
# lazygit
abbr "lg"="lazygit"
# mv and cp and mkdir improvements
abbr "mv"="mv -iv"
abbr "cp"="cp -iv"
abbr "mkdir"="mkdir -pv"
abbr "cwd"="basename $PWD"
# yeet something into nonexistence
abbr "yeet"="rm -rf"
# stow helper for dotfiles and cronjobs
abbr "cf"="$HOME/dotfiles/scripts/cf.sh"
# pr review helper
abbr "prr"="$HOME/dotfiles/scripts/prr.fish"
abbr "ytdl"="youtube-dl"
# pactl
abbr "setvol50"="pactl set-sink-volume @DEFAULT_SINK@ 50%"
# nvim
abbr "nv"="nvim"
abbr "nvpack"="cd ~/.local/share/nvim/site/pack/packer/start"
# check what key events are being sent with `xev`
abbr "keyevent"="xev -event keyboard | grep -o -e '(keysym .*, .*)'"
# do all of the homebrew things please and update neovim nightly
abbr "brewmeup"="brew update -v; brew upgrade -v; brew cleanup -s -v; brew doctor -v"
# list all fedora dnf package repos
abbr "dnfrepos"="grep -E '^\[.*]' /etc/yum.repos.d/*"
# set an alias for docker-compose depending on the operating system
abbr "dcu"='docker compose up'
# if [ "$(uname -s)" = "Linux" ]; then
#   abbr "dcu"='docker compose up'
# else
#   abbr "dcu"='docker-compose up'
# fi

# make tmux easier to use
abbr "tmls"="tmux ls"
abbr "tma"="tmux attach -t "

# execute a deno task
abbr "dt"="deno task "

# pgrep / pkill
abbr "pg"="pgrep"
abbr "pk"="pkill"
