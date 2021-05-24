-- TODO: set up parameter textobjects, so I can swap elements in a lua table back and forth cc TJ's recent stream
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ['<leader>nf'] = '@function.outer',
      },
      goto_previous_start = {
        ['<leader>pf'] = '@function.outer',
      },
    },
  },
  playground = {
    enable = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {'BufWrite', 'CursorHold'},
  },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    'css',
    'html',
    'javascript',
    'typescript',
    'tsx',
    'bash',
    'go',
    'c',
    'cpp',
    'lua',
    'python',
    'json',
    'yaml',
    'toml',
    'regex',
    'latex',
    -- 'comment',
    'vue',
    'query',
    'fish',
  },
}
vim.cmd'au! BufRead,BufNewFile *.fish set filetype=fish'
vim.cmd'au! BufEnter *.fish set commentstring=#%s'
