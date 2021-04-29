vim.o.timeoutlen = 500
require'which-key'.setup {
  marks = false,
  registers = false,
  presets = {
    operators = false,
    motions = true,
    text_objects = true,
    windows = true,
    nav = true,
    z = true,
    g = true,
  },
}
