require('nvim-treesitter.configs').setup {
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
