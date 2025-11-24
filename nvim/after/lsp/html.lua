---@type vim.lsp.Config
return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = _G.html_like_fts_no_jsx,
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = false,
  },
  root_markers = { '.git' },
  settings = {
    css = {
      completion = {
        completePropertyWithSemicolon = false,
        triggerPropertyValueCompletion = true,
      },
      format = {
        preserveNewLines = true,
        spaceAroundSelectorSeparator = true,
      },
    },
  },
  single_file_support = false,
}
