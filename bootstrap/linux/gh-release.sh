#!/usr/bin/env sh
# https://www.starkandwayne.com/blog/how-to-download-the-latest-release-from-github/
# $1=repo, $2=test_keyword
gh_release() {
  release_url=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | jq -r ".assets[] | select(.name | test(\"$2\")) | .browser_download_url")
  curl -LO "$release_url"
  echo "$release_url" | awk -F/ '{print $NF}'
}
