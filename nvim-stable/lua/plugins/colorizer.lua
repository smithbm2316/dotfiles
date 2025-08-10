return {
  'NvChad/nvim-colorizer.lua',
  ft = {
    'css',
    'less',
    'sass',
    'scss',
    'stylus',
  },
  opts = {
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
  },
}
