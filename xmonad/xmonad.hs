-- XMonad config file {{{
--
-- note: to not use ~/.xmonad dir by default, run `mkdir -p ~/.local/share/xmonad`
-- and put xmonad.hs & xmobar.conf in $XDG_CONFIG_DIR/xmonad. should keep home
-- directory cleaner and use config in config directory instead now
-- }}}

-- import xmonad libraries {{{
import XMonad -- core library
import Data.Map as M
import System.Directory
import System.IO -- needed for input/output in various modules
import System.Exit (exitSuccess) -- used for exiting xmonad session back to tty
import qualified XMonad.StackSet as W -- used for manipulating and moving windows

-- actions
import XMonad.Actions.CopyWindow(copyToAll, kill1) -- allows copying and killing windows
import XMonad.Actions.CycleWS -- used to shift focus/move windows/workspaces to other monitors
import XMonad.Actions.Promote -- promote window to master in the stack
import XMonad.Actions.Submap -- allows using keybindings akin to i3 modes
import XMonad.Actions.WithAll (killAll, sinkAll) -- perform an action to all windows in a workspace
import XMonad.Actions.UpdatePointer -- warp mouse when window focus is switched

-- hooks
import XMonad.Hooks.DynamicLog -- hooks that let you put workspaces in xmobar
import XMonad.Hooks.EwmhDesktops -- allows dmenu/rofi to get info about workspaces and windows in xmonad
import XMonad.Hooks.ManageDocks (avoidStruts, docks) --, ToggleStruts) -- allow xmobar to not be added to the stack
import XMonad.Hooks.ManageHelpers -- managing app-specific properties/rules
import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook) -- hooks for keeping track of workspace view order

-- layouts
import XMonad.Layout.Reflect -- adds ability to flip a layout (used for flipping the side the master window is on in monad tall layout)
import XMonad.Layout.Renamed (renamed, Rename(Replace)) -- allows me to rename my layouts
import XMonad.Layout.Spacing -- adds gaps around a window
import XMonad.Layout.ThreeColumns -- layouts I am using
import XMonad.Layout.TwoPanePersistent -- layouts I am using

-- prompt
import XMonad.Prompt -- base module for prompts
import XMonad.Prompt.AppendFile -- write a single line of text to a file (good for notes!)
import XMonad.Prompt.FuzzyMatch -- use fuzzy finding in prompts
import XMonad.Prompt.RunOrRaise -- write a single line of text to a file (good for notes!)
import XMonad.Prompt.Workspace -- switching workspaces

-- utilities
import XMonad.Util.EZConfig (additionalKeysP, mkKeymap) -- easier to override/define new keybindings
import XMonad.Util.NamedScratchpad -- named scratchpad functionality
import XMonad.Util.Run (spawnPipe, hPutStrLn) -- necessary for launching xmobar
import XMonad.Util.SpawnOnce (spawnOnce) -- used for autorunning programs
-- }}}

-- variables (used in main function to call xmonad) {{{
myMod :: KeyMask
myMod = mod4Mask

myAlt :: KeyMask
myAlt = mod1Mask

myTerm :: String
myTerm = "alacritty"

myWorkspaces :: [String]
myWorkspaces = ["dev", "web", "hax", "work", "vibes", "messages", "app", "id"]

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = True

borderUnfocused :: String
borderUnfocused = "#382f47"

borderFocused :: String
borderFocused = "#eb64b9"

borderSize :: Dimension
borderSize = 2

-- custom variables
myFont :: String
myFont = "xft:UbuntuMono Nerd Font:regular:size=14:antialias=true:hinting=true"

myBrowser :: String
myBrowser = "firefox"

myEditor :: String
myEditor = "nvim"

myGUIFileManager :: String
myGUIFileManager = "thunar"
-- }}}

