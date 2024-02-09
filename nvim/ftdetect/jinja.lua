vim.filetype.add {
  extension = {
    jinja = 'jinja',
    j2 = 'jinja',
  },
}
vim.treesitter.language.add('twig', {
  filetype = 'nunjucks',
})
