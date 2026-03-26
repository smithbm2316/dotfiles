#!/usr/bin/env bash
help_menu() {
  echo "create-cliamp-playlist.sh [FLAGS] -u <URL>"
  echo ""
  echo "  -u url          required, the URL of the youtube music playlist or album"
  echo "  -o output_path  the path to write the playlist to. default: \"$output_path\"."
  echo "  -h help         show this help menu"
}

output_path="$HOME/dotfiles/cliamp/playlists/new-playlist.toml"
show_help="false"
url=""

while getopts ':o:u:h' opt; do
  case $opt in
    o)
      output_path="$OPTARG"
      ;;
    h)
      show_help="true"
      ;;
    u)
      url="$OPTARG"
      ;;
    \?)
      echo "Invalid option -$OPTARG."
      echo ""
      help_menu
      exit 1
      ;;
  esac
done

if [ "$show_help" = "true" ]; then
  help_menu
  exit 0
elif [ -z "$url" ]; then
  echo "Please provide a youtube music album or playlist URL to fetch from."
  echo ""
  help_menu
  exit 1
fi

yt-dlp --flat-playlist \
  --print '[[track]]' \
  --print 'path = "%(url)s"' \
  --print 'title = "%(title)s"' \
  --print 'artist = "%(uploader)s"' \
  --print 'album = "%(playlist)s"' \
  --print 'album_art_url = "%(thumbnails.0.url)s"' \
  --print 'duration_secs = "%(duration)s"' \
  --print '' \
  "$url" > "$output_path"
