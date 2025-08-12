return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = js_ts_fts,
  init_options = { hostInfo = 'neovim' },
  root_dir = root_pattern {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git',
  },
  single_file_support = false,
}
