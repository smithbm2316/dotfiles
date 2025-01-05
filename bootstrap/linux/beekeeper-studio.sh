#!/usr/bin/env sh
gh_release() {
  release_url=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | jq -r ".assets[] | select(.name | test(\"$2\")) | .browser_download_url")
  curl -LO "$release_url"
  echo "$release_url" | awk -F '/' '{print $NF}'
}

mkdir -pv ~/builds
cd ~/builds || exit
beekeeper_appimage=$(gh_release 'beekeeper-studio/beekeeper-studio' 'Beekeeper-Studio-[0-9.]+AppImage')
chmod +x "$beekeeper_appimage"
mv -v "$beekeeper_appimage" ~/.local/bin/beekeeper-studio
ln -s \
  ~/dotfiles/config/applications/beekeeper-studio.desktop \
  ~/.local/share/applications/beekeeper-studio.desktop
echo 'Installed beekeeper studio!'
