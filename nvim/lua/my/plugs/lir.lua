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
    ['d']     = actions.mkdir,
    ['f']     = actions.newfile,
    ['r']     = actions.rename,
    ['@']     = actions.cd,
    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['dd']     = actions.delete,
    ['y'] = clipboard_actions.copy,
    ['x'] = clipboard_actions.cut,
    ['p'] = clipboard_actions.paste,
  },
  float = {
    size_percentage = 0.5,
    winblend = 0,
    border = false,
    -- borderchars = {"╔" , "═" , "╗" , "║" , "╝" , "═" , "╚", "║"},
    shadow = true,
  },
  hide_cursor = true,
}

vim.api.nvim_set_keymap('n', '<leader>fe', [[<cmd>lua require'lir.float'.toggle()<cr>]], { noremap = true, silent = true })
