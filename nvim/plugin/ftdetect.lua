vim.filetype.add {
  extension = {
    tmpl = 'gotmpl',
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
