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
  local file_loc="$(fd --type f --hidden --color=never . $HOME/dotfiles | fzf --preview='head -80 {}')"
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
  local container_name="$1"
  if [ ! -z "$container_name" ]; then
    local container_id="$(docker ps -a --format '{{.ID}}: {{.Image}}' | grep $container_name | sed -n 's/^\(\w\+\)\:.*/\1/p')"
    local image_id="$(docker images -a --format '{{.ID}}: {{.Repository}}' | grep $container_name | sed -n 's/^\(\w\+\)\:.*/\1/p')"

    docker stop "$container_id"
    docker rm "$container_id"
    docker network prune -f
    docker rmi -f "$image_id"
    # docker rmi -f $(docker images --filter dangling=true -qa)
    # docker volume rm $(docker volume ls --filter dangling=true -q)
  else
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
  fi
}

# common jq operations
json() {
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

# grep for process
pg() {
  handle_not_installed "gum" || return 127

  local cmd="$(echo nvim | gum filter --no-strict --limit=1)"
  pgrep --list-name "$cmd"
}

# wrapper for js
# get_js_pkg_manager() {
#   if [ -e "pnpm-lock.yaml" ];
#     echo "pnpm"
#   elif [ -e "yarn.lock" ];
#     echo "yarn"
#   elif [ -e "package-lock.json" ];
#     echo "npm"
#   else
#     echo "none"
#   fi
# }

# git worktree helpers
gwa() {
  handle_not_installed "gum" || return 127

  # fetch all remote branches and prune
  if [ "$1" = "-r" ] || [ "$1" = "--remote" ]; then
    git fetch -p origin 'refs/heads/*:refs/heads/*' || return 1
  fi
  # list and pick a branch to use 
  local branch="$(git branch --format='%(refname:short)' | gum filter --no-strict --limit=1)"
  # use the branch's name for the local path. if the branch name contains `/`, use
  # the text after the last `/`
  local path_to_worktree="$(echo $branch | awk -F / '{ print $NF }')" || return 1
  if [ -e "$path_to_worktree" ]; then
    echo "That file or worktree already exists, exiting..."
    return 1
  fi
  # create the worktree
  git worktree add "$path_to_worktree" "$branch" || return 1
  # cd into it
  cd "$path_to_worktree"
}

gw() {
  git worktree $@
}

gwls() {
  git worktree list
}

gwrm() {
  git worktree remove $@
  echo "Removed worktree $@"
  git worktree list
}
