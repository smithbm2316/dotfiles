local actions = require 'lir.actions'
local mark = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'
local get_context = require('lir.vim').get_context

-- wrapper for creating a new file with nicer mappings
local function create_file(edit_cmd)
  local ctx = get_context()
  edit_cmd = edit_cmd .. ' '

  if vim.w.lir_is_float then
    vim.api.nvim_feedkeys(':close | :' .. edit_cmd .. ctx.dir, 'n', true)
  else
    vim.api.nvim_feedkeys(':keepalt ' .. edit_cmd .. ctx.dir, 'n', true)
  end
end

-- wrapper for cutting or copying a file without having to manually mark it first
local function cut_or_copy(action)
  local ctx = get_context()
  local marked = ctx:get_marked_items()
  if #marked == 0 then
    mark.toggle_mark()
  end
  clipboard_actions[action]()
end

-- Table of wrapper functions for lir actions
local Wrappers = {}
Wrappers.edit = function()
  create_file 'edit'
end
Wrappers.vedit = function()
  create_file 'vsplit'
end
Wrappers.sedit = function()
  create_file 'split'
end
Wrappers.cut = function()
  cut_or_copy 'cut'
end
Wrappers.copy = function()
  cut_or_copy 'copy'
end

require('lir').setup {
  show_hidden_files = string.find(vim.fn.getcwd(), os.getenv 'HOME' .. '/dotfiles') and true or false,
  devicons_enable = true,
  mappings = {
    ['<cr>'] = actions.edit,
    ['<c-s>'] = actions.split,
    ['<c-v>'] = actions.vsplit,
    ['<c-t>'] = actions.tabedit,
    ['.'] = actions.toggle_show_hidden,
    l = actions.edit,
    s = Wrappers.sedit,
    v = Wrappers.vedit,
    e = Wrappers.edit,
    h = actions.up,
    q = actions.quit,
    f = actions.mkdir,
    r = actions.rename,
    c = actions.cd,
    Y = actions.yank_path,
    d = actions.wipeout,
    y = Wrappers.copy,
    x = Wrappers.cut,
    p = clipboard_actions.paste,
    m = mark.toggle_mark,
  },
  float = {
    winblend = 0,
    curdir_window = {
      enable = true,
      highlight_dirname = true,
    },
    win_opts = function()
      return {
        border = 'double',
        width = math.max(42, math.floor(vim.o.columns * 0.25)),
        height = math.max(10, math.floor(vim.o.lines * 0.25)),
      }
    end,
  },
  hide_cursor = true,
}

-- lir .: list files/directories for current buffer's location
vim.api.nvim_set_keymap(
  'n',
  '<leader>lc',
  [[<cmd>lua require'lir.float'.toggle()<cr>]],
  { noremap = true, silent = true }
)
-- lir files: list files/directories for current project root
vim.api.nvim_set_keymap(
  'n',
  '<leader>lf',
  [[<cmd>lua require'lir.float'.toggle(vim.fn.getcwd())<cr>]],
  { noremap = true, silent = true }
)
