local function vim_obsession() return vim.fn.ObsessionStatus(" session", "") end

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
    lualine_b = {
      {
        'filename',
        lower = false,
      }
    },
    lualine_c = {'branch'},
    lualine_x = {vim_obsession},
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
