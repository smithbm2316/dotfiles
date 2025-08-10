-- ~/.local/state/nvim/lsp.log
vim.lsp.set_log_level(vim.log.levels.WARN)

-- lsp renamer function that provides extra information
function lsp_rename()
  local curr_name = vim.fn.expand '<cword>'
  vim.ui.input({
    prompt = 'LSP Rename: ',
    default = curr_name,
  }, function(new_name)
    if new_name then
      ---@diagnostic disable-next-line: missing-parameter
      local lsp_params = vim.lsp.util.make_position_params()

      if not new_name or #new_name == 0 or curr_name == new_name then
        return
      end

      -- request lsp rename
      lsp_params.newName = new_name
      vim.lsp.buf_request(
        0,
        'textDocument/rename',
        lsp_params,
        function(_, res, ctx, _)
          if not res then
            return
          end

          -- apply renames
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

          -- print renames
          local changed_files_count = 0
          local changed_instances_count = 0

          if res.documentChanges then
            for _, changed_file in pairs(res.documentChanges) do
              changed_files_count = changed_files_count + 1
              changed_instances_count = changed_instances_count
                + #changed_file.edits
            end
          elseif res.changes then
            for _, changed_file in pairs(res.changes) do
              changed_instances_count = changed_instances_count + #changed_file
              changed_files_count = changed_files_count + 1
            end
          end

          -- compose the right print message
          vim.notify(
            string.format(
              'Renamed %s instance%s in %s file%s. %s',
              changed_instances_count,
              changed_instances_count == 1 and '' or 's',
              changed_files_count,
              changed_files_count == 1 and '' or 's',
              changed_files_count > 1 and "To save them run ':cfdo w'" or ''
            ),
            vim.log.levels.INFO
          )
        end
      )
    end
  end)
end

-- close signature_help on following events
vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'shadow',
    close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
  })
-- handle hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'shadow',
})

---@param _ any a reference to the lsp client
---@param bufnr number the buffer number
function on_attach(_, bufnr)
  -- show hover
  vim.keymap.set(
    'n',
    'gh',
    vim.lsp.buf.hover,
    { desc = 'Hover lsp docs', buffer = bufnr }
  )

  -- signature help
  vim.keymap.set(
    { 'n', 'i' },
    '<c-s>',
    vim.lsp.buf.signature_help,
    { desc = 'Show lsp signature help', buffer = bufnr }
  )

  -- code action
  vim.keymap.set(
    'n',
    '<leader>ca',
    vim.lsp.buf.code_action,
    { desc = 'Lsp code action', buffer = bufnr }
  )

  -- rename symbol
  vim.keymap.set(
    'n',
    '<leader>rn',
    lsp_rename,
    { desc = 'Lsp rename symbol', buffer = bufnr }
  )

  -- lsp references
  -- vim.keymap.set('n', '<leader>lr', function()
  --   require('telescope.builtin').lsp_references()
  -- end, { desc = 'Show lsp references', buffer = bufnr })

  -- workspace symbols
  -- vim.keymap.set(
  --   'n',
  --   '<leader>ps',
  --   require('telescope.builtin').lsp_dynamic_workspace_symbols,
  --   { desc = 'Project symbols' }
  -- )

  -- lsp implementations
  vim.keymap.set(
    'n',
    '<leader>li',
    vim.lsp.buf.implementation,
    { desc = 'Go to lsp implementation', buffer = bufnr }
  )

  -- lsp symbols
  -- vim.keymap.set('n', '<leader>lw', function()
  --   require('telescope.builtin').lsp_workspace_symbols()
  -- end, { desc = 'Lsp workspace symbols', buffer = bufnr })
  -- vim.keymap.set('n', '<leader>ls', function()
  --   require('telescope.builtin').lsp_document_symbols()
  -- end, { desc = 'Lsp document symbols', buffer = bufnr })

  -- lsp definition
  -- vim.keymap.set('n', 'gd', function()
  --   require('telescope.builtin').lsp_definitions()
  -- end, { desc = 'Goto lsp definition', buffer = bufnr })
  vim.keymap.set(
    'n',
    'gD',
    vim.lsp.buf.definition,
    { desc = 'Goto lsp definition', buffer = bufnr }
  )

  -- lsp type definition
  vim.keymap.set(
    'n',
    'gt',
    vim.lsp.buf.type_definition,
    { desc = 'Goto lsp type definition', buffer = bufnr }
  )
end

vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
          },
        },
      },
    }
  ),
})

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
