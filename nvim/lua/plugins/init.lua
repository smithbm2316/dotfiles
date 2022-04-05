-- runtime path to current file
local core_plugins = vim.fn.globpath('~/dotfiles/nvim/lua/plugins', '*/', false, true)
local plugins = vim.fn.globpath('~/dotfiles/nvim/lua/plugins', '*.lua', false, true)
local ignore = { 'inactive', 'opt' }

-- load and setup core plugins before all others
for _, core_path in ipairs(core_plugins) do
  local core_plugin = core_path:sub(0, -2):gsub('.+/', '')
  if not vim.tbl_contains(ignore, core_plugin) then
    require('plugins.' .. core_plugin)
  end
end

-- load all other plugins
for _, plugin_path in ipairs(plugins) do
  local plugin = plugin_path:gsub('.+/', ''):sub(0, -5)

  if plugin ~= 'init' then
    require('plugins.' .. plugin)
  end
end
