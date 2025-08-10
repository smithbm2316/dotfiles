return {
  filetypes = { 'json', 'jsonc', 'json5' },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
        {
          fileMatch = { 'tsconfig*.json' },
          url = 'https://json.schemastore.org/tsconfig.json',
        },
        {
          fileMatch = { 'jsconfig.json' },
          url = 'https://json.schemastore.org/jsconfig.json',
        },
        {
          fileMatch = {
            '.prettierrc',
            '.prettierrc.json',
            'prettier.config.json',
          },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        {
          fileMatch = { '.eslintrc', '.eslintrc.json' },
          url = 'https://json.schemastore.org/eslintrc.json',
        },
        {
          fileMatch = { 'deno.json', 'deno.jsonc' },
          url = 'https://deno.land/x/deno/cli/schemas/config-file.v1.json',
        },
        {
          fileMatch = { 'composer.json' },
          url = 'https://getcomposer.org/schema.json',
        },
        {
          fileMatch = { 'sqlc.json' },
          url = 'https://www.schemastore.org/sqlc-2.0.json',
        },
      },
    },
  },
}
