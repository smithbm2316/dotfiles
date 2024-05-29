local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  vim.notify("You need to install Telescope you dummy, it's your lifeblood", vim.log.levels.ERROR)
  return
end

-- i want the `root_pattern` func required
local ok, lspconfig_util = pcall(require, 'lspconfig.util')
if not ok then
  return
end

-- Telescope stuff I need to import for configuration
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local previewers = require 'telescope.previewers'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'
local themes = require 'telescope.themes'
local conf = require('telescope.config').values

-- files to ignore with `file_ignore_patterns`
local always_ignore_these = {
  'yarn%.lock',
  'package%-lock%.json',
  'pnpm%-lock%.yaml',
  'node_modules/.*',
  '.obsidian/.*',
  'deno%.lock',
  '%.git/.*',
  '%.svg',
  '%.png',
  '%.jpeg',
  '%.jpg',
  '%.ico',
  '%.webp',
  '%.avif',
  '%.heic',
  '%.mp3',
  '%.mp4',
  '%.mkv',
  '%.mov',
  '%.wav',
  '%.flv',
  '%.avi',
  '%.webm',
  '%.env.*',
  '%.db',
  '%.zip',
}

local ignore_these = {
  'yarn%.lock',
  'package%-lock%.json',
  'pnpm%-lock%.yaml',
  'node_modules/.*',
  'generated/graphql%.tsx', -- scoutus project
  'generated%-gql/.*', -- inkd project
  '__generated__/.*', -- kcrw project
  'zsh%-abbr/.*',
  'zsh%-autosuggestions/.*',
  'zsh%-completions/.*',
  'zsh%-syntax%-highlighting/.*',
  '.gitkeep',
  '.obsidian/.*',
  '.obsidian.vimrc',
  'deno%.lock',
  '%.git/.*',
  '%.svg',
  '%.png',
  '%.jpeg',
  '%.jpg',
  '%.ico',
  '%.webp',
  '%.avif',
  '%.heic',
  '%.mp3',
  '%.mp4',
  '%.mkv',
  '%.mov',
  '%.wav',
  '%.flv',
  '%.avi',
  '%.webm',
  '%.ttf',
  '%.otf',
  '%.woff',
  '%.woff2',
  '%.eot',
  '%.env.*',
  '%.db',
  '%.zip',
  '.yarn/.*',
  'graphql%.schema%.json',
  'schema%.json',
  'go%.sum',
}

-- if we have a `.luarc.json` file, we are probably in a love2D game folder and should ignore the `types` folder where I store any of my annotations for lua-language-server for libraries that I'm using
local check_for_luarc_json = lspconfig_util.root_pattern '.luarc.json'
local result = check_for_luarc_json(vim.fn.expand '%:p:h')
if result ~= nil then
  ignore_these = vim.tbl_extend('force', ignore_these, { 'types/.*' })
end

local webdev_dash_keywords = {
  'css',
  'cssmedia',
  'html',
  'htmle',
  'htmlhead',
  'httpheaders',
  'httpstatus',
  'js',
  'nextjs',
  'nodejs',
  'react',
  'scss',
  'ts',
}

local default_picker_opts = {
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
    find_command = { 'fd', '--hidden', '--type', 'f' },
    follow = true,
    hidden = true,
    no_ignore = false,
  },
  lsp_code_actions = themes.get_dropdown(),
  lsp_range_code_actions = themes.get_dropdown(),
}

-- TELESCOPE CONFIG
telescope.setup {
  pickers = default_picker_opts,
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    mappings = {
      n = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-t>'] = actions.send_to_qflist + actions.open_qflist,
        ['<c-q>'] = require('trouble.providers.telescope').open_with_trouble,
        ['<c-c>'] = actions.close,
      },
      i = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-t>'] = actions.send_to_qflist + actions.open_qflist,
        ['<c-q>'] = require('trouble.providers.telescope').open_with_trouble,
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
        flip_columns = 128,
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
    file_browser = {
      -- theme = 'ivy',
      -- disables netrw and use telescope-file-browser in its place
      theme = nil,
      hijack_netrw = false,
      -- mappings = {},
    },
  },
}

require('telescope').load_extension 'fzf'
require('telescope').load_extension 'file_browser'
nnoremap('<leader>fb', function()
  require('telescope').extensions.file_browser.file_browser {
    preview = true,
  }
end, 'Telescope file browser')

-- function for generating keymap for each picker
local builtin = function(lhs, picker, label)
  nnoremap(lhs, function()
    require('telescope.builtin')[picker]()
  end, label)