-- Keybindings (myKeybindings) {{{
myKeybindings :: [( [Char], X() )]
myKeybindings = 
  -- xmonad reload/recompile
  [ ("M-C-r", spawn "xmonad --recompile") -- recompile xmonad
  , ("M-r", spawn "xmonad --restart") -- restart xmonad

  -- `w`indow manager exit/lock/suspend
  , ("M-q e", io exitSuccess) -- quit xmonad (exit)
  , ("M-q l", spawn "i3lock -c '#382f47' -i '/home/smithbm/Pictures/retrowave-landscape/retrowave1.png'") -- lock screen
  , ("M-q s", spawn "i3lock -c '#382f47' -i '/home/smithbm/Pictures/retrowave-landscape/retrowave1.png' && systemctl suspend") -- sleep and lock screen

  -- xmonad kill programs
  , ("M-c", kill1) -- kill currently focused client
  , ("M-S-c", killAll) -- kill all windows on current workspace

  -- prompts
  , ("M-m", workspacePrompt myXPrompt (windows . W.shift)) -- open prompt to switch workspaces
  , ("M-g", workspacePrompt myXPrompt (windows . W.shift)) -- open prompt to switch workspaces
  , ("M-o", runOrRaisePrompt myXPrompt) -- open prompt to switch workspaces

  -- focusing and manipulating windows
  -- still a bit broken here D:, ("M-w a", windows copyToAll) -- float window on `a`ll workspaces, like DWM
  , ("M-w f", withFocused toggleFloat) -- toggle window between floating and tiled
  , ("M-w l", shiftToNext >> nextWS) -- move focused window to next workspace in order
  , ("M-w h", shiftToPrev >> prevWS) -- move focused window to previous workspace in order
  , ("M-w n", shiftNextScreen >> nextScreen) -- move focused window to next monitor
  , ("M-m", windows W.focusMaster)  -- Move focus to the master window
  , ("M-j", windows W.focusDown)    -- Move focus to the next window
  , ("M-k", windows W.focusUp)      -- Move focus to the prev window
  , ("M-C-m", windows W.swapMaster) -- Swap the focused window and the master window
  , ("M-C-j", windows W.swapDown)   -- Swap focused window with next window
  , ("M-C-k", windows W.swapUp)     -- Swap focused window with prev window
  -- , ("M-w C-s", sinkAll) -- Push ALL floating windows to tile

  -- focusing and manipulating workspaces
  , ("M-n", nextScreen) -- switch focus to next monitor
  , ("M-C-n", swapNextScreen) -- swap current workspace with workspace on next monitor
  , ("M-<Space>", sendMessage NextLayout) -- cycle through layouts
  , ("M-p", toggleWS' ["NSP"]) -- switch to most recently displayed workspace, and don't include scratchpads in the workspace history
  -- TODO: add implementation for XMonad.Actions.CycleRecentWS module to walk back through the list of viewed workspaces
  -- link: https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Actions-CycleRecentWS.html

  -- focus/move window to workspace "workspacename"
  -- left monitor workspaces
  , ("M-a", windows (W.greedyView "dev")) -- focus workspace "dev"
  , ("M-C-a", windows (W.shift "dev") >> windows (W.greedyView "dev")) -- move window and follow it to workspace "dev"
  , ("M-s", windows (W.greedyView "web")) -- focus workspace "web"
  , ("M-C-s", windows (W.shift "web") >> windows (W.greedyView "web")) -- move window and follow it to workspace "web"
  , ("M-d", windows (W.greedyView "hax")) -- focus workspace "hax"
  , ("M-C-d", windows (W.shift "hax") >> windows (W.greedyView "hax")) -- move window and follow it to workspace "hax"
  , ("M-f", windows (W.greedyView "work")) -- focus workspace "dev"
  , ("M-C-f", windows (W.shift "work") >> windows (W.greedyView "dev")) -- move window and follow it to workspace "dev"
  -- right monitor workspaces
  , ("M-y", windows (W.greedyView "vibes")) -- focus workspace "dev"
  , ("M-C-y", windows (W.shift "vibes") >> windows (W.greedyView "vibes")) -- move window and follow it to workspace "vibes"
  , ("M-u", windows (W.greedyView "messages")) -- focus workspace "messages"
  , ("M-C-u", windows (W.shift "messages") >> windows (W.greedyView "messages")) -- move window and follow it to workspace "messages"
  , ("M-i", windows (W.greedyView "app")) -- focus workspace "app"
  , ("M-C-i", windows (W.shift "app") >> windows (W.greedyView "app")) -- move window and follow it to workspace "app"
  -- , ("M-o", windows (W.greedyView "id")) -- focus workspace "id"
  -- , ("M-C-o", windows (W.shift "id") >> windows (W.greedyView "id")) -- move window and follow it to workspace "id"

  -- rofi settings 
  , ("M-/", spawn "rofi -show drun -icon-theme 'Papirus' -show-icons") -- drun launcher
  , ("M1-<Tab>", spawn "rofi -show window -icon-theme 'Papirus' -show-icons") -- window switcher "M1" = Alt key on my keyboard (short for Mod1)
  , ("M-C-/", spawn "rofi -show run") -- run launcher
  , ("M-C-e", spawn "splatmoji copy") -- emoji picker launcher, copies to clipboard

  -- screenshots
  , ("<Print>", spawn "flameshot gui") -- opens gui to drag and select are to capture
  , ("M-<Print>", spawn "flameshot screen --clipboard") -- screenshots focused monitor to clipboard
  , ("M-C-<Print>", spawn "flameshot full --clipboard") -- screenshots all monitors to clipboard

  -- multimedia keys
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle") -- mutes pulseaudio default sink
  , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%") -- raises pulseaudio default sink by 5%
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%") -- lowers pulseaudio default sink by 5%
  , ("<XF86AudioPlay>", spawn "playerctl play-pause") -- play/pause song
  , ("<XF86AudioPrev>", spawn "playerctl previous") -- skip to next song
  , ("<XF86AudioNext>", spawn "playerctl next") -- go back to previous song/restart song

  -- programs and scratchpads
  , ("M-t", spawn myTerm) -- launch default terminal
  , ("M-b", spawn myBrowser) -- default browser
  , ("M-C-o", namedScratchpadAction myScratchPads "obs") -- obs scratchpad
  , ("M-C-t", namedScratchpadAction myScratchPads "terminal") -- terminal scratchpad
  -- , ("M-g v", namedScratchpadAction myScratchPads "vibes") -- vibes (music player) scratchpad

  -- 'Go' (open program/workflow) submappings
  -- programs
  -- , ("M-o b", spawn "vieb") -- launch vieb
  -- , ("M-o d", spawn "/opt/firefox-dev/firefox") -- launch firefox dev edition
  -- , ("M-o f", spawn myGUIFileManager) -- launch gui file manager
  -- , ("M-o m", spawn "spotify") -- launch music client
  -- , ("M-o n", spawn "/home/smithbm/AppImages/./Obsidian.AppImage") -- launch Obsidian
  -- , ("M-o p", spawn "flatpak run com.getpostman.Postman") -- launch Postman
  -- , ("M-o S-p", spawn "flatpak run com.jetbrains.PyCharm-Community") -- launch PyCharm
  -- , ("M-o s", spawn "slack") -- launch Slack
  -- , ("M-o z", spawn "flatpak run us.zoom.Zoom") -- launch zoom
  -- -- workflows
  -- , ("M-o i", spawn "firefox --new-window 'https://ew43.ultipro.com/Login.aspx' 'https://admin.idtech.com'") -- idtech login launcher
  -- , ("M-o u", spawn "firefox --new-window 'https://uci.zoom.us/join' && alacritty --class 'floating_alacritty' --command nvim ~/Documents/uci-meetings.md") -- uci meeting launcher
  ]
  -- yoinked this where -> toggleFloat function from: https://libredd.it/r/xmonad/comments/hm2tg0/how_to_toggle_floating_state_on_a_window/
  where toggleFloat w = windows (\s -> if M.member w (W.floating s) then W.sink w s else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))
-- }}}

