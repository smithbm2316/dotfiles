return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    -- Telescope stuff I need to import for configuration
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local themes = require 'telescope.themes'
    -- local action_state = require 'telescope.actions.state'
    -- local previewers = require 'telescope.previewers'
    -- local pickers = require 'telescope.pickers'
    -- local sorters = require 'telescope.sorters'
    -- local finders = require 'telescope.finders'
    -- local conf = require('telescope.config').values

    local use_trouble_source = function()
      local ok, trouble_telescope = pcall(require, 'trouble.sources.telescope')
      if not ok then
        return nil
      end
      return trouble_telescope.open_with_trouble
    end

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
      '%.env',
      '%.env%..*',
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
      '%.env',
      '%.env%..*',
      '%.db',
      '%.zip',
      '.yarn/.*',
      'graphql%.schema%.json',
      'schema%.json',
      'go%.sum',
    }

    -- if we have a `.luarc.json` file, we are probably in a love2D game folder
    -- and should ignore the `types` folder where I store any of my annotations
    -- for lua-language-server for libraries that I'm using
    if _G.exists_in_cwd '.luarc.json' then
      table.insert(ignore_these, 'types/.*')
    end

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
            ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<c-t>'] = use_trouble_source,
            ['<c-c>'] = actions.close,
          },
          i = {
            ['<c-x>'] = false,
            ['<c-s>'] = actions.select_horizontal,
            ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<c-t>'] = use_trouble_source,
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
      },
    }
    -- load fzf native extension
    telescope.load_extension 'fzf'

    vim.keymap.set(
      'n',
      '<leader>fj',
      builtin.find_files,
      { desc = 'Find files' }
    )
    vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'Oldfiles' })
    vim.keymap.set(
      'n',
      '<leader>fw',
      builtin.grep_string,
      { desc = 'Grep string' }
    )
    vim.keymap.set('n', '<leader>gw', builtin.live_grep, { desc = 'Live grep' })
    vim.keymap.set(
      'n',
      '<leader>/',
      builtin.current_buffer_fuzzy_find,
      { desc = 'Fuzzy find in buffer' }
    )
    vim.keymap.set(
      'n',
      '<leader>gl',
      builtin.git_commits,
      { desc = 'Git commits' }
    ) -- git log
    vim.keymap.set(
      'n',
      '<leader>gb',
      builtin.git_branches,
      { desc = 'Git branches' }
    )
    vim.keymap.set('n', '<leader>gh', builtin.help_tags, { desc = 'Help tags' })
    vim.keymap.set('n', '<leader>gm', builtin.man_pages, { desc = 'Man pages' })
    vim.keymap.set(
      'n',
      '<leader>bl',
      builtin.buffers,
      { desc = 'List buffers' }
    )
    vim.keymap.set(
      'n',
      '<leader>ts',
      builtin.builtin,
      { desc = 'Telescope pickers' }
    )
    vim.keymap.set(
      'n',
      '<leader>rm',
      builtin.reloader,
      { desc = 'Reload module' }
    )
    vim.keymap.set(
      'n',
      '<leader>tp',
      builtin.resume,
      { desc = 'Previous telescope picker' }
    )

    -- find_files, but don't use ignored patterns
    vim.keymap.set('n', '<leader>fa', function()
      builtin.find_files {
        file_ignore_patterns = always_ignore_these,
        no_ignore = true,
        hidden = true,
      }
    end, { desc = 'Find files all' })

    -- find in dotfiles
    vim.keymap.set('n', '<leader>fd', function()
      builtin.find_files {
        cwd = '~/dotfiles',
        prompt_title = 'files in dotfiles',
      }
    end, { desc = 'Find in dotfiles' })

    -- find in neovim config
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files {
        cwd = '~/dotfiles/nvim',
        prompt_title = 'files in neovim config',
      }
    end, { desc = 'Find neovim files' })

    -- grep inside of dotfiles
    vim.keymap.set('n', '<leader>gid', function()
      builtin.live_grep {
        cwd = '~/dotfiles',
        prompt_title = 'grep in dotfiles',
      }
    end, { desc = 'Grep in dotfiles' })

    -- use live_grep with case sensitive enabled
    vim.keymap.set('n', '<leader>gW', function()
      builtin.live_grep {
        prompt_title = 'live_grep case sensitive',
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
      }
    end, { desc = 'Live grep case sensitive' })

    -- grep inside of neovim config
    vim.keymap.set('n', '<leader>gin', function()
      builtin.live_grep {
        cwd = '~/.config/nvim',
        prompt_title = 'grep in neovim config',
      }
    end, { desc = 'Grep in neovim files' })

    -- grep inside of vim help docs
    vim.keymap.set('n', '<leader>vh', function()
      builtin.live_grep {
        cwd = os.getenv 'VIMRUNTIME' .. '/doc',
        prompt_title = 'Grep in vim help docs',
      }
    end, { desc = 'Grep in vim help' })

    -- jump to a buffer
    vim.keymap.set('n', '<leader>jb', function()
      builtin.buffers(vim.tbl_deep_extend('force', themes.get_dropdown(), {
        preview = false,
        prompt_title = 'Jump to buffer',
      }))
    end, { desc = 'Jump to buffer' })

    -- vim-grepper-like picker with grep_string
    vim.keymap.set('n', '<leader>rg', function()
      builtin.grep_string {
        prompt_title = 'ripgrepper',
        search = vim.fn.input 'ripgrepper > ',
        search_dirs = { '$PWD' },
        use_regex = true,
      }
    end, { desc = 'Ripgrepper' })
  end,
}
