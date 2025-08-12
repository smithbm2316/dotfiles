-- manage lsp diagnostics
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  -- https://gpanders.com/blog/whats-new-in-neovim-0-11/#virtual-lines
  virtual_lines = false,
  signs = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
    text = diagnostic_icons,
  },
  -- TODO: ideally this should work? idk why it isn't right now
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

-- define buffer-local variable for toggling diangostic buffer decorations
---@diagnostic disable-next-line: inject-field
vim.b.show_diagnostics = true

vim.keymap.set('n', '<leader>td', function()
  if vim.b.show_diagnostics then
    vim.diagnostic.hide()
    vim.b.show_diagnostics = false
  else
    vim.diagnostic.show()
    vim.b.show_diagnostics = true
  end
end, { desc = '[t]oggle [d]iagnostics on/off' })

vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.jump {
    count = -1,
    float = true,
    severity = { min = vim.diagnostic.severity.WARN },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = '[d]iagnostics [p]revious' })
vim.keymap.set('n', '<leader>dP', function()
  vim.diagnostic.jump {
    count = -1,
    float = true,
    severity = { min = vim.diagnostic.severity.HINT },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = '[d]iagnostics [P]revious' })

vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.jump {
    count = 1,
    float = true,
    severity = { min = vim.diagnostic.severity.WARN },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = '[d]iagnostics [n]ext' })
vim.keymap.set('n', '<leader>dN', function()
  vim.diagnostic.jump {
    count = 1,
    float = true,
    severity = { min = vim.diagnostic.severity.HINT },
    wrap = true,
  }
  vim.wo.linebreak = true
end, { desc = '[d]iagnostics [N]ext (ALL diagnostic)' })

vim.keymap.set('n', '<leader>dh', function()
  vim.diagnostic.open_float { popup_bufnr_opts = { border = 'single' } }
end, { desc = '[d]iagnostics hover' })

vim.keymap.set('n', '<leader>dl', function()
  MiniExtra.pickers.diagnostic()
end, {
  desc = '[d]iagnostics [l]ist picker (mini.extra)',
})
