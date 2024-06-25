return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  opts = {
    exclude = {
      buftypes = { 'terminal', 'man', 'nofile' },
      filetypes = { 'help', 'man', 'startuptime', 'qf', 'lspinfo' },
    },
    scope = {
      enabled = true,
      show_end = false,
    },
  },
  main = 'ibl',
}
