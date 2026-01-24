# helper function to check for a binary
check_installed() {
  if ! command -v $1 &> /dev/null; then
    echo "$1 not installed" && return 127
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
# f() {
#   local file_to_open="$(fzf --preview='head -80 {}')"
#   if [ -f "$PWD/$file_to_open" ]; then
#     eval "$EDITOR $file_to_open"
#   fi
# }

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
  case "$1" in
    up)
      docker compose $@
    ;;
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
  check_installed gum || return $?

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
  check_installed gum || return $?

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

# executes a `package.json` script for the currently active package manager, any
# of `npm`, `yarn`, or `pnpm`, prioritized in that order.
js() {
  if [ -f "package-lock.json" ]; then
    npm $@
  elif [ -f "deno.json" ] || [ -f "deno.jsonc" ]; then
    if [ "$#" -eq 0 ]; then
      deno --help
    else
      deno $@
    fi
  elif [ -f "pnpm-lock.yaml" ]; then
    pnpm $@
  elif [ -f "yarn.lock" ]; then
    if [ "$#" -eq 0 ]; then
      yarn --help
    else
      yarn $@
    fi
  else
    echo "No lockfile found, falling back to npm"
    npm $@
  fi
}

jsr() {
  check_installed gum || return $?
  check_installed jq || return $?

  if [ "$#" -eq 0 ] && [ -f "package.json" ]; then
    jsr "$(jq '.scripts | keys | .[]' -r package.json | gum filter)"
  elif [ -f "package-lock.json" ]; then
    npm run $@
  elif [ -f "deno.json" ] || [ -f "deno.jsonc" ]; then
    deno task $@
  elif [ -f "pnpm-lock.yaml" ]; then
    pnpm run $@
  elif [ -f "yarn.lock" ]; then
    yarn run $@
  else
    echo "No lockfile found, falling back to npm"
    npm run $@
  fi
}

jse() {
  if [ -f "package-lock.json" ]; then
    npx $@
  elif [ -f "deno.json" ] || [ -f "deno.jsonc" ]; then
    deno run $@
  elif [ -f "pnpm-lock.yaml" ]; then
    pnpm exec $@
  elif [ -f "yarn.lock" ]; then
    yarn exec $@
  else
    echo "No lockfile found, falling back to npm"
    npx $@
  fi
}

jsx() {
  if [ -f "package-lock.json" ]; then
    npx $@
  elif [ -f "deno.json" ] || [ -f "deno.jsonc" ]; then
    deno run $@
  elif [ -f "pnpm-lock.yaml" ]; then
    pnpm exec $@
  elif [ -f "yarn.lock" ]; then
    yarn exec $@
  else
    echo "No lockfile found, falling back to npm"
    npx $@
  fi
}

# execute a `storybook` package.json script with the `--no-open` flag
sb() {
  jsr storybook -- --no-open
}

# shortcut for local pocketbase binary
pb() {
  ./pocketbase $@
}

# apt shortcuts
apt-grep() {
  if [ ! "$(command -v apt)" ]; then
    echo '`apt` not installed.'
    exit 127
  fi
  if [ "$#" -eq 0 ]; then
    echo 'calls: apt search --names-only $@ | less'
    exit 1
  fi
  apt search --names-only $@ | less
}
apt-installed() {
  if [ "$#" -eq 0 ]; then
    echo 'calls: dpkg -l | grep --color=always $@'
    return 1
  fi
  dpkg -l | grep --color=always $@
}

