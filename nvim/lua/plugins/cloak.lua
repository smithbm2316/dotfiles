return {
  'laytan/cloak.nvim',
  ft = 'env',
  opts = {
    enabled = true,
    cloak_character = '*',
    -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
    highlight_group = 'Comment',
    -- Applies the length of the replacement characters for all matched
    -- patterns, defaults to the length of the matched pattern.
    cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
    -- Wether it should try every pattern to find the best fit or stop after the first.
    try_all_patterns = true,
    patterns = {
      {
        -- Match any file starting with '.env'.
        -- This can be a table to match multiple file patterns.
        file_pattern = '.env*',
        -- Match an equals sign and any character after it.
        -- This can also be a table of patterns to cloak,
        -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
        cloak_pattern = '=.+',
      },
    },
  },
  config = function(_, opts)
    require('cloak').setup(opts)

    vim.keymap.set('n', '<leader>tC', [[<cmd>CloakToggle<cr>]], {
      desc = 'Toggle cloak.nvim',
    })
  end,
}
