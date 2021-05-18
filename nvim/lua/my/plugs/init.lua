-- load colorscheme config first before other plugin configs in case of issues
require('my.plugs.tokyonight')

-- list of plugin configs
local plugins = {
  'autopairs',
  'colorizer',
  'compe',
  'gitsigns',
  'kommentary',
  'lightbulb',
  'lir',
  'lspconfig',
  'lualine',
  'luapad',
  'telescope',
  'treesitter',
  'web-devicons',
  'which-key',
}

-- loop through and load each plugin config file
for _, plug in pairs(plugins) do
  require(string.format('my.plugs.%s', plug))
end
