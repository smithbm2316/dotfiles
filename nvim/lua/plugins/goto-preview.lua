return {
  'rmagatti/goto-preview',
  enabled = false,
  event = 'VeryLazy',
  opts = {
    width = math.floor(vim.api.nvim_win_get_width(0) / 2), -- Width of the floating window
    height = math.floor(vim.api.nvim_win_get_height(0) / 2), -- Height of the floating window
    border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
    default_mappings = false, -- Bind default mappings
    debug = false, -- Print debug information
    opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
    post_open_hook = function(bufnr, _) -- A function taking two arguments, a buffer and a window to be ran as a hook.
      vim.keymap.set(
        'n',
        'q',
        '<cmd>q<cr>',
        { buffer = bufnr, desc = 'Quit floating definition win' }
      )

      vim.keymap.set('n', '<leader>pr', function()
        require('goto-preview').goto_preview_references()
      end, { desc = 'Preview lsp references', buffer = bufnr })

      vim.keymap.set('n', '<leader>pi', function()
        require('goto-preview').goto_preview_implementation {}
      end, { desc = 'Preview lsp implementations', buffer = bufnr })

      vim.keymap.set('n', '<leader>pd', function()
        require('goto-preview').goto_preview_definition {}
      end, { desc = 'Preview lsp definition', buffer = bufnr })

      vim.keymap.set('n', '<leader>pt', function()
        require('goto-preview').goto_preview_type_definition {}
      end, { desc = 'Preview type definition', buffer = bufnr })
    end,
  },
}
