local ok, diffview = pcall(require, 'diffview')
if not ok then
  return
end

local cb = require('diffview.config').diffview_callback
-- use ` instead of - for deletions
vim.opt.fillchars:append 'diff:`'

diffview.setup {
  diff_binaries = false,
  enhanced_diff_hl = true,
  use_icons = true,
  file_panel = {
    width = 30,
    listing_style = 'list',
    -- tree_options = {
    --   flatten_dirs = true,
    --   folder_statuses = 'only_folded',
    -- },
  },
  key_bindings = {
    view = {
      ['<tab>'] = cb 'select_next_entry',
      ['<c-tab>'] = cb 'select_prev_entry',
      ['<leader>ff'] = cb 'focus_files',
      ['<leader>sf'] = cb 'toggle_files',
    },
    file_panel = {
      ['j'] = cb 'next_entry',
      ['k'] = cb 'prev_entry',
      ['<cr>'] = cb 'select_entry',
      ['o'] = cb 'select_entry',
      ['r'] = cb 'refresh_files',
      ['<tab>'] = cb 'select_next_entry',
      ['<c-tab>'] = cb 'select_prev_entry',
      ['<leader>ff'] = cb 'focus_files',
      ['<leader>sf'] = cb 'toggle_files',
    },
  },
  hooks = {
    view_opened = function()
      local has_focus, focus = pcall(require, 'focus')
      if has_focus then
        focus.focus_disable()
      end

      local windows = vim.api.nvim_tabpage_list_wins(0)
      local win_width = vim.api.nvim_list_uis()[1].width

      vim.api.nvim_win_set_width(windows[1], 30)
      vim.api.nvim_win_set_width(windows[2], (win_width - 30) / 2)
      vim.api.nvim_win_set_width(windows[3], (win_width - 30) / 2)
    end,
    view_closed = function()
      local has_focus, focus = pcall(require, 'focus')
      if has_focus then
        focus.focus_enable()
      end
    end,
  },
}
