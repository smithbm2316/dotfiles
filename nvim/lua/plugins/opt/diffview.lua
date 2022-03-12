local has_diffview, diffview = pcall(require, 'diffview')

if has_diffview then
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
  }
end
