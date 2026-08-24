local function set_theme()
  if vim.o.background == 'dark' then
    vim.cmd.colorscheme 'habamax'
    -- make markdown headers stand out
    vim.cmd [[hi @markup.heading guifg=#819b69 guibg=#212220]]
  else
    vim.cmd.colorscheme 'seoulbones'
    -- make markdown headers stand out
    vim.cmd [[hi @markup.heading guifg=#0084a3 guibg=#c2dbe8]]
  end
end

set_theme()

vim.keymap.set('n', '<leader>tt', function()
  vim.opt.background = vim.opt.background:get() == 'dark' and 'light' or 'dark'
end, { desc = 'Toggle color mode' })

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = { 'background' },
  callback = set_theme,
})
