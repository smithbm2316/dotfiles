local lint = require 'lint'

lint.linters_by_ft = {
  -- empty table disables defaults for nvim-lint
  clojure = {},
  dockerfile = {},
  gohtml = { 'htmlhint' },
  inko = {},
  janet = {},
  json = {},
  markdown = {},
  rst = {},
  ruby = {},
  terraform = {},
  text = {},
  tmpl = { 'htmlhint' },
}

vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufRead', 'BufWritePost' }, {
  callback = function()
    if not vim.diagnostic.is_enabled { bufnr = 0 } then
      return
    end

    local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })

    if
      vim.tbl_contains(js_ts_fts, ft)
      and root_pattern(config_files.eslint)
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
