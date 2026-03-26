#!/usr/bin/env bash
notify-send() {
  osascript -e "display notification \"$*\" with title \"notify-send\""
}

if [ "$(defaults read NSGlobalDomain com.apple.swipescrolldirection 2>/dev/null || echo 1)" = "1" ]; then
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
  notify-send 'Toggled scroll direction: mouse'
else
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
  notify-send 'Toggled scroll direction: trackpad'
fi

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
