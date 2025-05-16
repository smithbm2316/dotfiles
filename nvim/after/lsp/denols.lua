local lsp_functions = require 'plugins.lsp.config'
local root_markers = { 'deno.json', 'deno.jsonc' }

return {
  capabilities = lsp_functions.capabilities,
  filetypes = _G.js_ts_fts,
  root_markers = root_markers,
  root_dir = function(_, on_dir)
    if root_pattern(root_markers) then
      on_dir(vim.fn.getcwd())
    end
  end,
  on_attach = lsp_functions.on_attach,
  single_file_support = false,
}
