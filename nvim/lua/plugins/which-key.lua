vim.o.timeoutlen = 300
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 1000,
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
  },
}
