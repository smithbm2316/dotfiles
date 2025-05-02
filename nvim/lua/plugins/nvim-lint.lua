return {
  'mfussenegger/nvim-lint',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    local lint = require 'lint'
    local eslint_namespaces_to_ignore = {
      'perfectionist/.*',
      'prettier/prettier',
      'sonarjs/*',
    }

    -- yay for this update: https://github.com/mfussenegger/nvim-lint/pull/768
    -- this configures the `eslint_d` parser to ignore diagnostics that come
    -- from some of the plugins in our Thuma astra codebase that are super noisy
    -- and useless info until i have saved a file (they auto-fix themselves on
    -- save anyways)
    --
    -- TODO: make the configuration of patterns here look similar to vscode's
    -- `eslint.rules.customizations` .vsocde/settings.json api
    -- link here: https://github.com/microsoft/vscode-eslint?tab=readme-ov-file#settings-options
    lint.linters.eslint_d = require('lint.util').wrap(
      lint.linters.eslint_d,
      function(diagnostic)
        if type(diagnostic.code) ~= 'string' then
          return diagnostic
        elseif diagnostic.code == 'no-console' then
          diagnostic.severity = vim.diagnostic.severity.WARN
          return diagnostic
        end

        for _, namespace_pattern in ipairs(eslint_namespaces_to_ignore) do
          if string.match(diagnostic.code, namespace_pattern) then
            return nil
          end
        end

        return diagnostic
      end
    )

    lint.linters_by_ft = {
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
      'svelte',
      'typescript',
      'typescriptreact',
      'vue',
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
        local enable_eslint = true
        if
          vim.tbl_contains(jsfts, ft)
          and require('lspconfig.util').root_pattern(eslintFilenames)(
            vim.fn.getcwd()
          )
          and enable_eslint
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
