#!/usr/bin/env sh
gh_release() {
  release_url=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | jq -r ".assets[] | select(.name | test(\"$2\")) | .browser_download_url")
  curl -LO "$release_url"
  echo "$release_url" | awk -F/ '{print $NF}'
}

mkdir -pv ~/.local/share/fonts
cd ~/builds || exit

# BlexMono nerd font
gh_release 'ryanoasis/nerd-fonts' 'IBMPlexMono.zip'
mkdir -pv ~/.local/share/fonts/BlexMonoNF
unzip -d ~/.local/share/fonts/BlexMonoNF IBMPlexMono.zip
rm IBMPlexMono.zip

# JetBrainsNF nerd font
gh_release 'ryanoasis/nerd-fonts' 'JetBrainsMono.zip'
mkdir -pv ~/.local/share/fonts/JetBrainsMonoNF
unzip -d ~/.local/share/fonts/JetBrainsMonoNF JetBrainsMono.zip
rm JetBrainsMono.zip

# UbuntuNF nerd font
gh_release 'ryanoasis/nerd-fonts' 'Ubuntu.zip'
mkdir -pv ~/.local/share/fonts/UbuntuNF
unzip -d ~/.local/share/fonts/UbuntuNF Ubuntu.zip
rm Ubuntu.zip

# UbuntuMonoNF nerd font
gh_release 'ryanoasis/nerd-fonts' 'UbuntuMono.zip'
mkdir -pv ~/.local/share/fonts/UbuntuMonoNF
unzip -d ~/.local/share/fonts/UbuntuMonoNF UbuntuMono.zip
rm UbuntuMono.zip

# iA-Writer nerd font
gh_release 'ryanoasis/nerd-fonts' 'iA-Writer.zip'
mkdir -pv ~/.local/share/fonts/iA-WriterNF
unzip -d ~/.local/share/fonts/iA-WriterNF iA-Writer.zip
rm iA-Writer.zip

# symbols nerd font
symbols_nerd_font_zipfile=$(gh_release 'ryanoasis/nerd-fonts' 'NerdFontsSymbolsOnly.zip')
mkdir -pv ~/.local/share/fonts/SymbolsNerdFont
unzip -d ~/.local/share/fonts/SymbolsNerdFont "$symbols_nerd_font_zipfile"
rm "$symbols_nerd_font_zipfile"

# fonts-comic-neue (lol)
sudo apt install -y fonts-3270 fonts-inter fonts-inter-variable fonts-manrope \
  fonts-lato fonts-beteckna

# ibm plex font
# ibm_plex=$(gh_release 'IBM/plex' '.*.zip')
# mkdir -pv ~/.local/share/fonts/IBM-Plex-Mono
# unzip -d ~/.local/share/fonts/IBM-Plex-Mono "$ibm_plex"
# rm "$ibm_plex"