-- prompt settings {{{
myXPrompt :: XPConfig
myXPrompt = def
      { font                = myFont
      , bgColor             = "#27212e"
      , fgColor             = "#e0dfe1"
      , bgHLight            = "#eb64b9"
      , fgHLight            = "#000000"
      , borderColor         = "#27212e"
      , promptBorderWidth   = 0
      , position            = Top
      , height              = 24
      , historySize         = 256
      , historyFilter       = id
      -- , defaultText         = []
      -- , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to 'Just 5' for 5 rows
      }
-- }}}

-- scratchpad settings {{{
myScratchPads :: [NamedScratchpad]
myScratchPads = [ 
                  NS "terminal" spawnTerm findTerm manageFloat -- terminal scratchpad
                , NS "vibes" "ncspot" (resource =? "ncspot") manageFloat -- vibes (music player) scratchpad
                , NS "obs" "obs" (resource =? "obs") manageFloat -- vibes (music player) scratchpad
                ]
  where
    -- for terminal
    spawnTerm  = myTerm ++ " --class 'scratchpad_term'"
    findTerm   = resource =? "scratchpad_term"
    -- general for any floating scratchpad
    manageFloat = doSideFloat C
-- }}}

-- Layouts (layoutHook) {{{
--
-- Importing and defining a layout: LayoutName nmaster delta ratio
-- nmaster: default number of windows in master pane 
-- delta: percent of the screen to increment by when resizing panes
-- ratio: default proportion of the screen occupied by master pane
-- i.e. - ThreeColMid   1         (2/100) (1/2)
--        ^layout name  ^nmaster  ^delta  ^ratio
-- 
-- Creating gaps like i3-gaps: spacingRaw is used to create gaps around windows and workspaces
-- False: turn smartBorder off, I want gaps even when there is only 1 window
-- (Border ...): size of gaps around the workspace
-- True: turn screenBorderEnabled on, use the screenBorder specified
-- (Border ...): size of gaps around each window/app
-- True: turn windowBorderEnabled on, use the windowBorder specified
--
-- reflectHoriz mirrors a layout horizontally (i.e. for the monadTall layout, master moves to
-- the right side instead of the left side)

myLayoutHook = 
  -- make xmobar stay in its own separate space, away from all windows
  avoidStruts $ ( max ||| monadTall ||| twoPane ||| threeColMid ) -- all my layouts I'm using
    where 
      -- variables for layouts
      threeColMid = renamed [Replace "three col mid"] $ reflectHoriz $ mySpacingRaw $ ThreeColMid 1 (2/100) (1/2)
      monadTall = renamed [Replace "tall"] $ reflectHoriz $ mySpacingRaw $ Tall 1 (2/100) (1/2) 
      twoPane = renamed [Replace "two pane"] $ reflectHoriz $ mySpacingRaw $ TwoPanePersistent Nothing (2/100) (1/2)
      max = renamed [Replace "max"] $ mySpacingRaw $ Full
      -- variable for applying gaps easily to all layouts except floating & fullscreen
      mySpacingRaw = spacingRaw False (Border 4 4 4 4) True (Border 4 4 4 4) True
      -- TODO: figure out what layouts you want, and use the IfMax hook to use a certain layout for 1-2 windows,
      -- then another after you open more (i.e. tall for 1-3 windows, grid for 4+)
      -- link: https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Layout-IfMax.html
-- }}}

