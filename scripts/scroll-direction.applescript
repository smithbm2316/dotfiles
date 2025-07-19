#!/usr/bin/osascript

-- Ensure GUI scripting is enabled
tell application "System Settings" to activate
delay 1

tell application "System Events"
	tell process "System Settings"
		-- Navigate to Trackpad settings
		click menu item "Trackpad" of menu "View" of menu bar 1
		delay 1
		
		-- Wait for Trackpad window to appear
		repeat until window "Trackpad" exists
			delay 0.5
		end repeat
		
		tell window "Trackpad"
			-- set uiElems to entire contents
			click button "Scroll & Zoom" of tab group 1
			-- Click the “Scroll & Zoom” tab
			-- click button 2 of tab group 1
			-- delay 2
			
			-- Find and click the "Natural scrolling" checkbox
			-- set naturalScrollCheckbox to checkbox 1 of tab group 1
			-- click naturalScrollCheckbox
		end tell
	end tell
end tell
