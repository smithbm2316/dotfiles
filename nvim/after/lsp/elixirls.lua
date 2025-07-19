local lsp_functions = require 'plugins.lsp.config'

return {
  capabilities = lsp_functions.capabilities,
  cmd = { 'elixir-ls' },
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
  on_attach = lsp_functions.on_attach,
  root_markers = { 'mix.exs' },
}
