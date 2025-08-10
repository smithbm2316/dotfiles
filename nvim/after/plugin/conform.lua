function jsfmt(bufnr)
  -- if it's a work project where we use eslint and prettier for formatting
  -- and auto-fixing, then run both in sequence
  if
    string.match(vim.fn.getcwd(), vim.env.HOME .. '/work/') ~= nil
    and root_pattern(_G.config_files.eslint)
  then
    return { 'eslint_d', 'prettierd' }
    -- otherwise just run prettier
  else
    return { 'prettierd' }
  end
end

require('conform').setup {
  -- Set default options
  default_format_opts = {
    lsp_format = 'fallback',
  },
  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return {
      lsp_format = 'fallback',
      timeout_ms = 500,
      -- undojoin = true,
    }
  end,
  formatters_by_ft = {
    go = { 'gofmt' },
    graphql = { 'prettierd' },
    javascript = jsfmt,
    javascriptreact = jsfmt,
    json = { 'fixjson' },
    lua = { 'stylua' },
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
