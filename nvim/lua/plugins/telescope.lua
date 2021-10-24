-- TODO: write a wrapper for custom functions
-- TODO: why isn't telescope finding neuron or web-devicons files??
-- My module to export functions from
local ts = {}
-- Telescope stuff I need to import for configuration
local actions = require'telescope.actions'
local action_state = require'telescope.actions.state'
local previewers = require'telescope.previewers'
local pickers = require'telescope.pickers'
local sorters = require'telescope.sorters'
local finders = require'telescope.finders'
local themes = require'telescope.themes'
local conf = require'telescope.config'.values

-- files to ignore with `file_ignore_patterns`
local ignore_these = {
  'node_modules/.*',
  '.git/.*',
  '.yarn/.*',
  '.neuron/*',
  'fonts/*',
  'icons/*',
  'images/*',
  'dist/*',
  'build/*',
  'yarn.lock',
  'package%-lock.json',
}

local default_picker_opts = {
  file_browser = {
    prompt_title = 'working directory',
    selection_strategy = 'row',
  },
  grep_string = {
    prompt_title = 'word under cursor',
  },
  live_grep = {
    file_ignore_patterns = ignore_these,
  },
  git_commits = {
    selection_strategy = 'row',
    prompt_title = 'git log',
  },
  buffers = {
    show_all_buffers = true,
    attach_mappings = function(_, local_map)
      local_map('n', 'd', actions.delete_buffer)
      local_map('i', '<c-x>', actions.delete_buffer)
      return true
    end,
  },
  git_branches = {
    attach_mappings = function(_, local_map)
      local_map('i', '<c-o>', actions.git_checkout)
      local_map('n', '<c-o>', actions.git_checkout)
      return true
    end,
    selection_strategy = 'row',
  },
  find_files = {
    find_command = { 'rg', '--files', '-L' },
    follow = true,
    hidden = false,
    no_ignore = true,
  },
}

  -- TELESCOPE CONFIG
  require'telescope'.setup {
    pickers = default_picker_opts,
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
      mappings = {
        n = {
          ['<c-x>'] = false,
          ['<c-s>'] = actions.select_horizontal,
          ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<c-c>'] = actions.close,
        },
        i = {
          ['<c-x>'] = false,
          ['<c-s>'] = actions.select_horizontal,
          ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<c-c>'] = actions.close,
          ['<c-k>'] = actions.delete_buffer,
        },
      },
      color_devicons = true,
      prompt_prefix = '🔍 ',
      scroll_strategy = 'cycle',
      sorting_strategy = 'ascending',
      layout_strategy = 'flex',
      file_ignore_patterns = ignore_these,
      layout_config = {
        prompt_position = 'top',
        horizontal = {
          mirror = true,
          preview_cutoff = 100,
          preview_width = 0.5,
        },
        vertical = {
          mirror = true,
          preview_cutoff = 0.4,
        },
        flex = {
          flip_columns = 110,
        },
        height = 0.94,
        width = 0.86,
      },
    },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}
-- require fzf extension for fzf sorting algorithm
require'telescope'.load_extension('fzf')
-- require zk extension for zk-cli
require'telescope'.load_extension('zk')
-- require neoclip extension
-- require'telescope'.load_extension('neoclip')

-- function for generating keymap for each picker
local builtin = function(mapping, picker, is_custom)
  local module = is_custom and 'plugins.telescope' or 'telescope.builtin'
  local rhs = string.format(
    [[<cmd>lua require'%s'.%s()<cr>]],
    module,
    picker
  )
  nnoremap(mapping, rhs)
end

local custom = function(mapping, picker_name, builtin_name, opts)
  opts = opts or {}
  ts[picker_name] = function()
    require'telescope.builtin'[builtin_name](opts)
  end
  local rhs = string.format(
    [[<cmd>lua require'plugins.telescope'.%s()<cr>]],
    picker_name
  )
  nnoremap(mapping, rhs)
end

-- my telescope builtins mappings
-- TODO: move some of my lspconfig mappings to use telescope's lsp pickers instead
-- i.e. references and definition
builtin('<leader>fb', 'file_browser')
builtin('<leader>of', 'oldfiles')
builtin('<leader>fw', 'grep_string')
builtin('<leader>fj', 'find_files')
builtin('<leader>gw', 'live_grep') -- grep word
builtin('<leader>gib', 'current_buffer_fuzzy_find') -- grep in buffer
builtin('<leader>gl', 'git_commits') -- git log
builtin('<leader>gb', 'git_branches')
builtin('<leader>gh', 'help_tags')
builtin('<leader>gm', 'man_pages')
builtin('<leader>bl', 'buffers')
builtin('<leader>ts', 'builtin')
builtin('<leader>rp', 'reloader')
builtin('<leader>tp', 'resume') -- telescope previous
builtin('<leader>ps', 'lsp_dynamic_workspace_symbols') -- project symbols
builtin('<leader>ca', 'lsp_code_actions')

-- find_files, but don't use ignored patterns
custom('<leader>fa', 'find_files_all', 'find_files', {
  no_ignore = true,
  hidden = true,
})

-- find in dotfiles
custom('<leader>fd', 'find_dotfiles', 'find_files', {
  cwd = '~/dotfiles',
  prompt_title = 'files in dotfiles',
})

-- find in neovim config
custom('<leader>fn', 'find_neovim', 'find_files', {
  cwd = '~/dotfiles/nvim',
  prompt_title = 'files in neovim config',
})

-- grep inside of dotfiles
custom('<leader>gid', 'grep_in_dotfiles', 'live_grep', {
  cwd = '~/dotfiles',
  prompt_title = 'grep in dotfiles',
})

-- grep inside of neovim config
custom('<leader>gin', 'grep_in_neovim', 'live_grep', {
  cwd = '~/.config/nvim',
  prompt_title = 'grep in neovim config',
})

-- pickers for zk extension
ts.zk_notes = function()
  require'telescope'.extensions.zk.zk_notes()
end
builtin('<leader>nf', 'zk_notes', true)
ts.zk_grep = function()
  require'telescope'.extensions.zk.zk_grep()
end
builtin('<leader>ng', 'zk_grep', true)

-- vim-grepper-like picker with grep_string
ts.ripgrepper = function()
  require'telescope.builtin'.grep_string {
    prompt_title = 'ripgrepper',
    search = vim.fn.input('ripgrepper > '),
    search_dirs = { '$PWD' },
    use_regex = true,
  }
end
builtin('<leader>rg', 'ripgrepper', true)

-- custom telescope picker to execute a packer.nvim command
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#guide-to-your-first-picker
ts.packer_commands = function(opts)
  local packer_commands = {
    'Clean',
    'Compile',
    'Install',
    'Load',
    'Profile',
    'Status',
    'Sync',
    'Update',
  }
  local dropdown = themes.get_dropdown()
  opts = opts and vim.tbl_deep_extend('keep', opts, dropdown) or dropdown

  pickers.new(opts, {
    prompt_title = 'Run a packer.nvim command',
    finder = finders.new_table(packer_commands),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local cmd = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if cmd then
          vim.cmd('Packer' .. cmd[1])
        end
      end)
      return true
    end,
    previewer = nil,
  }):find()
end
nnoremap('<leader>pc', [[<cmd>lua require'plugins.telescope'.packer_commands()<cr>]])

return ts
