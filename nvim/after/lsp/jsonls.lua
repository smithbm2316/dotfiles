---@type vim.lsp.Config
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc', 'json5' },
  root_markers = { '.git' },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://www.schemastore.org/package.json',
        },
        {
          fileMatch = { 'tsconfig*.json' },
          url = 'https://www.schemastore.org/tsconfig.json',
        },
        {
          fileMatch = { 'jsconfig.json' },
          url = 'https://www.schemastore.org/jsconfig.json',
        },
        {
          fileMatch = {
            '.prettierrc',
            '.prettierrc.json',
            'prettier.config.json',
          },
          url = 'https://www.schemastore.org/prettierrc.json',
        },
        {
          fileMatch = { '.eslintrc', '.eslintrc.json' },
          url = 'https://www.schemastore.org/eslintrc.json',
        },
        {
          fileMatch = { 'sqlc.json' },
          url = 'https://www.schemastore.org/sqlc-2.0.json',
        },
        {
          fileMatch = { 'deno.json', 'deno.jsonc' },
          url = 'https://raw.githubusercontent.com/denoland/deno/refs/heads/main/cli/schemas/config-file.v1.json',
        },
        {
          fileMatch = { '.htmlhintrc' },
          url = 'https://www.schemastore.org/htmlhint.json',
        },
      },
    },
  },
  init_options = { provideFormatter = false },
  single_file_support = true,
}