end

local custom = function(lhs, picker, label, opts)
  opts = opts or {}
  nnoremap(lhs, function()
    require('telescope.builtin')[picker](opts)
  end, label)
end

-- my telescope builtins mappings
-- TODO: move some of my lspconfig mappings to use telescope's lsp pickers instead
-- i.e. references and definition
builtin('<leader>of', 'oldfiles', 'Oldfiles')
builtin('<leader>fw', 'grep_string', 'Grep string')
builtin('<leader>gw', 'live_grep', 'Live grep')
builtin('<leader>/', 'current_buffer_fuzzy_find', 'Fuzzy find in buffer')
builtin('<leader>gl', 'git_commits', 'Git commits') -- git log
builtin('<leader>gb', 'git_branches', 'Git branches')
builtin('<leader>gh', 'help_tags', 'Help tags')
builtin('<leader>gm', 'man_pages', 'Man pages')
builtin('<leader>bl', 'buffers', 'List buffers')
builtin('<leader>ts', 'builtin', 'Telescope pickers')
builtin('<leader>rm', 'reloader', 'Reload module')
builtin('<leader>tp', 'resume', 'Previous telescope picker')
builtin('<leader>ps', 'lsp_dynamic_workspace_symbols', 'Project symbols')
builtin('<leader>ca', 'lsp_code_actions', 'Code actions')

-- find_files, but don't use ignored patterns
custom('<leader>fa', 'find_files', 'Find files all', {
  file_ignore_patterns = always_ignore_these,
  no_ignore = true,
  hidden = true,
})

-- find in dotfiles
custom('<leader>fd', 'find_files', 'Find in dotfiles', {
  cwd = '~/dotfiles',
  prompt_title = 'files in dotfiles',
})

-- find in neovim config
custom('<leader>fn', 'find_files', 'Find neovim files', {
  cwd = '~/dotfiles/nvim',
  prompt_title = 'files in neovim config',
})

-- grep inside of dotfiles
custom('<leader>gid', 'live_grep', 'Grep in dotfiles', {
  cwd = '~/dotfiles',
  prompt_title = 'grep in dotfiles',
})

-- use live_grep with case sensitive enabled
custom('<leader>gW', 'live_grep', 'Live grep case sensitive', {
  prompt_title = 'live_grep case sensitive',
  vimgrep_arguments = {
    'rg',
    '--color=never',
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
  },
})

-- grep inside of neovim config
custom('<leader>gin', 'live_grep', 'Grep in neovim files', {
  cwd = '~/.config/nvim',
  prompt_title = 'grep in neovim config',
})

-- grep inside of vim help docs
custom('<leader>vh', 'live_grep', 'Grep in vim help', {
  cwd = os.getenv 'VIMRUNTIME' .. '/doc',
  prompt_title = 'Grep in vim help docs',
})

-- jump to a buffer
custom(
  '<leader>jb',
  'buffers',
  'Jump to buffer',
  vim.tbl_deep_extend('force', themes.get_dropdown(), {
    preview = false,
    prompt_title = 'Jump to buffer',
  })
)

-- vim-grepper-like picker with grep_string
nnoremap('<leader>rg', function()
  require('telescope.builtin').grep_string {
    prompt_title = 'ripgrepper',
    search = vim.fn.input 'ripgrepper > ',
    search_dirs = { '$PWD' },
    use_regex = true,
  }
end, 'Ripgrepper')

-- custom telescope picker to execute a packer.nvim command
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#guide-to-your-first-picker
nnoremap('<leader>pc', function()
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

  pickers
    .new(dropdown, {
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
    })
    :find()
end, 'Packer command picker')

-- wrapper for find_files/fd, so that when in my wiki directory,
-- we hook into zk-cli to search notes by title, not the name of the file
nnoremap('<leader>fj', function()
  require('telescope.builtin').find_files()
  --[[ if vim.loop.cwd() == (os.getenv 'HOME' .. '/wiki') then
    local ok, zk_commands = pcall(require, 'zk.commands')
    if ok then
      zk_commands.get 'ZkNotes'()
    else
      vim.notify 'Zk plugin not found'
    end
  else
    require('telescope.builtin').find_files()
  end ]]
end, 'Find files')

-- jump to next diangostic suggestion and open the code actions menu
nnoremap('<leader>df', function()
  vim.diagnostic.goto_next()
  require('telescope.builtin').lsp_code_actions()
end, 'Diagnostics fix')
