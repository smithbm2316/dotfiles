local root_markers = { 'deno.json', 'deno.jsonc' }

return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = root_markers,
  root_dir = function(_, on_dir)
    local cwd = vim.fn.getcwd()
    local found_root = require('lspconfig.util').root_pattern(root_markers)(cwd)

    if found_root ~= nil then
      on_dir(cwd)
    end
  end,
  single_file_support = false,
}
