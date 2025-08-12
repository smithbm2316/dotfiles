-- if you want to write lua for something other than your neovim config, you
-- should add a .luarc.json file to that folder to override these default
-- settings for the lua lsp. for now though, this works fine for me.
-- lua-language-server config options: https://luals.github.io/wiki/settings/

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
        globals = { 'vim' },
        disable = {
          'inject-field',
          'lowercase-global',
        },
      },
      hint = {
        enable = false,
      },
      runtime = {
        path = {
          'lua',
          'lua/?.lua',
          'lua/?/init.lua',
          '?.lua',
          '?/init.lua',
        },
        version = 'LuaJIT',
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        -- https://www.reddit.com/r/neovim/comments/wgu8dx/configuring_neovim_for_l%C3%B6velua_i_always_get/ij22yo9/
        checkThirdParty = false,
        library = { '$VIMRUNTIME/lua', '${3rd}/luv/library' },
      },
    },
  },
}
