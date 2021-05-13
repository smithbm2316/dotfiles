vim.o.timeoutlen = 750
require('which-key').setup {
  marks = false,
  registers = false,
  presets = {
    operators = false,
    motions = false,
    text_objects = true,
    windows = true,
    nav = true,
    z = true,
    g = true,
  },
}
