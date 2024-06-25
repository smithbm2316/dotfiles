return {
  'numToStr/Comment.nvim',
  event = 'InsertEnter',
  config = function()
    -- load Comment.nvim modules
    local ft = require 'Comment.ft'
    local utils = require 'Comment.utils'
    local extra = require 'Comment.extra'

    -- set default config table for Comment
    local config = {
      padding = true,
      ignore = nil,
      mappings = {
        basic = true,
        extra = false,
      },
      toggler = {
        line = 'cml',
        block = 'cmb',
      },
      opleader = {
        line = 'cl',
        block = 'cm',
      },
    }

    -- and load the plugin
    require('Comment').setup(config)

    ft.templ = {
      -- setup line comments as Go comments
      '// %s',
      -- and block comments as HTML comments
      '<!-- %s -->',
    }

    -- define wrapper function to map the extra Comment.nvim mappings to
    vim.keymap.set('n', 'cmo', function()
      -- This powers the `gco`
      extra.norm_o(utils.ctype.line, config) -- With linewise
    end, { desc = 'Extra comment.nvim mapping' })
    vim.keymap.set('n', 'cmO', function()
      -- This powers the `gcO`
      extra.norm_O(utils.ctype.line, config) -- With linewise
    end, { desc = 'Extra comment.nvim mapping' })
    vim.keymap.set('n', 'cmA', function()
      -- This powers the `gcA`
      extra.norm_A(utils.ctype.line, config) -- With linewise
    end, { desc = 'Extra comment.nvim mapping' })
  end,
}
