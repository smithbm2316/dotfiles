#!/bin/bash
rootdir=""
cmd_start="stow"
cmd_end=""

# help menu for cf
cf_help_menu() {
  echo "  cf: a stow helper script for managing my dotfiles and config files"
  echo ""
  echo "  cf [FLAGS] PACKAGE"
  echo ""
  printf "\t -i|--install\t add the symlinks for the given package\n"
  printf "\t -c|--clean\t clean out the symlinks for the given package\n"
  printf "\t -h|--help\t show the help menu\n"
}

# ensure we get enough arguments from the user
# if we don't show the help menu
# if we do, configure the necessary stow options for the given package
if [[ $# -lt 2 ]]; then
  cf_help_menu
  exit
elif [[ "$2" == 'dots' ]]; then
  cmd_end="--ignore='config|cronjobs|scripts|user-dirs.dirs' -t $XDG_CONFIG_HOME dotfiles"
  rootdir="cd ~"
elif [[ "$2" == 'cron' ]]; then
  cmd_end="-t /etc/cron.daily cronjobs"
  rootdir="cd ~/dotfiles"
  cmd_start="sudo $cmd_start"
fi

# switch to the rootdir necessary to run stow for the given package
eval "$rootdir"

# run either the install or clean script
if [[ "$1" == '-i' || "$1" == '--install' ]]; then
  # echo "$cmd_start -nv $cmd_end"
  eval "$cmd_start -nv $cmd_end"

  echo 'Ready to stow your files?'
  read stow_files

  if [[ -z "$stow_files" || "$stow_files" == 'y' ]]; then
    eval "$cmd_start -v $cmd_end"
    echo 'files stowed!'
  else
    echo 'files were not stowed'
  fi
elif [[ "$1" == '-c' || "$1" == '--clean' ]]; then
  # echo "$cmd_start -nvD $cmd_end"
  eval "$cmd_start -nvD $cmd_end"
  echo 'Are you sure you want to remove these files?'
  read remove_files

  if [[ -z "$remove_files" || "$remove_files" == 'y' ]]; then
    eval "$cmd_start -vD $cmd_end"
    echo 'files removed!'
  else
    echo 'files were not removed'
  fi
else
  cf_help_menu
fi

cd - > /dev/null || exit
