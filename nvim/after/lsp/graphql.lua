return {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' },
  root_dir = root_pattern {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git',
  },
}
