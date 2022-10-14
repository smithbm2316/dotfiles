local diffview_ok, diffview = pcall(require, 'diffview')
if not diffview_ok then
  return
end

local actions_ok, actions = pcall(require, 'diffview.actions')
if not actions_ok then
  return
end

-- use ` instead of - for deletions
vim.opt.fillchars:append 'diff:`'

diffview.setup {
  diff_binaries = false,
  enhanced_diff_hl = true,
  use_icons = true,
  file_panel = {
    win_config = {
      type = 'float',
      position = 'top',
      height = 70,
      relative = 'editor',
    },
    listing_style = 'tree',
  },
  key_bindings = {
    view = {
      ['<tab>'] = actions.select_next_entry,
      ['<c-tab>'] = actions.select_prev_entry,
      ['<c-n>'] = actions.select_next_entry,
      ['<c-p>'] = actions.select_prev_entry,
      ['<leader>ff'] = actions.focus_files,
      ['<leader>sf'] = actions.toggle_files,
    },
    file_panel = {
      ['j'] = actions.next_entry,
      ['k'] = actions.prev_entry,
      ['<cr>'] = actions.select_entry,
      ['o'] = actions.select_entry,
      ['r'] = actions.refresh_files,
      ['<tab>'] = actions.select_next_entry,
      ['<c-tab>'] = actions.select_prev_entry,
      ['<c-n>'] = actions.select_next_entry,
      ['<c-p>'] = actions.select_prev_entry,
      ['<leader>ff'] = actions.focus_files,
      ['<leader>sf'] = actions.toggle_files,
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
