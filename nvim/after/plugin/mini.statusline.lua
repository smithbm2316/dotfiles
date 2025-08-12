local signs = {
  ERROR = diagnostic_icons[vim.diagnostic.severity.ERROR],
  WARN = diagnostic_icons[vim.diagnostic.severity.WARN],
  INFO = diagnostic_icons[vim.diagnostic.severity.INFO],
  HINT = diagnostic_icons[vim.diagnostic.severity.HINT],
}

require('mini.statusline').setup {
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local diff = MiniStatusline.section_diff { trunc_width = 75 }
      local diagnostics = MiniStatusline.section_diagnostics {
        trunc_width = 75,
        signs = {
          ERROR = '!',
          WARN = '?',
          INFO = '@',
          HINT = '*',
        },
      }
      local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local search = MiniStatusline.section_searchcount { trunc_width = 75 }

      -- force short output always by truncating anytime # of columns < 1000 (effectively always)
      local filename = MiniStatusline.section_filename { trunc_width = 1000 }
      local location = MiniStatusline.section_location { trunc_width = 1000 }

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        {
          hl = 'MiniStatuslineDevinfo',
          strings = { diff, diagnostics, lsp },
        },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      }
    end,
  },
}
