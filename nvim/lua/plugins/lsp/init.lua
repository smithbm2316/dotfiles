return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'nvim-lua/plenary.nvim',
    {
      'folke/lazydev.nvim',
      -- dependencies = {
      --   -- luvit/uv.[...] types
      --   'Bilal2453/luvit-meta',
      -- },
      lazy = true,
      ft = 'lua',
      opts = {
        runtime = vim.env.VIMRUNTIME,
        -- library = {
        --   {
        --     path = 'luvit-meta/library',
        --     words = { 'vim%.uv' },
        --   },
        -- },
      },
    },
    'pmizio/typescript-tools.nvim',
  },
  config = function()
    require 'plugins.lsp.config'

    ---@type string[]
    local servers_to_autostart = {}

    local ext_chars = 4 -- `.lua`
    for name, type in vim.fs.dir(vim.env.XDG_CONFIG_HOME .. '/nvim/after/lsp/') do
      local total_chars = #name
      if
        type == 'file'
        and name ~= 'disabled.lua'
        and total_chars >= ext_chars
      then
        table.insert(servers_to_autostart, name:sub(0, total_chars - ext_chars))
      end
    end

    vim.lsp.enable(servers_to_autostart)
  end,
}
