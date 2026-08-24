local columns = vim.api.nvim_get_option_value('columns', {})

local ok, mini_notify = pcall(require, 'mini.notify')
if not ok then
  return
end

mini_notify.setup {
  lsp_progress = { enable = false },
  window = {
    ---@type vim.api.keyset.win_config
    config = {
      anchor = columns <= 180 and 'NE' or 'NW',
      row = 0,
      col = columns <= 180 and columns or 0,
      relative = 'editor',
    },
  },
}

vim.notify = mini_notify.make_notify()

vim.keymap.set(
  'n',
  '<leader>lh',
  mini_notify.show_history,
  { desc = '[l]og [h]istory' }
)
