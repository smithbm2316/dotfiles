return {
  'nvim-focus/focus.nvim',
  event = 'VeryLazy',
  config = function()
    local golden_ratio = 1.5
    local maxwidth = vim.o.columns
    local width = maxwidth > 160 and math.floor(maxwidth / golden_ratio) or 120

    require('focus').setup {
      excluded_filetypes = {
        'TelescopePrompt',
        'help',
        'harpoon',
        'DiffviewFiles',
      },
      excluded_buftypes = { 'nofile' },
      ui = {
        signcolumn = false,
      },
      width = width,
    }

    vim.keymap.set('n', '<leader>fi', function()
      require('focus').focus_toggle()
    end, { desc = 'Toggle focus.nvim' })
  end,
}
