---@type vim.lsp.Config
return {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql' },
  root_dir = root_pattern {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git',
  },
}
