-- load and setup core plugins before all others
local core_plugins = {
  'nvim_web_devicons',
  'lspconfig',
  'treesitter',
  'cmp',
}
for _, plug in pairs(core_plugins) do
  require(string.format('my.plugs.%s', plug))
end

-- list of plugin configs
local plugins = {
  'autopairs',
  'colorizer',
  'comment',
  'formatter',
  'gitsigns',
  'lir',
  'lualine',
  'luapad',
  'telescope',
  'which-key',
  'zen-mode',
  'zk',
}
-- loop through and load each plugin config file
for _, plug in pairs(plugins) do
  require(string.format('my.plugs.%s', plug))
end

-- TODO: refactor my/plugs dir to have 'priority', 'deprecated', and 'active' plugin dirs
--[[
local plugin_config_root = 'my.plugs.'
local plugin_config_files = vim.fn.globpath('lua/my/plugs', '*.lua')

for plugin_name in plugin_config_files:gmatch('([%w%d-_]+).lua') do
  require(plugin_config_root .. plugin_name)
end
--]]
