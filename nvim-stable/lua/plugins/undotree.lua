return {
  'mbbill/undotree',
  keys = {
    {
      '<leader>ut',
      [[<cmd>UndotreeToggle<cr>]],
      desc = 'Show/hide Undotree',
    },
  },
  config = function()
    vim.g.undotree_DisabledFiletypes = {
      'DiffviewFiles',
      'TelescopePrompt',
      'harpoon',
      'help',
    }
  end,
}
