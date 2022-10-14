local ok, colorizer = pcall(require, 'colorizer')
if not ok then
  return
end

-- Ignore certain filetypes that will cause issues, otherwise highlight everywhere!
colorizer.setup {
  filetypes = {
    '*',
    '!TelescopePrompt',
    '!TelescopeResults',
    '!help',
    '!harpoon',
    '!DiffviewFiles',
  },
  buftypes = {
    '*',
    '!prompt',
    '!popup',
  },
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    RRGGBBAA = true,
    AARRGGBB = false,
    rgb_fn = true,
    hsl_fn = true,
    names = false,
    css = false,
    css_fn = false,
    tailwind = true,
    mode = 'virtualtext',
    virtualtext = '■',
  },
}
