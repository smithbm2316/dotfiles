vim.filetype.add {
  extension = {
    tmpl = 'html',
    -- tmpl = 'gohtml',
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
