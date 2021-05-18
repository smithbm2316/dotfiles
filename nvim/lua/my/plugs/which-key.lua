vim.o.timeoutlen = 750
require('which-key').setup {
  marks = false,
  registers = false,
  presets = {
    operators = false,
    motions = false,
    text_objects = false,
    windows = false,
    nav = false,
    z = true,
    g = true,
  },
}
