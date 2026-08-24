---@type vim.lsp.Config
return {
  cmd = { 'vtsls', '--stdio' },
  init_options = {
    hostInfo = 'neovim',
  },
  filetypes = _G.js_ts_fts,
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package-lock.json',
    'yarn.lock',
    'pnpm-lock.yaml',
  },
}
