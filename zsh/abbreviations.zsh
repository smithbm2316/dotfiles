# disable these abbreviations so that i get accustomed to using `cd` before
# these, makes it less frustration for me to navigate the command line on a new
# machine or other people's computers, and it's not that many more characters
# abbr "..."="../../"
# abbr "...."="../../../"
# abbr "....."="../../../../"
# abbr "......"="../../../../../"
# abbr "......."="../../../../../../"
# abbr "........"="../../../../../../../"
# abbr "........."="../../../../../../../../"
abbr "arts"="art serve --port 2323"
abbr "brewmeup"="brew update -v; brew upgrade -v; brew cleanup -s -v; brew doctor -v"
abbr "cf"="\$HOME/dotfiles/scripts/cf.sh"
abbr "cp"="cp -iv"
abbr "cwd"="basename \$PWD"
abbr "dcu"="docker compose up"
abbr "got"="go test ./..."
abbr "jst"="jsr test -- run"
abbr "grep"="grep --color=always"
abbr "head"="HEAD~1"
abbr "keyevent"="xev -event keyboard | grep -o -e '(keysym .*, .*)'"
# disable lazygit shortcut for now so that i'm forced to learn and use the
# regular git cli instead
abbr "lg"="lazygit"
abbr "lite"="litecli"
abbr "mkdir"="mkdir -pv"
abbr "mv"="mv -iv"
abbr "nv"="nvim"
abbr "pg"="pgrep"
abbr "pgn"="ps ax | grep ' [n]vim$'"
abbr "pk"="pkill"
abbr "setvol50"="pactl set-sink-volume @DEFAULT_SINK@ 50%"
abbr "sosh"="source \$XDG_CONFIG_HOME/zsh/.zshrc"
abbr "task"="./Taskfile"
abbr "tma"="tmux attach -t "
abbr "tmls"="tmux ls"
abbr "yeet"="rm -rf"
abbr "ytdl"="youtube-dl"

# git shortcuts
abbr g="git"
abbr gcm="git commit"
abbr gl="git l"
abbr gs="git status -s"
# git switch
abbr gsw="git switch"
abbr grs="git reset"
# abbr "gr"="git reset"
# reset
# restore