-- handling events hook (handleEventHook) {{{
myHandleEventHook = def <+> fullscreenEventHook
-- }}}

-- Window and application specific rules (manageHook) {{{
myManageHook :: ManageHook
myManageHook = composeAll
  [ isDialog                            --> doSideFloat C   -- float all dialog boxes
  -- float specific apps by default
  , className =? "floating_term"        --> doSideFloat C
  , className =? "Galculator"           --> doSideFloat C
  , className =? "zoom"                 --> doSideFloat C
  , className =? "Firefox" <&&> resource =? "Toolkit" --> doSideFloat C -- firefox pip
  , className =? "Firefox" <&&> resource =? "Dialog" --> doSideFloat C -- firefox dialog menus
  , className =? "Firefox" <&&> resource =? "Places" --> doSideFloat C -- firefox bookmarks manager
  -- ignore trayer like we ignore xmobar, we don't want it in the window stack
  , className =? "trayer"               --> doIgnore
  -- launch app on specific workspaces
  , className =? "discord"              --> doShift "messages"
  , className =? "Geary"                --> doShift "web"
  , className =? "jetbrains-pycharm-ce" --> doShift "work"
  -- , className =? "obsidian"             --> doShift "notes"
  , className =? "Postman"              --> doShift "dev"
  , className =? "Slack"                --> doShift "messages"
  , className =? "Spotify"              --> doShift "vibes"
  -- , className =? "zoom"                 --> doShift "work"
  ] <+> namedScratchpadManageHook myScratchPads
-- }}}

