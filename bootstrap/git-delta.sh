#!/usr/bin/env sh
# https://github.com/dandavison/delta
#
# support for debian apt package is coming in Debian 13!
# https://repology.org/project/git-delta/versions#debian_13

gh_release() {
  release_url=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | jq -r ".assets[] | select(.name | test(\"$2\")) | .browser_download_url")
  curl -LO "$release_url"
  echo "$release_url" | awk -F '/' '{print $NF}'
}

mkdir -pv ~/builds
cd ~/builds || exit
delta_deb="$(gh_release 'dandavison/delta' 'git-delta_[0-9.]+_amd64.deb')"
sudo dpkg -i "$delta_deb"
echo 'Installed delta!'
