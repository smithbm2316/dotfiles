vim.filetype.add {
  extension = {
    tmpl = 'gohtml',
  },
  filename = {
    ['.env'] = 'sh',
    ['.djlintrc'] = 'json',
    ['.eslintrc'] = 'json',
    ['.htmlhintrc'] = 'json',
    ['.parcelrc'] = 'json',
    ['.prettierrc'] = 'json',
  },
  pattern = {
    ['%.env%..*'] = 'sh',
  },
}
