if not vim.fn.exists(vim.g.loaded_undotree) then
  return
end

vim.keymap.set(
  'n',
  '<leader>ut',
  [[<cmd>UndotreeToggle<cr>]],
  { desc = 'Show/hide Undotree' }
)

vim.g.undotree_DisabledFiletypes = {
  'DiffviewFiles',
  'TelescopePrompt',
  'harpoon',
  'help',
}
