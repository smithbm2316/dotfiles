require('goto-preview').setup {
  width = math.floor(vim.api.nvim_win_get_width(0) / 2), -- Width of the floating window
  height = math.floor(vim.api.nvim_win_get_height(0) / 2), -- Height of the floating window
  border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
  default_mappings = false, -- Bind default mappings
  debug = false, -- Print debug information
  opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
  post_open_hook = function(bufnr, _) -- A function taking two arguments, a buffer and a window to be ran as a hook.
    nnoremap('q', '<cmd>q<cr>', 'Quit floating definition win', { buffer = bufnr })
  end,
}
