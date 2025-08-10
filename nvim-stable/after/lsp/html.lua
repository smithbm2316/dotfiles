return {
  filetypes = _G.html_like_fts_no_jsx,
  single_file_support = false,
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = false,
  },
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
}
