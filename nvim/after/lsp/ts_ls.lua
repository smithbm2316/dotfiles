--- error codes from `ts_ls` that i never want to see
local error_codes_to_hide = {
  -- ignore "file may be converted to from a commonjs module to an es module" error
  -- https://stackoverflow.com/a/70294761/15089697
  80001,
  -- ignore "Could not find a declaration file for module ..." error
  7016,
}

return {
  root_markers = { 'package.json' },
  root_dir = function(_, on_dir)
    if not _G.root_pattern { 'deno.json', 'deno.jsonc' } then
      on_dir(vim.fn.getcwd())
    end
  end,
  -- filetypes = vim.tbl_extend('force', _G.js_ts_fts, _G.frontend_js_fts),
  filetypes = _G.js_ts_fts,
  --[[handlers = {
    ---@param err lsp.ResponseError
    ---@param result lsp.PublishDiagnosticsParams
    ---@param ctx lsp.HandlerContext
    ['textDocument/publishDiagnostics'] = function(err, result, ctx)
      local filtered = {}
      for _, diag in ipairs(result.diagnostics) do
        if diag.source == 'ts_ls' and error_codes_to_hide[diag.code] == nil then
          table.insert(filtered, diag)
        end
      end

      result.diagnostics = filtered
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
    end,
  },--]]
  --[[init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = '/Users/smithbm/.config/nvm/versions/node/v23.4.0/lib/node_modules/@vue/language-server',
        languages = { 'vue' },
      },
    },
  },--]]
  single_file_support = false,
}
