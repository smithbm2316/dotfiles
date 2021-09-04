local actions = require('lir.actions')
local clipboard_actions = require('lir.clipboard.actions')
local get_context = require('lir.vim').get_context

local function create_file(edit_cmd)
  local ctx = get_context()
  edit_cmd = edit_cmd .. ' '

  if vim.w.lir_is_float then
    vim.api.nvim_feedkeys(':close | :' .. edit_cmd .. ctx.dir, 'n', true)
  else
    vim.api.nvim_feedkeys(':keepalt ' .. edit_cmd .. ctx.dir, 'n', true)
  end
end

local function edit() create_file 'edit' end
local function v_edit() create_file 'vsplit' end
local function sp_edit() create_file 'split' end

local show_hidden = false
if vim.fn.getcwd() == vim.fn.expand('$HOME') .. '/dotfiles' then
  show_hidden = true
end

require('lir').setup {
  show_hidden_files = show_hidden,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<cr>']  = actions.edit,
    ['s']     = sp_edit,
    ['v']     = v_edit,
    ['<c-s>'] = actions.split,
    ['<c-v>'] = actions.vsplit,
    ['<c-t>'] = actions.tabedit,
    ['h']     = actions.up,
    ['q']     = actions.quit,
    ['f']     = actions.mkdir,
    ['e']     = edit,
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

-- lir .: list files/directories for current buffer's location
vim.api.nvim_set_keymap('n', '<leader>l.', [[<cmd>lua require'lir.float'.toggle()<cr>]], { noremap = true, silent = true })
-- lir files: list files/directories for current project root
vim.api.nvim_set_keymap('n', '<leader>lf', [[<cmd>lua require'lir.float'.toggle(vim.fn.getcwd())<cr>]], { noremap = true, silent = true })

