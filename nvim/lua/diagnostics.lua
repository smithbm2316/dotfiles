-- manage lsp diagnostics
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  virtual_lines = false,
  signs = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '󱠃',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  update_in_insert = false,
  float = {
    header = 'Diagnostic',
    source = 'if_many',
    format = function(diagnostic)
      if diagnostic.code then
        return string.format('[%s]\n%s', diagnostic.code, diagnostic.message)
      else
        return diagnostic.message
      end
    end,
  },
}

-- toggle diagnostics
vim.keymap.set('n', '<leader>td', function()
  if vim.b.show_diagnostics then
    vim.diagnostic.hide()
    vim.b.show_diagnostics = false
  else
    vim.diagnostic.show()
    vim.b.show_diagnostics = true
  end
end, { desc = 'Toggle diagnostics' })

-- prev diagnostic
vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.jump {
    count = -1,
    float = true,
    severity = { min = vim.diagnostic.severity.WARN },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', '<leader>dP', function()
  vim.diagnostic.jump {
    count = -1,
    float = true,
    severity = { min = vim.diagnostic.severity.HINT },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = 'Previous diagnostic' })
-- next diagnostic
vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.jump {
    count = 1,
    float = true,
    severity = { min = vim.diagnostic.severity.WARN },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>dN', function()
  vim.diagnostic.jump {
    count = 1,
    float = true,
    severity = { min = vim.diagnostic.severity.HINT },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = 'Next diagnostic' })

-- show diagnostics on current line in floating window: hover diagnostics for line
vim.keymap.set('n', '<leader>dh', function()
  vim.diagnostic.open_float { popup_bufnr_opts = { border = 'single' } }
end, { desc = 'Hover diagnostic message' })

-- lsp diagnostics
vim.keymap.set('n', '<leader>dl', function()
  require('telescope.builtin').diagnostics()
end, { desc = 'Telescope diagnostics' })

-- define buffer-local variable for toggling diangostic buffer decorations
---@diagnostic disable-next-line: inject-field
vim.b.show_diagnostics = true
