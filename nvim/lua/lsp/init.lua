vim.lsp.log.set_level(vim.log.levels.WARN)

local valid_mini_extra_lsp_pickers = {
  'declaration',
  'definition',
  'document_symbol',
  'implementation',
  'references',
  'type_definition',
  'workspace_symbol',
}
local mini_extra_or_builtin_action = function(lsp_action)
  if
    type(MiniExtra) == 'table'
    and vim.tbl_contains(valid_mini_extra_lsp_pickers, lsp_action)
  then
    MiniExtra.pickers.lsp { scope = lsp_action }
  else
    vim.lsp.buf[lsp_action]()
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- set up config for textDocument/documentColor supporting LSPs
    if
      vim.lsp.client.supports_method(
        client,
        'textDocument/documentColor',
        ev.buf
      )
    then
      vim.lsp.document_color.enable(true, ev.buf, {
        style = 'virtual',
      })
    end

    vim.keymap.set(
      'n',
      'gh',
      vim.lsp.buf.hover,
      { desc = '[g]oto lsp [h]over info', buffer = ev.buf }
    )
    -- `:help lsp-defaults` keybindings to disable default binding for hover
    vim.keymap.del('n', 'K', { buffer = ev.buf })

    vim.keymap.set(
      { 'n', 'i' },
      '<c-s>',
      vim.lsp.buf.signature_help,
      { desc = '[s]how lsp signature help', buffer = ev.buf }
    )

    vim.keymap.set(
      'n',
      '<leader>ca',
      vim.lsp.buf.code_action,
      { desc = 'lsp [c]ode [a]ction', buffer = ev.buf }
    )

    vim.keymap.set('n', '<leader>rn', function()
      require('lsp.rename').rename()
    end, { desc = 'lsp [r]e[n]ame symbol under cursor', buffer = ev.buf })

    vim.keymap.set('n', '<leader>lr', function()
      mini_extra_or_builtin_action 'references'
    end, { desc = '[l]sp [r]eferences', buffer = ev.buf })

    vim.keymap.set('n', '<leader>li', function()
      mini_extra_or_builtin_action 'implementation'
    end, { desc = 'goto [l]sp [i]mplementation', buffer = ev.buf })

    vim.keymap.set('n', '<leader>lw', function()
      mini_extra_or_builtin_action 'workspace_symbol'
    end, { desc = '[l]sp [w]orkspace symbols', buffer = ev.buf })
    vim.keymap.set('n', '<leader>ls', function()
      mini_extra_or_builtin_action 'document_symbol'
    end, { desc = '[l]sp document [s]ymbols', buffer = ev.buf })

    vim.keymap.set(
      'n',
      'gd',
      vim.lsp.buf.definition,
      { desc = '[g]oto lsp [d]efinition', buffer = ev.buf }
    )

    vim.keymap.set('n', '<leader>lt', function()
      mini_extra_or_builtin_action 'type_definition'
    end, { desc = '[g]oto lsp [t]ype definition', buffer = ev.buf })
  end,
})

-- close signature_help on following events
vim.lsp.handlers['textDocument/signatureHelp'] = function()
  vim.lsp.buf.signature_help {
    border = 'shadow',
    close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
  }
end

-- set up hover window config
vim.lsp.handlers['textDocument/hover'] = function()
  vim.lsp.buf.hover {
    border = 'double',
  }
end

---@type vim.lsp.Config
local global_lsp_config = {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('mini.completion').get_lsp_capabilities()
  ),
}

vim.lsp.config('*', global_lsp_config)

vim.lsp.inlay_hint.enable(false)
vim.lsp.enable {
  'bashls',
  'cssls',
  'elixirls',
  'gopls',
  'graphql',
  'html',
  'jsonls',
  'lua_ls',
  'tailwindcss',
  'ts_ls',
}