# wrapper around `go doc` that uses `bat` to provide a pager and syntax
# highlighting for the go code that `go doc` outputs, as well as `gum` to filter
# down the list of packages that i might be searching for
gd() {
  # ensure that `bat` and `gum` are installed
  check_installed gum || return $?
  batbin=""
  for bin in bat batcat; do
    # ensure that the command exists and is not an alias
    if command -v $bin | grep -v alias &>/dev/null; then
      batbin="$bin"
      break
    fi
  done
  if test -z $batbin; then
    echo "Couldn't find any of $@" >&2
    return 127
  fi

  list_flag=false
  while getopts ':l' opt; do
    case $opt in
      l)
        list_flag=true
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        return 1
        ;;
    esac
  done

  # if there are no arguments passed, then just list all the go standard library
  # packages with gum and let me select one to pass to `go doc`
  if [ $# -eq 0 ]; then
    selection="$(go list std | gum filter --limit=1)"
    test $? -ne 0 && return 1
    go doc $selection | $batbin -l go
  # if there's exactly 2 arguments and the second one is a `-l` flag, list all
  # the exports of the package supplied in the first argument with `gum`, so
  # that I can select the `func/type/var` to then pass to `go doc` for the
  # package that I provided.
  elif [ $# -eq 2 ] && [ ! -z $list_flag ]; then
    selection="$(go doc $1 |
      sed -En 's/^(func|type|var)\s(\w+).*$/\1 \2/p' | \
      gum filter --limit=1 | \
      cut -d ' ' -f 2)"
    test $? -ne 0 && return 1
    go doc "$1.$selection" | $batbin -l go
  # otherwise, just use colorize the exact output of `go doc` with the first
  # argument passed to it
  else
    go doc $1 | $batbin -l go
  fi
}

# use qalc to calculate rems. 
rem() {
  check_installed qalc || return $?

  if [ "$1" = "x" ]; then
    qalc "$2*16"
  elif [ "$1" = "/" ]; then
    qalc "$2/16"
  else
    echo 'Requires 2 arguments, x or / to specify operation and value to calculate.'
  fi
}

# ssh key generation utility
sshkg() {
  mkdir -pv ~/.ssh
  cd ~/.ssh || exit

  echo "Enter your comment for the ssh key:"
  read -r comment
  echo "Enter the name for your key (will be saved to ~/.ssh):"
  read -r key_name

  ssh-keygen -t ed25519 -C "$comment" -f "$key_name"

  copy_cmd=""
  if [ "$(uname -s)" = "Darwin" ]; then
    copy_cmd="pbcopy"
  elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if [ "$(command -v wl-copy)" ]; then
      copy_cmd="wl-copy"
    else
      echo "Couldn't find 'wl-copy', please try installing it"
      exit
    fi
  else
    if [ "$(command -v xclip)" ]; then
      copy_cmd="xclip -sel clip"
    else
      echo "Couldn't find 'xclip', please try installing it"
      exit
    fi
  fi

  "$copy_cmd" < "$HOME/.ssh/$key_name.pub" \
    && echo "Copied public key for $key_name to clipboard" \
    || exit
  cd - || exit
}

chp() {
  check_installed gum || return $?

  branch="$(git branch --no-color --format='%(refname:short)' --sort=-committerdate | gum filter --no-sort --limit=1)"
  if [ -z "$branch" ]; then
    echo 'No branch selected, exiting.'
    exit 1
  fi

  commit_line="$(git log --oneline --no-color "$branch" | gum filter --no-sort --limit=1)"
  if [ -z "$commit_line" ]; then
    echo 'No commit selected, exiting.'
    exit 1
  fi

  commit_sha="$(echo "$commit_line" | cut -d ' ' -f 1)"
  git cherry-pick "$commit_sha"
}

gcp() {
  paste_cmd=""
  if [ "$(uname -s)" = "Darwin" ]; then
    paste_cmd="pbpaste"
  elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if [ "$(command -v wl-paste)" ]; then
      paste_cmd="wl-paste"
    else
      echo "Couldn't find 'wl-copy', please try installing it"
      exit
    fi
  else
    if [ "$(command -v xclip)" ]; then
      paste_cmd="xclip -sel clip -o"
    else
      echo "Couldn't find 'xclip', please try installing it"
      exit
    fi
  fi

  "$paste_cmd" | xargs git cherry-pick
}

# go version manager: https://github.com/stefanmaric/g
gvm() {
  GOROOT="$HOME/.go" $GOPATH/bin/g $@
}

agent() {
  check_installed cursor-agent || return $?

  case "$1" in
    ask)
      cursor-agent 'Do not write any code, please answer the following question:'
    ;;
    plan)
      cursor-agent 'Do not write any code, help me plan/scope the following out:'
    ;;
    *)
      cursor-agent $@
    ;;
  esac
}
