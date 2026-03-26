local gitsigns = require 'gitsigns'

gitsigns.setup {
  keymaps = nil,
  preview_config = {
    border = 'double',
  },
}

vim.keymap.set('n', '<leader>gn', function()
  gitsigns.nav_hunk 'next'
end, { desc = '[g]it [n]ext hunk' })

vim.keymap.set('n', '<leader>gp', function()
  gitsigns.nav_hunk 'prev'
end, { desc = '[g]it [p]revious hunk' })

vim.keymap.set('n', '<leader>gb', function()
  gitsigns.blame_line { full = true }
end, { desc = '[g]it [b]lame line' })

vim.keymap.set('n', '<leader>gB', gitsigns.blame, { desc = '[g]it [B]lame' })

vim.keymap.set(
  'n',
  '<leader>gR',
  gitsigns.reset_buffer,
  { desc = '[g]it [R]eset buffer' }
)

vim.keymap.set(
  'n',
  '<leader>gq',
  '<cmd>Gitsigns setqflist<cr>',
  { desc = '[g]it hunks to [q]uickfix list' }
)

vim.keymap.set(
  { 'n', 'v' },
  '<leader>hs',
  gitsigns.stage_hunk,
  { desc = 'git [h]unk [s]tage' }
)

vim.keymap.set(
  'n',
  '<leader>hu',
  gitsigns.undo_stage_hunk,
  { desc = 'git [h]unk [u]nstage' }
)

vim.keymap.set(
  { 'n', 'v' },
  '<leader>hr',
  gitsigns.reset_hunk,
  { desc = 'git [h]unk [r]eset' }
)

vim.keymap.set(
  'n',
  '<leader>hR',
  gitsigns.reset_buffer,
  { desc = 'git [h]unk [R]eset buffer' }
)

vim.keymap.set(
  'n',
  '<leader>hp',
  gitsigns.preview_hunk_inline,
  { desc = 'git [h]unk [p]review inline' }
)

vim.keymap.set(
  'n',
  '<leader>hh',
  gitsigns.preview_hunk,
  { desc = 'git [h]unk preview [h]over' }
)
