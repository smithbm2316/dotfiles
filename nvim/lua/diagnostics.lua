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
      [vim.diagnostic.severity.ERROR] = _G.diagnostic_icons.error,
      [vim.diagnostic.severity.WARN] = _G.diagnostic_icons.warn,
      [vim.diagnostic.severity.INFO] = _G.diagnostic_icons.info,
      [vim.diagnostic.severity.HINT] = _G.diagnostic_icons.hint,
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

-- TODO: refactor the diagnostic keymaps and settings into its own module, it's
-- separate from LSP now
--
--- Go to a specific diagnostic message in a particular direction
---@param direction string value can be 'prev' or 'next', direction in which message to show
---@param shouldGoToAny? boolean if false (default), only go to errors and warnings, otherwise go to any message
function goto_diagnostic_msg(direction, shouldGoToAny)
  vim.diagnostic['goto_' .. direction] {
    float = true,
    wrap = true,
    severity = not shouldGoToAny and {
      min = vim.diagnostic.severity.WARN,
    } or nil,
  }
  vim.wo.linebreak = true
end

-- prev diagnostic
vim.keymap.set('n', '<leader>dp', function()
  goto_diagnostic_msg 'prev'
end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', '<leader>dP', function()
  goto_diagnostic_msg('prev', true)
end, { desc = 'Previous diagnostic' })

-- next diagnostic
vim.keymap.set('n', '<leader>dn', function()
  goto_diagnostic_msg 'next'
end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>dN', function()
  goto_diagnostic_msg('next', true)
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
