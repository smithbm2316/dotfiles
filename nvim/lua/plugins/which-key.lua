vim.o.timeoutlen = 300
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
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
    },
  },
}
