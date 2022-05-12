-- hyper keys
local hyper = { 'shift', 'ctrl', 'option' }
local cmd_hyper = { 'shift', 'ctrl', 'option', 'cmd' }

-- screens
local screens = hs.screen.allScreens()
local primary_screen, other_screen = screens[1], screens[2]

-- print table helper
function tprint(tbl, indent)
  if not indent then
    indent = 0
  end
  for k, v in pairs(tbl) do
    formatting = string.rep('  ', indent) .. k .. ': '
    if type(v) == 'table' then
      print(formatting)
      tprint(v, indent + 1)
    else
      print(formatting .. tostring(v))
    end
  end
end

-- helper function for getting an App's Bundle ID
function getAppId(app)
  return hs.application.infoForBundlePath(string.format('/Applications/%s.app', app))['CFBundleIdentifier']
end

-- "i used the spoon to install the spoons" - thanos
hs.loadSpoon 'SpoonInstall'
-- keep all spoons up to date
Install = spoon.SpoonInstall
Install.use_syncinstall = true

-- configure what repositories to install spoons from
Install.repos = {
  default = {
    url = 'https://github.com/Hammerspoon/Spoons',
    desc = 'Main Hammerspoon Spoon repository',
    branch = 'master',
  },
}
-- homebrew info
Install:andUse 'BrewInfo'

-- Alfred and spotlight-like launcher
Install:andUse('Seal', {
  hotkeys = {
    toggle = {
      hyper,
      'o',
    },
  },
  fn = function()
    local seal = spoon.Seal
    -- load all of the seal plugins I want
    seal:loadPlugins {
      'apps',
      'calc',
      'useractions',
    }
    seal.plugins.apps.appSearchPaths = {
      '/Applications',
      '~/Applications',
      '/Developer/Applications',
      -- '/Applications/Xcode.app/Contents',
      -- '/usr/local/Cellar',
      '/System/Applications',
      -- '/System/Library/PreferencePanes',
      -- '~/Library/PreferencePanes',
    }
    seal.plugins.apps:restart()
    -- define my own custom actions
    seal.plugins.useractions.actions = {
      hammer = {
        keyword = 'hammer',
        url = 'https://hammerspoon.org/docs',
      },
      gh = {
        keyword = 'gh',
        url = 'https://github.com/search?q=${query}',
      },
      ddg = {
        keyword = 'ddg',
        url = 'https://duckduckgo.com/?q=%{query}',
      },
      sleep = {
        keyword = 'sleep',
        fn = function()
          os.execute 'pmset sleepnow'
        end,
      },
      lock = {
        keyword = 'lock',
        fn = function()
          hs.osascript.applescriptFromFile 'lockScreen.applescript'
        end,
      },
      scrollDir = {
        keyword = 'scrollDir',
        fn = function()
          hs.osascript.applescriptFromFile 'scrollDirectionToggle.applescript'
        end,
      },
      theme = {
        keyword = 'theme',
        fn = function()
          hs.osascript.applescriptFromFile 'toggleTheme.applescript'
        end,
      },
      lunch = {
        keyword = 'lunch',
        fn = function()
          hs.execute('slack-status lunch', true)
        end,
      },
      backToWork = {
        keyword = 'backToWork',
        fn = function()
          hs.execute('slack-status clear', true)
        end,
      },
    }
    seal:refreshAllCommands()
  end,
  start = true,
})

-- TODO: call Amethyst's reset windows after these keybinds
Install:andUse 'WindowScreenLeftAndRight'
local WindowScreenLeftAndRight = spoon.WindowScreenLeftAndRight
WindowScreenLeftAndRight.animationDuration = 0
WindowScreenLeftAndRight:bindHotkeys {
  screen_left = { hyper, ',' },
  screen_right = { hyper, ';' },
}

