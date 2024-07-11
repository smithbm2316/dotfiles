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
      splitw -t serve -v
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

# docker utilities
dock() {
  local cmd="$1"

  case "$cmd" in
    reset)
      # hard reset and wipe all docker containers and volumes
      # https://stackoverflow.com/questions/34658836/docker-is-in-volume-in-use-but-there-arent-any-docker-containers#42116347
      local container_name="$2"
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
    ;;
    *)
      echo "Invalid command. Available commands: reset"
    ;;
  esac
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
gwta() {
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
              // @ts-expect-error TEMPORARY
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

# copy env files recursively from one repo into new one with the same directory structure.
# useful specifically for copying env files from an existing git worktree to a new one
cpenv() {
  local new_repo="$1"
  if [ -z "$new_repo" ]; then
    echo "Please specify a path to copy the env files into recursively"
    return 1
  fi

  # trim any trailing slashes off of the submitted path
  new_repo="$(realpath --relative-to=. -s $new_repo)"

  local env_pattern="$2"
  if [ -z "$env_pattern" ]; then
    # set default pattern to search for all exact ".env" and ".env.local" files
    env_pattern='\.env(\.local)*$'
  fi

  fd --hidden --no-ignore-vcs "$env_pattern" | \
    xargs -L1 echo | \
    while read -r env_file; \
      do cp -v "$env_file" "$new_repo/$env_file"; \
    done
}

gwa() {
  local based_off_of="origin/$2"
  if [ -z "$2" ]; then
    based_off_of="origin/main"
  fi
  git worktree add -b "ben-smith/$1" "$1" "$based_off_of"
}

# show more options when using pgrep
# https://serverfault.com/a/77167
ppgrep() {
  pgrep "$@" | xargs --no-run-if-empty ps fp;
}

# start a local http server for specific folders on my machine
serve() {
  case "$1" in
    books)
      # the books in my $HOME/books folder
      npx http-server --port 1337 ~/books
      ;;
    *)
      echo "Please choose a valid option from: books"
      exit 1
      ;;
  esac
}

# shortcut for `php artisan ...`
art() {
  php artisan $@
}

# shortcut for `npx shopify hydrogen ...`
h2() {
  npx shopify hydrogen $@
}

# shortcut for `npm run ...`
js() {
  npm run $@
}

# shortcut for django cli commands
dj() {
  django-admin $@
}
djm() {
  python manage.py $@
}
