# helper function to check for a binary
check_installed() {
  if ! command -v $1 &> /dev/null; then
    echo "$1 not installed" && return 127
    return 127
  fi
}

# fuzzy find for a dotfile to edit and open it
dots() {
  local file_loc="$(fd --type f --hidden --color=never . $HOME/dotfiles | fzf --preview='head -80 {}')"
  if [ "$file_loc" ]; then
    eval "$EDITOR $file_loc -c 'cd ~/dotfiles'"
  fi
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

# jq with jsonc - strip comments out of jsonc file before processing with jq
# $1 - the jq query you want to run
# $2 - the path to the file you want to read in
jqc() {
  sed -r 's#//.+##' $2 | jq $1
}
