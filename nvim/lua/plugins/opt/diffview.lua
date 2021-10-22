local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false,
  file_panel = {
    width = 30,
    use_icons = true,
  },
  key_bindings = {
    view = {
      ['<tab>'] = cb('select_next_entry'),
      ['<c-tab>'] = cb('select_prev_entry'),
      ['<leader>ff'] = cb('focus_files'),
      ['<leader>sf'] = cb('toggle_files'),
    },
    file_panel = {
      ["j"]         = cb("next_entry"),
      ["k"]         = cb("prev_entry"),
      ["<cr>"]      = cb("select_entry"),
      ["o"]         = cb("select_entry"),
      ["r"]         = cb("refresh_files"),
      ["<tab>"]     = cb("select_next_entry"),
      ["<c-tab>"]   = cb("select_prev_entry"),
      ["<leader>ff"] = cb("focus_files"),
      ["<leader>sf"] = cb("toggle_files"),
    },
  },
}
