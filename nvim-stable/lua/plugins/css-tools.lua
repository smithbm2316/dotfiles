return {
  'steschwa/css-tools.nvim',
  ft = { 'css' }, -- lazy load on `css` filetype
  opts = {
    -- https://github.com/microsoft/vscode-css-languageservice/blob/main/docs/customData.md
    -- https://github.com/microsoft/vscode-custom-data
    customData = {
      -- tailwindcss v4
      'https://gist.githubusercontent.com/steschwa/5a5b859caa0f96a3ada02b4dca145c44/raw/7a027941f59b484807a4db3b89553d2c09b57470/tailwindcss.customData.json',
    },
  },
}
