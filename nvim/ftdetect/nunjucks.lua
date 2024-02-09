vim.filetype.add {
  extension = {
    njk = 'nunjucks',
  },
}
vim.treesitter.language.add('twig', {
  filetype = 'nunjucks',
})
