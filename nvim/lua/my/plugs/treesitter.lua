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
    'comment',
  },
}