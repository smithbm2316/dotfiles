tell application "System Preferences"
  reveal anchor "trackpadTab" of pane id "com.apple.preference.trackpad"
end tell

tell application "System Events" to tell process "System Preferences"
  click checkbox 1 of tab group 1 of window 0
end tell

quit application "System Preferences"
