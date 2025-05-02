return {
  root_markers = { 'package.json' },
  root_dir = function(_, on_dir)
    local cwd = vim.fn.getcwd()
    local found_deno = require('lspconfig.util').root_pattern {
      'deno.json',
      'deno.jsonc',
    }(cwd)

    if found_deno == nil then
      on_dir(cwd)
    end
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'svelte',
    'vue',
  },
  -- init_options = {
  --   plugins = {
  --     {
  --       name = '@vue/typescript-plugin',
  --       location = '/Users/smithbm/.config/nvm/versions/node/v23.4.0/lib/node_modules/@vue/language-server',
  --       languages = { 'vue' },
  --     },
  --   },
  -- },
  single_file_support = false,
}
