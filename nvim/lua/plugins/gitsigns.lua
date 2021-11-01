require('gitsigns').setup {
  keymaps = {
    noremap = true,
    ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<cr>'" },
    ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<cr>'" },
    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<cr>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<cr>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<cr>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<cr>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<cr>',
    ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<cr>',
    ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<cr>',
  },
  preview_config = {
    border = 'double',
  },
}
