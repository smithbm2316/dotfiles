return {
  'mustache/vim-mustache-handlebars',
  ft = { 'hbs', 'html.mustache', 'mustache' },
  config = function()
    local ft = vim.api.nvim_get_option_value('ft', { buf = 0 })
    if ft == 'html.mustache' then
      vim.treesitter.stop(0)
      vim.api.nvim_set_option_value('ft', 'mustache', { buf = 0 })
    end
  end,
}
