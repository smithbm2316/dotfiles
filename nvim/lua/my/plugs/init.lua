local plugins = {
  'tokyonight',
  'nvim-compe',
  'nvim-autopairs',
  'nvim-lightbulb',
  'nvim-lspconfig',
  'nvim-web-devicons',
  'telescope',
  'treesitter',
  'gitsigns',
  'formatter-nvim',
  'nvim-ts-autotag',
  'kommentary',
  'colorizer',
  'lualine',
  'luapad',
  'which-key',
}

for _, plug in pairs(plugins) do
  require(string.format('my.plugs.%s', plug))
end
