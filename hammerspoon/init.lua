-- hyper keys
local hyper = { 'shift', 'cmd', 'option' }
local cmd_hyper = { 'shift', 'ctrl', 'option', 'cmd' }

-- helper function for getting an App's Bundle ID
function AppId(app)
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
      'option',
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
      ['Lock and Sleep screen'] = {
        keyword = 'lock',
        name = 'Lock Screen',
        fn = function() os.execute('pmset sleepnow') end,
      },
    }
    seal:refreshAllCommands()
  end,
  start = true,
})

-- Keyboard shortcut cheatsheet
Install:andUse('KSheet', {
  hotkeys = {
    toggle = { hyper, '/' },
  },
})


-- TODO make drink water/get up reminder in bar
-- TODO make weather menu bar app that `curl`s wttr.in/?format=1
-- TODO make seal integration to open the docs for tools I commonly use


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
  start = true,
})
