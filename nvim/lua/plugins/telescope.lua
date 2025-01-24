return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    'nvim-tree/nvim-web-devicons',
    'folke/trouble.nvim',
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

    -- files to ignore with `file_ignore_patterns`
    -- if you want to ignore a file with `live_grep`, it needs to go here
    bs.telescope.always_ignored =
      vim.tbl_deep_extend('force', bs.telescope.always_ignored, {
        '%.avi',
        '%.avif',
        '%.db',
        '%.env%..*',
        '%.env',
        '%.flv',
        '%.generated%.d%.ts',
        '%.git/.*',
        '%.heic',
        '%.ico',
        '%.jpeg',
        '%.jpg',
        '%.mkv',
        '%.mov',
        '%.mp3',
        '%.mp4',
        '%.png',
        '%.svg',
        '%.wav',
        '%.webm$',
        '%.webp',
        '%.zip',
        '.obsidian/.*',
        '__snapshots__/.*', -- thuma ichabod
        'deno%.lock',
        'node_modules/.*',
        'package%-lock%.json',
        'pnpm%-lock%.yaml',
        'yarn%.lock',
      })

    bs.telescope.ignored = vim.tbl_deep_extend('force', bs.telescope.ignored, {
      '%.avi',
      '%.avif',
      '%.db',
      '%.env%..*',
      '%.env',
      '%.eot',
      '%.flv',
      '%.generated%.d%.ts',
      '%.git/.*',
      '%.heic',
      '%.ico',
      '%.jpeg',
      '%.jpg',
      '%.mkv',
      '%.mov',
      '%.mp3',
      '%.mp4',
      '%.otf',
      '%.png',
      '%.svg',
      '%.ttf',
      '%.wav',
      '%.webm$',
      '%.webp',
      '%.woff',
      '%.woff2',
      '%.zip',
      '.gitkeep',
      '.obsidian.vimrc',
      '.obsidian/.*',
      '.yarn/.*',
      '__generated__/.*', -- kcrw project
      '__snapshots__/.*', -- thuma ichabod
      '@types/.*', -- thuma ichabod
      'vendor/.*', -- ignore odin vendor directories
      'deno%.lock',
      'generated%-gql/.*', -- inkd project
      'generated/graphql%.tsx', -- scoutus project
      'go%.sum',
      'graphql%.schema%.json',
      'node_modules/.*',
      'package%-lock%.json',
      'pnpm%-lock%.yaml',
      'schema%.json',
      'yarn%.lock',
      'zsh%-abbr/.*',
      'zsh%-autosuggestions/.*',
      'zsh%-completions/.*',
      'zsh%-syntax%-highlighting/.*',
    })

    -- if we have a `.luarc.json` file, we are probably in a love2D game folder
    -- and should ignore the `types` folder where I store any of my annotations
    -- for lua-language-server for libraries that I'm using
    --
    -- TODO: add a .lazy.lua local file for this configuration in luv/lua
    -- project directories
    --
    -- if _G.exists_in_cwd '.luarc.json' then
    --   table.insert(_G.telescope_ignored, 'types/.*')
    -- end

    local default_picker_opts = {
      grep_string = {
        prompt_title = 'word under cursor',
      },
      live_grep = {
        file_ignore_patterns = bs.telescope.always_ignored,
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

    ---@type function|false
    local open_qflist_with_trouble = false
    local trouble_telescope_ok, trouble_telescope =
      pcall(require, 'trouble.sources.telescope')
    if trouble_telescope_ok then
      open_qflist_with_trouble = trouble_telescope.open
    end

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
            ['<c-t>'] = open_qflist_with_trouble,
            ['<c-c>'] = actions.close,
          },
          i = {
            ['<c-x>'] = false,
            ['<c-s>'] = actions.select_horizontal,
            ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<c-t>'] = open_qflist_with_trouble,
            ['<c-c>'] = actions.close,
            ['<c-k>'] = actions.delete_buffer,
          },
        },
        color_devicons = true,
        prompt_prefix = '🔍 ',
        scroll_strategy = 'cycle',
        sorting_strategy = 'ascending',
        layout_strategy = 'flex',
        -- layout_strategy = 'vertical',
        file_ignore_patterns = bs.telescope.ignored,
        layout_config = {
          prompt_position = 'top',
          horizontal = {
            -- set to `false` if you want the input to be on the left and
            -- preview on the right
            mirror = true,
            preview_cutoff = 100,
            preview_width = 0.5,
          },
          vertical = {
            mirror = true,
            preview_cutoff = 0.4,
          },
          flex = {
            flip_columns = 200,
          },
          height = 0.94,
          width = 0.86,
        },
        -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#ignore-files-bigger-than-a-threshold
        preview = {
          filesize_limit = 1.0, -- MB
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
      '<leader>gf',
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
        file_ignore_patterns = bs.telescope.always_ignored,
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
