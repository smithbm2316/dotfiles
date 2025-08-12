return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'sass', 'scss', 'less' },
  init_options = { provideFormatter = false },
  root_dir = root_pattern { 'package.json', '.git' },
  settings = {
    -- settings docs:
    -- https://code.visualstudio.com/Docs/languages/CSS#_customizing-css-scss-and-less-settings
    css = {
      completion = {
        completePropertyWithSemicolon = false,
        triggerPropertyValueCompletion = true,
      },
      format = {
        braceStyle = 'collapse', --  put braces on the same line as rules (`collapse`), or put braces on own line, Allman / ANSI style (`expand`). Default `collapse`
        indentEmptyLines = false, --  add indenting whitespace to empty lines. Default: false
        insertFinalNewline = false, --  end with a newline: Default: false
        insertSpaces = true, --  Whether to use spaces or tabs
        maxPreserveNewLines = nil, --  maximum number of line breaks to be preserved in one chunk. Default: unlimited
        newlineBetweenRules = true, --  add a new line after every css rule: Default: true
        newlineBetweenSelectors = true, --  separate selectors with newline (e.g. "a,\nbr" or "a, br"): Default: true
        preserveNewLines = true, --  whether existing line breaks before elements should be preserved. Default: true
        spaceAroundSelectorSeparator = true, --  ensure space around selector separators:  '>', '+', '~' (e.g. "a>b" -> "a > b"): Default: false
        tabSize = 2, --  indentation size. Default: 4
        wrapLineLength = nil, --  maximum amount of characters per line (0/undefined = disabled). Default: disabled.
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
    sass = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
  single_file_support = false,
}
