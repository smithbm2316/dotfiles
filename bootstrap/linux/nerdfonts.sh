#!/usr/bin/env bash
# adopted from: https://github.com/drewgrif/bookworm-scripts/blob/main/resources/nerdfonts.sh
# Thanks for the great starting point Drew/Just a Guy Linux!

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if unzip is installed; if not, install it
if ! command_exists unzip; then
  echo "Installing unzip..."
  sudo apt install unzip -y
fi

# Create directory for fonts if it doesn't exist
mkdir -p ~/.local/share/fonts

# Array of font names
fonts="IBMPlexMono JetBrainsMono NerdFontsSymbolsOnly Ubuntu UbuntuSans"

# Function to check if font directory exists
check_font_installed() {
  font_name=$1
  if [ -d ~/.local/share/fonts/$font_name ]; then
    echo "Font $font_name is already installed. Skipping."
    return 0  # Font already installed
  else
    return 1  # Font not installed
  fi
}

# Loop through each font, check if installed, and install if not
echo "$fonts" | tr ' ' '\n' | while read font
do
  if check_font_installed "$font"; then
    # Skip installation if font is already installed
    continue
  fi

  echo "Installing font: $font"
  wget -q --show-progress \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$font.zip \
    -P /tmp
  unzip -q /tmp/$font.zip -d ~/.local/share/fonts/$font/
  rm /tmp/$font.zip
done

# Update font cache
fc-cache -f

echo "Fonts installation completed."
