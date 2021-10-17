require('lualine').setup {
  options = {
    theme = 'rose-pine',
    section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    icons_enabled = true,
    lower = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'filename',
        path = 0,
        lower = false,
      }
    },
    lualine_c = {
      -- 'branch',
      {
        'diff',
        colored = true,
        color_added = { fg = '#266d6a' },
        color_modified = { fg = '#536c9e' },
        color_removed = { fg = '#b2555b' },
        symbols = { added = '+', modified = '~', removed = '-' },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info' },
        color_error = { fg = '#db4b4b' },
        color_warn = { fg = '#e0af68' },
        color_info = { fg = '#1abc9c' },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
        },
      },
    },
    lualine_y = {'filetype'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'filetype'},
    lualine_z = {'location'},
  },
  tabline = {
    lualine_a = {},
    lualine_b = {
      {
        'filename',
        path = 1,
        lower = false,
      }
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'branch'},
    lualine_z = {},
  },
}