-- Apps and scripts to autorun at start (startupHook) {{{
myStartupHook :: X ()
myStartupHook = do
  return ()
  -- set programs to autorun on start for xmonad
  spawnOnce "exec xrandr --output DisplayPort-0 --set TearFree on --mode 1920x1080 --rate 144.00 --output HDMI-A-0 --set TearFree on --mode 1920x1080 --rate 60.00 &" -- set proper screen resolution and refresh rate
  spawnOnce "nitrogen --restore &" -- set wallpaper
  spawnOnce "picom &" -- compositor
  spawnOnce "flameshot &" -- screenshot tool
  spawnOnce "dunst &" -- notification manager
  spawnOnce "pulseaudio --start && pactl exit &" -- audio daemon and manager
  spawnOnce "pkill trayer || trayer --edge top --align right --width 15 --tint 0x27212e --alpha 0 --transparent true --expand true --monitor 1" -- trayer for right monitor
-- }}}

-- run main function {{{
main :: IO()
main = do
  -- start xmobar process
  xmobar0 <- spawnPipe "xmobar -x 0 ~/.config/xmonad/xmobar0.hs"
  xmobar1 <- spawnPipe "xmobar -x 1 ~/.config/xmonad/xmobar1.hs"
  -- pass myConfig object to xmonad
  xmonad $ ewmh $ docks def
    { terminal    = myTerm
    , modMask     = myMod
    , borderWidth = borderSize
    , normalBorderColor = borderUnfocused
    , focusedBorderColor = borderFocused
    , focusFollowsMouse = myFocusFollowsMouse -- focus of windows follows the mouse, I set this to true
    , clickJustFocuses = myClickJustFocuses
    , manageHook = myManageHook -- set my manage hook settings
    , startupHook = myStartupHook -- set my startup settings
    , handleEventHook = myHandleEventHook
    , layoutHook = myLayoutHook -- set my layout settings
    , workspaces = myWorkspaces -- set my workspaces
    , logHook = workspaceHistoryHook <+> dynamicLogWithPP xmobarPP 
      { 
        ppOutput = \x -> hPutStrLn xmobar0 x >> hPutStrLn xmobar1 x
      , ppCurrent = xmobarColor "#eb64b9" ""                -- current workspace
      , ppVisible = xmobarColor "#74dfc4" ""                -- visible, but on another monitor (inactive)
      , ppHidden  = xmobarColor "#b381c5" ""                -- not visible, but has windows on it
      , ppHiddenNoWindows  = xmobarColor "#716385" ""       -- hidden (not visible, no windows on it)
      , ppUrgent  = xmobarColor "#ffe261" "" . wrap "*" ""  -- urgent workspaces
      , ppSep = "<fc=#91889b> | </fc>"                      -- separator for xmobar
      , ppLayout = xmobarColor "#b381c5" ""                 -- layout name format
      , ppOrder = \(ws:l:_) -> [ws,l]                       -- overwrite default order (I removed window title with `_`)
      } >> updatePointer (0, 0) (0, 0)
    } `additionalKeysP` myKeybindings
-- }}}
