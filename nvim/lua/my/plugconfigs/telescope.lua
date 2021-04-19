-- Aliases for Lua API functions
local map = vim.api.nvim_set_keymap
-- Use the no recursive remapping for all remaps
opts = { noremap = true, silent = true }
-- Telescope stuff I need to import for configuration
local actions = require('telescope.actions')
-- My module to export functions from
local ts = {}

-- TELESCOPE CONFIG
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-q>'] = actions.send_to_qflist,
      },
      i = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-q>'] = actions.send_to_qflist,
      },
    },
    color_devicons = true,
    prompt_position = 'bottom',
    prompt_prefix = '🔍 ',
    sorting_strategy = 'ascending',
    layout_strategy = 'flex',
    file_ignore_patterns = { 'node_modules/.*', '.git/.*', '_site/.*' },
    layout_defaults = {
      horizontal = {
        mirror = true,
      },
      vertical = {
        mirror = true,
      }
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
}
-- require gh cli telescope integration
require('telescope').load_extension('gh')
-- require fzf extension for fzf sorting algorithm
require('telescope').load_extension('fzf')

-- stolen from Thorsten Ball's neovim config: https://github.com/mrnugget/vimconfig
-- used to map a keybinding to a telescope builtin
local map_tsbuiltin = function(keymap, picker, config)
  config = config or {} -- set default options to be a table if the user gives none
  config_string = ''
  for k,v in pairs(config) do config_string = config_string .. string.format('%s = %q, ', k, v) end
  local right_hand_side = string.format(":lua require('telescope.builtin').%s{%s}<cr>", picker, config_string)
  vim.api.nvim_set_keymap('n', keymap, right_hand_side, opts)
end
-- used to map a keybinding to a custom telescope function I write
local map_tscustom = function(keymap, picker)
  local right_hand_side = string.format(":lua require('my.plugconfigs.telescope').%s()<cr>", picker)
  vim.api.nvim_set_keymap('n', keymap, right_hand_side, opts)
end

-- find files in dotfiles
ts.dotfiles = function()
  require('telescope.builtin').find_files{ cwd = '~/dotfiles', prompt_title = '... dotfiles ...', hidden = true }
end
map_tscustom('<leader>fd', 'dotfiles')

-- neovim config
ts.neovim_config = function()
  require('telescope.builtin').find_files{ cwd = '~/.config/nvim', prompt_title = 'neovim config', hidden = true }
end
map_tscustom('<leader>fn', 'neovim_config')

-- search for word in neovim config
ts.find_in_neovim_config = function()
  require('telescope.builtin').live_grep{ cwd = '~/.config/nvim', prompt_title = 'find in neovim config' }
end
map_tscustom('<leader>fin', 'find_in_neovim_config')

-- self-explanatory
ts.find_files_in_directory_of_buffer = function()
  require('telescope.builtin').find_files({ cwd = vim.fn.expand("%:p:h"), prompt_title = 'find files in buf\'s dir', hidden = true })
end
map_tscustom('<leader>fib', 'find_files_in_directory_of_buffer')

-- git_branches with checkout branch
ts.git_branches_custom = function()
  require('telescope.builtin').git_branches({ attach_mappings = function(_, map)
    map('i', '<c-o>', actions.git_checkout)
    map('n', '<c-o>', actions.git_checkout)
    return true
  end, selection_strategy = 'row' })
end
map_tscustom('<leader>gb', 'git_branches_custom')

-- telescope builtins mappings
local rowselect_opts = { selection_strategy = 'row', hidden = true }
map_tsbuiltin('<leader>ld', "file_browser", rowselect_opts )
map_tsbuiltin('<leader>of', "oldfiles")
map_tsbuiltin('<leader>fc', "grep_string")
map_tsbuiltin('<leader>fj', "find_files", { hidden = true })
map_tsbuiltin('<leader>fw', "live_grep")
map_tsbuiltin('<leader>gc', "git_commits", rowselect_opts)
map_tsbuiltin('<leader>gh', "help_tags")
map_tsbuiltin('<leader>gm', "man_pages")
map_tsbuiltin('<leader>gs', "git_status", rowselect_opts)
map_tsbuiltin('<leader>la', "lsp_code_actions")
map_tsbuiltin('<leader>lb', "buffers")
map_tsbuiltin('<leader>lk', "keymaps")
map_tsbuiltin('<leader>lm', "marks")
map_tsbuiltin('<leader>lq', "quickfix")
map_tsbuiltin('<leader>lr', "registers")
map_tsbuiltin('<leader>ts', "builtin")
map_tsbuiltin('<leader>va', "autocommands")
map_tsbuiltin('<leader>vc', "commands")
map_tsbuiltin('<leader>vo', "vim_options")

return ts
