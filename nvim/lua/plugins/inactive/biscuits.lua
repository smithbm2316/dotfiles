local has_biscuits, biscuits = pcall(require, 'nvim-biscuits')

if has_biscuits then
  biscuits.setup {
    max_length = 5,
    trim_by_words = true,
    -- cursor_line_only = true,
    toggle_keybind = '<leader>nb',
    on_events = { 'InsertLeave' },
  }

  vim.cmd('highlight BiscuitColor guifg=' .. bs.colors.dark.subtle)
end
