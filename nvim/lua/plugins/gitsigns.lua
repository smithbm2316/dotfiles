local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
  return
end

gitsigns.setup {
  keymaps = nil,
  preview_config = {
    border = 'double',
  },
}

nnoremap('<leader>gn', function()
  require('gitsigns.actions').next_hunk()
end, 'Next hunk')

nnoremap('<leader>gp', function()
  require('gitsigns.actions').prev_hunk()
end, 'Previous hunk')

noremap({ 'n', 'v' }, '<leader>hs', function()
  require('gitsigns').stage_hunk()
end, 'Stage hunk')

nnoremap('<leader>hu', function()
  require('gitsigns').undo_stage_hunk()
end, 'Unstage hunk')

noremap({ 'n', 'v' }, '<leader>hr', function()
  require('gitsigns').reset_hunk()
end, 'Reset hunk')

nnoremap('<leader>hR', function()
  require('gitsigns').reset_buffer()
end, 'Reset buffer')

nnoremap('<leader>hh', function()
  require('gitsigns').preview_hunk()
end, 'Preview hunk')

nnoremap('<leader>hb', function()
  require('gitsigns').blame_line(true)
end, 'Blame line')

nnoremap('<leader>hS', function()
  require('gitsigns').stage_buffer()
end, 'Stage buffer')

nnoremap('<leader>hU', function()
  require('gitsigns').reset_buffer_index()
end, 'Reset buffer index')
