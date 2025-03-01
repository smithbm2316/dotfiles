return {
  'mfussenegger/nvim-lint',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    require('lint').linters_by_ft = {
      -- disable defaults
      clojure = {},
      dockerfile = {},
      inko = {},
      janet = {},
      json = {},
      markdown = {},
      rst = {},
      ruby = {},
      terraform = {},
      text = {},
    }

    local jsfts = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    }
    local eslintFilenames = {
      'eslint.config.js',
      'eslint.config.cjs',
      'eslint.config.mjs',
      '.eslintrc',
      '.eslintrc.cjs',
      '.eslintrc.js',
      '.eslintrc.json',
      '.eslintrc.yaml',
      '.eslintrc.yml',
    }

    vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
      callback = function()
        if not vim.diagnostic.is_enabled { bufnr = 0 } then
          return
        end

        local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        if
          vim.tbl_contains(jsfts, ft)
          and require('lspconfig.util').root_pattern(eslintFilenames)(
            vim.fn.getcwd()
          )
        then
          -- You can call `try_lint` with a linter name or a list of names to always
          -- run specific linters, independent of the `linters_by_ft` configuration
          require('lint').try_lint 'eslint_d'
        else
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          -- https://github.com/mfussenegger/nvim-lint/issues/569#issuecomment-2053944840
          require('lint').try_lint(nil, { ignore_errors = true })
        end
      end,
    })
  end,
}
