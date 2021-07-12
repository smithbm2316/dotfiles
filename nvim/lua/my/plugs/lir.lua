local actions = require('lir.actions')
local clipboard_actions = require('lir.clipboard.actions')

require('lir').setup {
  show_hidden_files = true,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<cr>']  = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,
    ['h']     = actions.up,
    ['q']     = actions.quit,
    ['f']     = actions.mkdir,
    ['e']     = actions.newfile,
    ['r']     = actions.rename,
    ['C']     = actions.cd,
    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['d']     = actions.delete,
    ['y'] = clipboard_actions.copy,
    ['x'] = clipboard_actions.cut,
    ['p'] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
  },
  hide_cursor = true,
}

vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require'lir.float'.toggle()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fe', [[<cmd>lua require'lir.float'.toggle(vim.fn.getcwd())<cr>]], { noremap = true, silent = true })
