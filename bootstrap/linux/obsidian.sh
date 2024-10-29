#!/usr/bin/env sh
gh_release() {
  release_url=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | jq -r ".assets[] | select(.name | test(\"$2\")) | .browser_download_url")
  curl -LO "$release_url"
  echo "$release_url" | awk -F '/' '{print $NF}'
}

mkdir -pv ~/builds
cd ~/builds || exit
obsidian_appimage=$(gh_release 'obsidianmd/obsidian-releases' 'Obsidian-[0-9.]+AppImage')
chmod +x "$obsidian_appimage"
mv -v "$obsidian_appimage" ~/.local/bin/obsidian
ln -s \
  ~/dotfiles/config/applications/obsidian.desktop \
  ~/.local/share/applications/obsidian.desktop
echo 'Installed obsidian!'
