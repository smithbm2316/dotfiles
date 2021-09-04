vim.o.completeopt = 'menuone,noselect'

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local snip = luasnip.snippet
local snode = luasnip.snippet_node
local indnode = luasnip.indent_snippet_node
local tnode = luasnip.text_node
local insnode = luasnip.insert_node
local fnnode = luasnip.function_node
local chnode = luasnip.choice_node
local dynode = luasnip.dynamic_node
local events = require('luasnip.util.events')

-- load vscode-style/json-style snippets
require('luasnip/loaders/from_vscode').load({
  paths = {
    '~/dotfiles/nvim/snippets',
  }
})

-- for javascript/typescript/javascriptreact/typescriptreact snippets
local jsts = {
  -- console.log snippet
  snip({ trig='log' }, {
    tnode('console.log('),
    insnode(1),
    tnode(')')
  }),
}

-- load all my snippets :D
luasnip.snippets = {
  all = {},
  javascript = jsts,
  javascriptreact = jsts,
  typescript = jsts,
  typescriptreact = jsts,
}


cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-d>'] = cmp.mapping.scroll_docs(-4),
    ['<c-u>'] = cmp.mapping.scroll_docs(4),
    ['<c-e>'] = cmp.mapping.complete(),
    ['<c-y>'] = cmp.mapping.close(),
    ['<c-k>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<c-k>'] = function()
    --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, true, true))
    -- end,
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<c-k>', true, true, true))
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<c-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}
