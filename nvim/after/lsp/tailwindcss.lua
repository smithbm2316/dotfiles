---@type vim.lsp.Config
return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = vim.list_extend(
    vim.list_slice(_G.css_like_fts),
    _G.html_like_fts
  ),
  root_markers = {
    '.tailwind-lsp',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.js',
    'tailwind.config.ts',
  },
  -- add support for custom languages
  -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/84#issuecomment-1128278248
  init_options = { userLanguages = {} },
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'className', 'class:list', 'classList' },
      classFunctions = { 'tw', 'clsx', 'cva', 'cx', 'cn' },
      codeActions = true,
      colorDecorators = true,
      emmetCompletions = true,
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
  before_init = function(_, config)
    if not config.settings then
      config.settings = {}
    end
    if not config.settings.editor then
      config.settings.editor = {}
    end
    if not config.settings.editor.tabSize then
      config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  workspace_required = true,
}
