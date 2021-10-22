vim.o.timeoutlen = 300
require('which-key').setup {
  plugins = {
    marks = false,
    registers = false,
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  triggers_blacklist = {
    n = { 'y', 'd' },
    -- override for mvllow/modes.nvim, i don't need to remember
    -- the surround.vim mappings for ys(text-object)/ds(char)
  },
}
