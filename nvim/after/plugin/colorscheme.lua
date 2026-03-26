local background_to_colorscheme = {
  light = 'seoulbones',
  dark = 'catppuccin-macchiato',
}

vim.cmd(
  'colorscheme '
    .. background_to_colorscheme[vim.opt.background:get() or 'dark']
)

vim.keymap.set('n', '<leader>tt', function()
  local new_bg = vim.opt.background:get() == 'dark' and 'light' or 'dark'
  vim.opt.background = new_bg
  vim.cmd('colorscheme ' .. background_to_colorscheme[new_bg])
end, { desc = 'Toggle color mode' })
