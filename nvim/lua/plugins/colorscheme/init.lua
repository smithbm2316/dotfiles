local ok, rose_pine = pcall(require, 'rose-pine')
if not ok then
  return
end

vim.opt.background = 'dark'

rose_pine.setup {
  dark_variant = 'moon',
  highlight_groups = {
    IndentBlanklineChar = { fg = 'surface' },
    -- this seems to fix the issue with highlighting TSX/JSX component names in markup
    -- https://github.com/nvim-treesitter/playground/issues/94#issuecomment-1251134196
    ['@constructor'] = { fg = 'foam' },
  },
}
vim.cmd [[colorscheme tokyonight-moon]]
vim.cmd [[colorscheme rose-pine]]
