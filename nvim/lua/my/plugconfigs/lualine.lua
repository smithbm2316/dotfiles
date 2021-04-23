require('lualine').setup{
  options = {
    theme = 'tokyonight',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = true,
    lower = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {'branch'},
    lualine_x = {'encoding'},
    lualine_y = {'filetype'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {'branch'},
    lualine_x = {'filetype'},
    lualine_y = {'location'},
    lualine_z = {},
  },
}
