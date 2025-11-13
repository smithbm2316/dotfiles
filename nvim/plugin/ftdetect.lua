vim.filetype.add {
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
