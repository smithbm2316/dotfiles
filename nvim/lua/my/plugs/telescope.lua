-- Aliases for Lua API functions
local map = vim.api.nvim_set_keymap
-- Telescope stuff I need to import for configuration
local actions = require('telescope.actions')
-- My module to export functions from
local ts = {}

-- get the module you need and reload it
function RELOADER(module)
  if not module then
    local buf_path = vim.api.nvim_buf_get_name(2)
    local start = buf_path:find('/lua')
    local module_name = buf_path:sub(start + 5, -5)
    module = module_name:gsub('/', '.')
  end
  package.loaded[module] = nil
  return require(module)
end

-- TELESCOPE CONFIG
require('telescope').setup({
  defaults = {
    mappings = {
      n = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-q>'] = actions.send_to_qflist,
        ['<c-c>'] = actions.close,
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
    layout_strategy = 'bottom_pane',
    file_ignore_patterns = { 'node_modules/.*', '.git/.*', '_site/.*' },
    layout_defaults = {
      horizontal = {
        mirror = true,
      },
      vertical = {
        mirror = true,
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})
-- require gh cli telescope integration
require('telescope').load_extension('gh')
-- require fzf extension for fzf sorting algorithm
require('telescope').load_extension('fzf')

-- global table to contain all of my opts for the different pickers
TelescopeMapArgs = TelescopeMapArgs or {}

-- function for mapping keys to any of my pickers, including custom opts and some good defaults included
local map_picker = function(keymap, picker, opts, module, mode)
  local map_key = vim.api.nvim_replace_termcodes(keymap .. picker, true, true, true)
  local global_opts = {
    hidden = true,
    layout_config = {
      height = 16,
      mirror = true,
    },
  }
  module = module or 'telescope.builtin'
  mode = mode or 'n'

  TelescopeMapArgs[map_key] = opts and vim.tbl_deep_extend('keep', opts, global_opts) or global_opts

  local rhs = string.format(
    [[<cmd>lua require('%s')['%s'](TelescopeMapArgs['%s'])<cr>]],
    module,
    picker,
    map_key
  )

  map(mode, keymap, rhs, { noremap = true, silent = true })
end

-- telescope builtins mappings
-- TODO: move some of my lspconfig mappings to use telescope's lsp pickers instead
-- i.e. references and definition
map_picker('<leader>wd', 'file_browser', {
  prompt_title = 'working directory',
  selection_strategy = 'row',
})
map_picker('<leader>of', 'oldfiles')
map_picker('<leader>fc', 'grep_string', {
  prompt_title = 'word under cursor',
})
map_picker('<leader>fj', 'find_files')
map_picker('<leader>lg', 'live_grep')
map_picker('<leader>fib', 'current_buffer_fuzzy_find')
map_picker('<leader>gl', 'git_commits', {
  selection_strategy = 'row',
  prompt_title = 'git log',
})
map_picker('gh', 'help_tags')
map_picker('<leader>gm', 'man_pages')
map_picker('<leader>lb', 'buffers')
map_picker('<leader>ts', 'builtin')
map_picker('<leader>rp', 'reloader')

-- find files in dotfiles
map_picker('<leader>fd', 'find_files', {
  cwd = '~/dotfiles',
  prompt_title = '.. dotfiles ..',
})

-- neovim config
map_picker('<leader>fn', 'find_files', {
  cwd = '~/dotfiles/nvim',
  prompt_title = 'files in nvim config',
})

-- search for word in neovim config
map_picker('<leader>fin', 'live_grep', {
  cwd = '~/.config/nvim',
  prompt_title = 'grep nvim config',
})

-- git_branches with checkout branch
map_picker('<leader>gb', 'git_branches', {
  attach_mappings = function(_, local_map)
    local_map('i', '<c-o>', actions.git_checkout)
    local_map('n', '<c-o>', actions.git_checkout)
    return true
  end,
  selection_strategy = 'row',
})

-- vim-grepper-like picker with grep_string
ts.ripgrepper = function(opts)
  local ripgrepper_opts = {
    prompt_title = 'ripgrepper',
    search = vim.fn.input('ripgrepper > '),
    search_dirs = { '%' },
    use_regex = true,
  }
  opts = opts and vim.tbl_deep_extend('force', opts, ripgrepper_opts) or ripgrepper_opts
  require('telescope.builtin').grep_string(opts)
end
map_picker('<leader>rg', 'ripgrepper', nil, 'my.plugs.telescope')

ts.buffer_directory = function(opts)
  local bd_opts = {
    cwd = vim.fn.expand('%:p:h'),
    prompt_title = "buffer's directory",
    selection_strategy = 'row',
  }
  opts = opts and vim.tbl_deep_extend('force', opts, bd_opts) or bd_opts
  require('telescope.builtin').file_browser(opts)
end
map_picker('<leader>bd', 'buffer_directory', nil, 'my.plugs.telescope')

return ts
