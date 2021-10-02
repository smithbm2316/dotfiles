-- hyper keys
local hyper = { 'shift', 'ctrl', 'option' }
local cmd_hyper = { 'shift', 'ctrl', 'option', 'cmd' }

-- print table helper
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    else
      print(formatting .. tostring(v))
    end
  end
end

-- helper function for getting an App's Bundle ID
function getAppId(app)
  return hs.application.infoForBundlePath(
    string.format('/Applications/%s.app', app)
  )['CFBundleIdentifier']
end

-- "i used the spoon to install the spoons" - thanos
hs.loadSpoon('SpoonInstall')
-- keep all spoons up to date
Install = spoon.SpoonInstall
Install.use_syncinstall = true

-- configure what repositories to install spoons from
Install.repos = {
  default = {
    url = 'https://github.com/Hammerspoon/Spoons',
    desc = 'Main Hammerspoon Spoon repository',
    branch = 'master',
  }
}
-- homebrew info
Install:andUse('BrewInfo')

-- Alfred and spotlight-like launcher
Install:andUse('Seal', {
  hotkeys = {
    toggle = {
      hyper,
      'o'
    },
  },
  fn = function()
    local seal = spoon.Seal
    -- load all of the seal plugins I want
    seal:loadPlugins({
      'apps', 'calc', 'useractions'
    })
    -- define my own custom actions
    seal.plugins.useractions.actions = {
      ['Hammerspoon Docs'] = {
        keyword = 'hammer',
        name = 'Hammerspoon Docs',
        url = 'https://hammerspoon.org/docs',
      },
      GitHub = {
        keyword = 'gh',
        name = 'GitHub',
        url = 'https://github.com/search?q=${query}',
      },
      DuckDuckGo = {
        keyword = 'ddg',
        name = 'DuckDuckGo',
        url = 'https://duckduckgo.com/?q=%{query}',
      },
      Sleep = {
        keyword = 'sleep',
        name = 'Sleep',
        fn = function() os.execute('pmset sleepnow') end,
      },
      Lock = {
        keyword = 'lock',
        name = 'Lock Screen',
        fn = function()
          hs.osascript.applescriptFromFile('lockScreen.applescript')
        end,
      },
    }
    seal:refreshAllCommands()
  end,
  start = true,
})

-- Keyboard shortcut cheatsheet
Install:andUse('KSheet', {
  hotkeys = {
    toggle = { cmd_hyper , '/' },
  },
})

-- Close the current window of an application. If it's the last one, kill the app.
hs.hotkey.bind(hyper, 'c', nil, function()
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
      hs.osascript.applescriptFromFile('lockScreen.applescript')
    end,
    sleep = function()
      os.execute('pmset sleepnow')
    end,
    ['Show current app name'] = function()
      hs.alert.show(hs.application.frontmostApplication():name(),
        nil, hs.screen.primaryScreen())
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

-- TODO make drink water/get up reminder in bar
-- TODO make weather menu bar app that `curl`s wttr.in/?format=1
-- TODO make seal integration to open the docs for tools I commonly use




local current_space_filter = function(allowed_screen)
  return hs.window.filter.new {
    override = {
      allowScreens = allowed_screen,
      currentSpace = true,
      visible = true,
    }
  }
end
local primary_filter = current_space_filter(hs.screen.allScreens()[1]:name())
local secondary_filter = current_space_filter(hs.screen.allScreens()[2]:name())

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
    print('next primary')
  else
    secondary_switcher:next()
    print('next secondary')
  end
end
local prev_app = function()
  if hs.screen.primaryScreen():name() == hs.mouse.getCurrentScreen():name() then
    primary_switcher:previous()
    print('previous primary')
  else
    secondary_switcher:previous()
    print('next secondary')
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

-- Use hyper+/ to launch Google Chrome Canary's dev tools command palette
app_keybind(hyper, '/', { 'cmd', 'shift' }, 'p', 'Google Chrome Canary')


-- define hammerspoon mode
--[[
HsMode = hs.hotkey.modal.new(hyper, '`')
-- callbacks for hammerspoon mode
function HsMode:entered() hs.alert('Hammerspoon time') end
function HsMode:exited() hs.alert('Back to normal') end
-- allow way to exit from hammerspoon mode easily
HsMode:bind('', 'escape', function() HsMode:exit() end)
HsMode:bind('cmd', 'c', function() HsMode:exit() end)
HsMode:bind(hyper, '`', function() HsMode:exit() end)

-- Launch seal
HsMode:bind('', 'o', function() spoon.Seal:toggle(); HsMode:exit() end)
--]]






-- Load plugin to fade in the Hammerspoon logo when reloading configuration
Install:andUse('FadeLogo')
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
