return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'FormatEnable', 'FormatDisable' },
  keys = {
    {
      '<leader>lf',
      function()
        if vim.b.disable_autoformat or vim.g.disable_autoformat then
          vim.cmd 'FormatEnable'
        else
          vim.cmd 'FormatDisable'
        end
      end,
      desc = 'Toggle auto-formatting',
    },
  },
  opts = {
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
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    -- If this is set, Conform will run the formatter asynchronously after save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_after_save = {
      lsp_format = 'fallback',
    },
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
  },
  config = function(_, opts)
    local prettier_fmt = { 'prettierd', 'prettier', stop_after_first = true }

    opts.formatters_by_ft = {
      -- django = { 'djlint' },
      -- gotmpl = { 'djlint' },
      -- jinja = { 'djlint' },
      -- nunjucks = { 'djlint' },
      -- python = { 'blue' },
      -- tmpl = { 'djlint' },
      blade = { 'pint' },
      go = { 'gofmt' }, -- 'goimports'
      graphql = prettier_fmt,
      javascript = prettier_fmt,
      javascriptreact = prettier_fmt,
      json = { 'fixjson' },
      lua = { 'stylua' },
      php = { 'pint' },
      tl = { 'stylua' },
      typescript = prettier_fmt,
      typescriptreact = prettier_fmt,
    }

    require('conform').setup(opts)

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
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
  end,
}
