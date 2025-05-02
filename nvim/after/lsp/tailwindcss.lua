local root_markers = {
  '.tailwind-lsp',
  'nuxt.config.ts',
  'svelte.config.js',
  'svelte.config.ts',
  'tailwind.config.cjs',
  'tailwind.config.js',
  'tailwind.config.ts',
}

return {
  filetypes = vim.tbl_extend('force', _G.css_like_fts, _G.html_like_fts),
  root_markers = root_markers,
  root_dir = function(_, on_dir)
    local cwd = vim.fn.getcwd()
    local found_root = require('lspconfig.util').root_pattern(root_markers)(cwd)

    if found_root ~= nil then
      on_dir(cwd)
    end
  end,
  -- add support for custom languages
  -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/84#issuecomment-1128278248
  init_options = {
    userLanguages = {
      edge = 'html',
      etlua = 'html',
      templ = 'html',
      webc = 'html',
    },
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        edge = 'html',
        etlua = 'html',
        templ = 'html',
        webc = 'html',
      },
      classAttributes = { 'class', 'className', 'class:list', 'classList' },
      codeActions = true,
      colorDecorators = true,
      emmetCompletions = false,
      hovers = true,
      rootFontSize = 16,
      showPixelEquivalents = true,
      suggestions = true,
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      experimental = {
        classRegex = {
          { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
          { 'cx\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
}
