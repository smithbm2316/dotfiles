handle_not_installed() {
  local required_cmd="$1"
  if [ -z "$(command -v $required_cmd)" ]; then
    echo "Please install the $required_cmd to use this script"
    return 127
  fi
}

# create a new directory and cd into it
mkd() {
  local new_dir="$1"
  mkdir -pv "$new_dir" && cd "$new_dir"
}

# fuzzy find for a dotfile to edit and open it
dots() {
  local file_loc="$(fd -t f --color=never . $HOME/dotfiles | fzf --preview='head -80 {}')"
  if [ "$file_loc" ]; then
    eval "$EDITOR $file_loc -c 'cd ~/dotfiles'"
  fi
}

# fuzzy find for a file to edit and open it
f() {
  local file_to_open="$(fzf --preview='head -80 {}')"
  if [ -f "$PWD/$file_to_open" ]; then
    eval "$EDITOR $file_to_open"
  fi
}

# handle common tmux session options
# - if a valid session is passed to the function, connect to it
# - connect to the last running session if there is one
# - otherwise start a new tmux server
tm() {
  local session="$1"
  if [ -z "$session" ]; then
    tmux attach 2>/dev/null
  else
    tmux attach -t "$session" 2>/dev/null
  fi

  if [ "$?" -ne 0 ]; then
    tmux
  fi
}

# kill the tmux server or session if a session is specified as the first arg
tmks() {
  local session="$1"
  if [ -z "$session" ]; then
    tmux kill-server
  else
    tmux kill-session -t "$session"
  fi
}

# create a new tmux session with the setup that i like
tmn() {
  local session="$1"
  if [ -z "$session" ]; then
    tmux \
      new -n code -s "$(basename $PWD)" \; \
      neww -n serve \; \
      splitw -h -c -t serve
    # tmux \
      # new -n code -s "$(basename $PWD)" \; \
      # send "$EDITOR" C-m \; \
      # neww -n serve \; \
      # splitw -h -c -t serve
  else
    tmux new -s "$session"
  fi
}

# create a new tmux session with a specified command to execute in the 'serve' window
tmnp() {
  # local session="$1"
  local serve_cmd="$2"
    tmux \
      new -n code -s "$(basename $PWD)" \; \
      neww -n serve \; \
      splitw -h -c -t serve \; \
      send -c "$serve_cmd" C-m
}

# handle fzf inside of a tmux session to create a new tmux session
tmns-fzf() {
  tmux display-popup -E "new-session -c \"$(fd -E 'Library' --base-directory $HOME | fzf)\""
}

# hard reset and wipe all docker containers and volumes
# https://stackoverflow.com/questions/34658836/docker-is-in-volume-in-use-but-there-arent-any-docker-containers#42116347
docker-hardreset() {
  docker stop "$(docker ps -aq)"
  docker rm "$(docker ps -aq)"
  docker network prune -f
  docker rmi -f "$(docker images --filter dangling=true -qa)"
  docker volume rm "$(docker volume ls --filter dangling=true -q)"
  docker rmi -f "$(docker images -qa)"
}

# common jq operations
jqs() {
  handle_not_installed "gum" || return 127

  case "$(gum choose --limit=1 'package.json')" in
    'package.json')
      # shortcut for listing all the dependencies and devDependencies of a package.json
      jq '{ dependencies: .dependencies, devDependencies: .devDependencies }' package.json
      ;;
    *)
      echo "Please select a choice to execute"
      ;;
  esac
}
