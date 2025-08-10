-- color converter for hex to rgb, etc
return {
  'amadeus/vim-convert-color-to',
  cmd = 'ConvertColorTo',
  keys = {
    {
      '<leader>cc',
      function()
        vim.cmd(string.format('ConvertColorTo %s', vim.fn.input 'Convert to: '))
      end,
      desc = 'Convert color',
    },
  },
}
