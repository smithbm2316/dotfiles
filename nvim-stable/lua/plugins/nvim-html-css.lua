return {
  'Jezda1337/nvim-html-css',
  enabled = false,
  dependencies = { 'saghen/blink.cmp', 'nvim-treesitter/nvim-treesitter' },
  opts = {
    enable_on = _G.html_like_fts_no_jsx,
    handlers = {
      definition = {
        bind = 'gd',
      },
      hover = {
        bind = 'gh',
        wrap = true,
        border = 'none',
        position = 'cursor',
      },
    },
    documentation = {
      auto_show = true,
    },
    style_sheets = {},
    --[[style_sheets = {
      'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css',
      './index.css', -- `./` refers to the current working directory.
    },--]]
  },
}
