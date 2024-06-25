return {
  'windwp/nvim-ts-autotag',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = _G.html_like_fts,
  event = 'VeryLazy',
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    filetypes = _G.html_like_fts,
    aliases = {
      blade = 'html',
      edge = 'html',
      templ = 'html',
    },
    skip_tags = {
      'area',
      'base',
      'br',
      'col',
      'command',
      'embed',
      'hr',
      'img',
      'slot',
      'input',
      'keygen',
      'link',
      'meta',
      'menuitem',
      'param',
      'source',
      'track',
      'wbr',
    },
  },
}
