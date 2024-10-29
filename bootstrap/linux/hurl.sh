#!/usr/bin/env sh
# https://hurl.dev/docs/installation.html
gh_release() {
  release_url=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | jq -r ".assets[] | select(.name | test(\"$2\")) | .browser_download_url")
  curl -LO "$release_url"
  echo "$release_url" | awk -F/ '{print $NF}'
}

cd ~/builds || exit
hurl_deb="$(gh_release 'Orange-OpenSource/hurl' 'hurl_.*amd64.deb')"
sudo dpkg -i "./$hurl_deb"
