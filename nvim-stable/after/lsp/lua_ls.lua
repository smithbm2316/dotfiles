return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua', 'tl' },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Disable',
        keywordSnippet = 'Disable',
      },
      diagnostics = {
        enable = true,
        -- disable specific diagnostic messages
        disableScheme = { '.etlua' },
        disable = {
          'inject-field',
          'lowercase-global',
        },
        --[[ severity = {
          ['inject-field'] = 'Hint',
        }, ]]
      },
      workspace = {
        -- https://www.reddit.com/r/neovim/comments/wgu8dx/configuring_neovim_for_l%C3%B6velua_i_always_get/ij22yo9/
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
