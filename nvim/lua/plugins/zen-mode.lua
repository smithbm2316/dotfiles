require('zen-mode').setup {
  window = {
    width = 90,
    backdrop = 0.95,
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
    if package.loaded.focus then
      vim.cmd 'FocusDisable'
    end
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
    if package.loaded.focus then
      vim.cmd 'FocusEnable'
    end
  end,
}

nnoremap('<leader>tz', '<cmd>ZenMode<cr>')
