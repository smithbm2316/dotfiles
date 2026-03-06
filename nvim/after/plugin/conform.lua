local deno_configs = {
  ['deno.json'] = true,
  ['deno.jsonc'] = true,
}

function jsfmt()
  -- if we are in a deno project, use the Deno fmt command
  for name, type in vim.fs.dir(vim.fn.getcwd()) do
    if type == 'file' and deno_configs[name] then
      return { 'deno_fmt' }
    end
  end

  -- otherwise just run prettier
  return { 'prettier' }
end

local default_format_opts = {
  lsp_format = 'fallback',
  timeout_ms = 500,
  -- undojoin = true,
}

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format before save',
  pattern = '*',
  group = vim.api.nvim_create_augroup('FormatConfig', { clear = true }),
  callback = function(ev)
    if vim.g.disable_autoformat or vim.b[ev.buf].disable_autoformat then
      return
    end

    local conform_opts =
      vim.tbl_extend('force', default_format_opts, { bufnr = ev.buf })
    local client = vim.lsp.get_clients({ name = 'ts_ls', bufnr = ev.buf })[1]

    if not client then
      require('conform').format(conform_opts)
      return
    end

    local request_result = client:request_sync('workspace/executeCommand', {
      command = '_typescript.organizeImports',
      arguments = { vim.api.nvim_buf_get_name(ev.buf) },
    })

    if request_result and request_result.err then
      vim.notify(request_result.err.message, vim.log.levels.ERROR)
      return
    end

    require('conform').format(conform_opts)
  end,
})

require('conform').setup {
  -- Set default options
  default_format_opts = default_format_opts,
  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return default_format_opts
  end,
  formatters_by_ft = {
    go = { 'gofmt' },
    graphql = { 'prettier' },
    javascript = jsfmt,
    javascriptreact = jsfmt,
    json = { 'fixjson' },
    -- jsonc = { 'fixjson' },
    lua = { 'stylua' },
    python = { 'ruff_fmt' },
    typescript = jsfmt,
    typescriptreact = jsfmt,
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
  -- Conform will notify you when no formatters are available for the buffer
  notify_no_formatters = true,
}

vim.keymap.set('n', '<leader>tf', function()
  if vim.b.disable_autoformat or vim.g.disable_autoformat then
    vim.cmd 'FormatEnable'
    vim.notify('Autoformatting enabled!', vim.log.levels.INFO)
  else
    vim.cmd 'FormatDisable'
    vim.notify('Autoformatting disabled!', vim.log.levels.INFO)
  end
end, { desc = 'Toggle auto-formatting' })

vim.api.nvim_create_user_command('FormatDisable', function(args)
  -- FormatDisable! will disable formatting just for this buffer
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