-- Close the current tab if the focused app is in the apps_with_tabs list,
-- otherwise close the currently focused window
hs.hotkey.bind(hyper, 'c', nil, function()
  local apps_with_tabs = {
    'Dash',
    'Firefox',
    'Firefox Developer Edition',
    'Vivaldi',
    'Safari',
    'Google Chrome Canary',
    'Sizzy',
    'Polypane',
    'Brave Browser',
  }
  local current_app = hs.application.frontmostApplication()

  local closed_app = false
  for _, app in ipairs(apps_with_tabs) do
    if current_app:title() == app then
      hs.eventtap.keyStroke({ 'cmd' }, 'w')
      closed_app = true
      break
    end
  end

  if not closed_app then
    hs.window.focusedWindow():close()
  end
end)

-- Close the current window of an application. If it's the last one, kill the app.
hs.hotkey.bind(cmd_hyper, 'c', nil, function()
  local current_app = hs.application.frontmostApplication()
  local closedWindow = hs.window.focusedWindow():close()
  if not current_app:focusedWindow() then
    current_app:kill()
  end
end)

-- Random hammerspoon/system options to view
hs.hotkey.bind(cmd_hyper, 'o', nil, function()
  local actions = {
    lock = function()
      hs.osascript.applescriptFromFile 'lockScreen.applescript'
    end,
    sleep = function()
      os.execute 'pmset sleepnow'
    end,
    ['Show current app name'] = function()
      hs.alert.show(hs.application.frontmostApplication():name(), nil, hs.screen.primaryScreen())
    end,
    ['mouse buttons'] = function()
      tprint(hs.mouse.getButtons())
    end,
    ['px to em'] = function(s)
      tprint(s)
      hs.alert.show 'testing'
    end,
  }

  local options = {}
  for key, _ in pairs(actions) do
    options[#options + 1] = { text = key }
  end

  local chooser = hs.chooser.new(function(choice)
    actions[choice.text]()
  end)
  chooser:choices(options)
  chooser:show()
end)

-- TODO: make drink water/get up reminder in bar
-- TODO: make weather menu bar app that `curl`s wttr.in/?format=1
-- TODO: make seal integration to open the docs for tools I commonly use
-- TODO: make auto-clicker for notifications with keyboard
-- TODO: make calculator for px -> em / em -> px with seal/hs.chooser

local current_space_filter = function(allowed_screen)
  return hs.window.filter.new {
    override = {
      allowScreens = allowed_screen,
      currentSpace = true,
      visible = true,
    },
  }
end

local screens = hs.screen.allScreens()
local primary_filter = current_space_filter(screens[1]:name())
local secondary_filter
if #screens == 2 then
  current_space_filter(screens[2]:name())
end

local current_space_switcher = function(screen_switcher)
  return hs.window.switcher.new(screen_switcher, {
    showSelectedThumbnail = false,
    showThumbnails = true,
    showTitles = true,
  })
end
local primary_switcher = current_space_switcher(primary_filter)
local secondary_switcher = current_space_switcher(secondary_filter)

local next_app = function()
  print(hs.screen.primaryScreen():name(), ' <-> ', hs.screen.mainScreen():name())
  if hs.screen.primaryScreen():name() == hs.mouse.getCurrentScreen():name() then
    primary_switcher:next()
    print 'next primary'
  else
    secondary_switcher:next()
    print 'next secondary'
  end
end
local prev_app = function()
  if hs.screen.primaryScreen():name() == hs.mouse.getCurrentScreen():name() then
    primary_switcher:previous()
    print 'previous primary'
  else
    secondary_switcher:previous()
    print 'next secondary'
  end
end

hs.hotkey.bind('alt', 'j', 'next app', next_app, nil, next_app)
hs.hotkey.bind('alt', 'k', 'prev app', prev_app, nil, prev_app)

-- define custom keybindings for specific apps
local app_keybind = function(from_modifiers, from_key, to_modifiers, to_key, app_name)
  local app_keybind = hs.hotkey.new(from_modifiers, from_key, nil, function()
    hs.eventtap.keyStroke(to_modifiers, to_key)
  end)
  local app_filter = hs.window.filter.new(false):setAppFilter(app_name)

  app_filter:subscribe {
    windowFocused = function()
      app_keybind:enable()
    end,
    windowUnfocused = function()
      app_keybind:disable()
    end,
  }
end

-- scroll in Dash.app
app_keybind({ 'ctrl' }, 'd', {}, 'pagedown', 'Dash')
app_keybind({ 'ctrl' }, 'u', {}, 'pageup', 'Dash')
app_keybind({ 'ctrl' }, 'g', {}, 'home', 'Dash')
app_keybind({ 'ctrl', 'shift' }, 'g', {}, 'end', 'Dash')

-- scroll in Slack
app_keybind({ 'ctrl' }, 'd', {}, 'pagedown', 'Slack')
app_keybind({ 'ctrl' }, 'u', {}, 'pageup', 'Slack')
app_keybind({ 'ctrl' }, 'e', { 'shift', 'cmd' }, '\\', 'Slack')
app_keybind({ 'ctrl' }, 'o', { 'cmd' }, '[', 'Slack')
app_keybind({ 'ctrl' }, 'i', { 'cmd' }, ']', 'Slack')

-- Switch between previous and next conversations, scroll in Messages
app_keybind({ 'ctrl' }, 'n', { 'ctrl' }, 'tab', 'Messages')
app_keybind({ 'ctrl' }, 'p', { 'ctrl', 'shift' }, 'tab', 'Messages')
app_keybind({ 'ctrl' }, 'r', { 'cmd' }, 'r', 'Messages')
app_keybind({ 'ctrl' }, 'd', {}, 'pagedown', 'Messages')
app_keybind({ 'ctrl' }, 'u', {}, 'pageup', 'Messages')

-- Switch between previous and next conversations, scroll in Polypane
app_keybind({ 'ctrl' }, '[', { 'cmd' }, 'd', 'Polypane')
app_keybind({ 'cmd' }, 'd', {}, 'pagedown', 'Polypane')
app_keybind({ 'ctrl' }, 'u', {}, 'pageup', 'Polypane')

-- Sizzy
-- Open the command palette/butler in Sizzy
-- app_keybind('ctrl', 'h', 'alt', 'b', 'Sizzy')
app_keybind('cmd', 'd', {}, 'pagedown', 'Sizzy')
app_keybind('ctrl', 'u', {}, 'pageup', 'Sizzy')
app_keybind('ctrl', 'n', {}, 'down', 'Sizzy')
app_keybind('ctrl', 'p', {}, 'up', 'Sizzy')

-- bind keystroke to mouse button for a specific app
local mouse_app_binds = function(to_mods, to_key, app_name)
  if hs.application.frontmostApplication():name() == app_name then
    hs.eventtap.keyStroke(to_mods, to_key)
  end
end

-- mouse button 4 binds
local mouse_events = hs.eventtap.new({ 14 }, function(event)
  if event:getButtonState(3) then
    mouse_app_binds({}, 'h', 'Figma')
    return true
  elseif event:getButtonState(4) then
    mouse_app_binds({}, 'v', 'Figma')
    return true
  end
  return false
end)
mouse_events:start()

-- Open up the AirDrop menu to send a URL to another device
function airdropper()
  -- also can use com.apple.messages.ShareExtension for composing imessages
  local sharer = hs.sharing.newShare 'com.apple.share.AirDrop.send'
  local link = { hs.sharing.URL(hs.pasteboard.getContents(), false) }
  if sharer:canShareItems(link) then
    sharer:shareItems(link)
  else
    hs.alert.show 'The URL in your clipboard was not valid'
  end
end
hs.hotkey.bind(cmd_hyper, 'a', nil, airdropper, nil, airdropper)

-- Load plugin to fade in the Hammerspoon logo when reloading configuration
Install:andUse 'FadeLogo'
-- reload config on change
Install:andUse('ReloadConfiguration', {
  fn = function()
    spoon.FadeLogo.run_time = 1.2
    spoon.FadeLogo:start()
  end,
  hotkeys = {
    reloadConfiguration = {
      hyper,
      'r',
    },
  },
  start = false,
})
