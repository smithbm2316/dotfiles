return {
  filetypes = { 'css' },
  init_options = {
    provideFormatter = true,
  },
  settings = {
    -- settings docs:
    -- https://code.visualstudio.com/Docs/languages/CSS#_customizing-css-scss-and-less-settings
    css = {
      completion = {
        completePropertyWithSemicolon = false,
        triggerPropertyValueCompletion = true,
      },
      format = {
        preserveNewLines = true,
        spaceAroundSelectorSeparator = true,
      },
      lint = {
        argumentsInColorFunction = 'error',
        compatibleVendorPrefixes = 'warning',
        duplicateProperties = 'warning',
        hexColorLength = 'error',
        propertyIgnoredDueToDisplay = 'warning',
        unknownAtRules = 'ignore',
        vendorPrefix = 'warning',
      },
      validate = true,
    },
  },
}
