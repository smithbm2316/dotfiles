local gitsigns = require 'gitsigns'

gitsigns.setup {
  keymaps = nil,
  preview_config = {
    border = 'double',
  },
}

vim.keymap.set('n', '<leader>gn', function()
  gitsigns.nav_hunk 'next'
end, { desc = 'Next hunk' })

vim.keymap.set('n', '<leader>gp', function()
  gitsigns.nav_hunk 'prev'
end, { desc = 'Previous hunk' })

vim.keymap.set(
  { 'n', 'v' },
  '<leader>hs',
  gitsigns.stage_hunk,
  { desc = 'Stage hunk' }
)

vim.keymap.set(
  'n',
  '<leader>hu',
  gitsigns.undo_stage_hunk,
  { desc = 'Unstage hunk' }
)

vim.keymap.set(
  { 'n', 'v' },
  '<leader>hr',
  gitsigns.reset_hunk,
  { desc = 'Reset hunk' }
)

vim.keymap.set(
  'n',
  '<leader>hR',
  gitsigns.reset_buffer,
  { desc = 'Reset buffer' }
)

vim.keymap.set(
  'n',
  '<leader>hh',
  gitsigns.preview_hunk,
  { desc = 'Preview hunk' }
)

vim.keymap.set('n', '<leader>hb', function()
  gitsigns.blame_line(true)
end, { desc = 'Blame line' })

vim.keymap.set(
  'n',
  '<leader>hS',
  gitsigns.stage_buffer,
  { desc = 'Stage buffer' }
)

vim.keymap.set(
  'n',
  '<leader>hU',
  gitsigns.reset_buffer_index,
  { desc = 'Reset buffer index' }
)
