#!/usr/bin/env sh

if [ -z "$1" ]; then
  echo 'Usage: apt-brew [PACKAGE]
Compare the version of a package between apt and homebrew'
  exit 0
fi

apt_version="$(apt-cache show $1 | head -n 2 | tail -n 1 | cut -d ' ' -f 2)"
brew_version="$(brew info $1 | head -n 1 | cut -d ' ' -f 4)"
echo "apt\t$apt_version"
echo "brew\t$brew_version"
