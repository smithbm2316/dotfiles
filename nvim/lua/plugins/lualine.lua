local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

lualine.setup {
  options = {
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    icons_enabled = true,
    lower = true,
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      {
        'filename',
        path = 1,
        lower = false,
        shorting_target = 70,
      },
    },
    lualine_c = {
      {
        'diff',
        colored = true,
        symbols = { added = '+', modified = '~', removed = '-' },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        diagnostics_color = {
          error = 'DiagnosticError',
          warn = 'DiagnosticWarn',
          info = 'DiagnosticInfo',
          hint = 'DiagnosticHint',
        },
        colored = true,
        symbols = _G.diagnostic_icons,
        -- separator = { left = '|' },
        update_in_insert = false,
        always_visible = false,
      },
    },
    lualine_y = { 'filetype' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      {
        'filename',
        path = 1,
        lower = false,
        shorting_target = 70,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      {
        'branch',
        color = { fg = '#c4a7e7' },
        separator = { left = '' },
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
}
