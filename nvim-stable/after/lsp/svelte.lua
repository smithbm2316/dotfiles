local lsp_functions = require 'plugins.lsp.config'

return {
  capabilities = lsp_functions.capabilities,
  filetypes = { 'svelte' },
  on_attach = lsp_functions.on_attach,
}
