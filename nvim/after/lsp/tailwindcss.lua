return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = vim.tbl_extend('force', css_like_fts, html_like_fts),
  root_dir = function(_, on_dir)
    if
      root_pattern {
        '.tailwind-lsp',
        'tailwind.config.cjs',
        'tailwind.config.mjs',
        'tailwind.config.js',
        'tailwind.config.ts',
      }
    then
      on_dir(vim.fn.getcwd())
    end
  end,
  -- add support for custom languages
  -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/84#issuecomment-1128278248
  init_options = { userLanguages = {} },
  settings = {
    tailwindCSS = {
      -- includeLanguages = {},
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
  single_file_support = false,
}
