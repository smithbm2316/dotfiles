local ok, colorizer = pcall(require, 'colorizer')
if not ok then
  return
end

-- Ignore certain filetypes that will cause issues, otherwise highlight everywhere!
colorizer.setup({
  '*',
  '!TelescopePrompt',
  '!TelescopeResults',
  '!help',
  '!harpoon',
  '!DiffviewFiles',
}, {
  RGB = true,
  RRGGBB = true,
  RRGGBBAA = true,
  names = false,
  rgb_fn = true,
  hsl_fn = true,
  css = true,
  css_fn = true,
  mode = 'virtualtext',
  virtualtext = '■',
})
