vim.lsp.set_log_level(vim.log.levels.WARN)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- show hover
    vim.keymap.set(
      'n',
      'gh',
      vim.lsp.buf.hover,
      { desc = '[g]oto lsp [h]over info', buffer = args.buf }
    )
    -- `:help lsp-defaults` keybindings to disable default binding for hover
    vim.keymap.del('n', 'K', { buffer = args.buf })

    -- signature help
    vim.keymap.set(
      { 'n', 'i' },
      '<c-s>',
      vim.lsp.buf.signature_help,
      { desc = '[s]how lsp signature help', buffer = args.buf }
    )

    -- code action
    vim.keymap.set(
      'n',
      '<leader>ca',
      vim.lsp.buf.code_action,
      { desc = 'lsp [c]ode [a]ction', buffer = args.buf }
    )

    -- rename symbol
    vim.keymap.set('n', '<leader>rn', function()
      require('lsp.rename').rename()
    end, { desc = 'lsp [r]e[n]ame symbol under cursor', buffer = args.buf })

    -- lsp references
    vim.keymap.set(
      'n',
      '<leader>lr',
      vim.lsp.buf.references,
      { desc = '[l]sp [r]eferences', buffer = args.buf }
    )

    -- lsp implementation
    vim.keymap.set(
      'n',
      '<leader>li',
      vim.lsp.buf.implementation,
      { desc = 'goto [l]sp [i]mplementation', buffer = args.buf }
    )

    -- lsp symbols
    vim.keymap.set(
      'n',
      '<leader>lw',
      vim.lsp.buf.workspace_symbol,
      { desc = '[l]sp [w]orkspace symbols', buffer = args.buf }
    )
    vim.keymap.set(
      'n',
      '<leader>ls',
      vim.lsp.buf.document_symbol,
      { desc = '[l]sp document [s]ymbols', buffer = args.buf }
    )

    -- lsp definition
    vim.keymap.set(
      'n',
      'gd',
      vim.lsp.buf.definition,
      { desc = '[g]oto lsp [d]efinition', buffer = args.buf }
    )
    vim.keymap.set(
      'n',
      '<leader>ld',
      vim.lsp.buf.definition,
      { desc = '[g]oto lsp [d]efinition', buffer = args.buf }
    )

    -- lsp type definition
    vim.keymap.set(
      'n',
      '<leader>lt',
      vim.lsp.buf.type_definition,
      { desc = '[g]oto lsp [t]ype definition', buffer = args.buf }
    )

    --[[
    -- set up autocompletion
    -- Use CTRL-E to close and reject the current menu. |complete_CTRL-E|
    -- Use CTRL-Y to select an item. |complete_CTRL-Y|
    vim.lsp.completion.enable(true, args.id, args.buf, {
      autotrigger = true,
    })

    vim.keymap.set('i', '<c-k>', function()
      return vim.fn.pumvisible() and '<c-y>' or '<c-k>'
    end, {
      buffer = args.buf,
      expr = true,
      desc = 'LSP Autocomplete accept',
    })
    --]]
  end,
})

-- close signature_help on following events
-- vim.lsp.handlers['textDocument/signatureHelp'] =
--   vim.lsp.with(vim.lsp.handlers.signature_help, {
--     border = 'shadow',
--     close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
--   })
-- handle hover
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = 'double',
-- })

-- vim.lsp.config('*', {
--   capabilities = vim.tbl_deep_extend(
--     'force',
--     vim.lsp.protocol.make_client_capabilities(),
--     {
--       textDocument = {
--         completion = {
--           completionItem = {
--             snippetSupport = true,
--           },
--         },
--       },
--     }
--   ),
-- })

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
