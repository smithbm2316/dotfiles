vim.filetype.add {
  extension = {
    webc = 'webc',
  },
}
vim.treesitter.language.add('astro', {
  filetype = 'webc',
})
