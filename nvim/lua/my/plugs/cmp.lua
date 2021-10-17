vim.o.completeopt = 'menuone,noselect'

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local snip = luasnip.snippet
local sn = luasnip.snippet_node
local isn = luasnip.indent_snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local r = require 'luasnip.extras'.rep
local events = require 'luasnip.util.events'
local types = require 'luasnip.util.types'

require'luasnip'.config.setup {
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{"●", "LspDiagnosticsSignHint"}}
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = {{"●", "LspDiagnosticsSignWarning"}}
      }
    }
  },
  delete_check_events = 'InsertLeave',
}


-- load vscode-style/json-style snippets
require('luasnip/loaders/from_vscode').load({
  paths = {
    '~/dotfiles/nvim/snippets',
  }
})

-- for javascript/typescript/javascriptreact/typescriptreact snippets
local jsts = {
  -- console.log snippet
  snip(
    {
      trig = 'log',
      name = 'console.log',
      dscr = 'console.log something out'
    },
    {
      t('console.log('),
      i(0),
      t(')')
    }
  ),
  snip(
    {
      trig = 'imdc',
      dscr = 'import default component'
    },
    {
      t('import '),
      r(2),
      t(" from '@"),
      i(1, 'location'),
      t('/'),
      i(2, 'component'),
      t("'"),
    }
  ),
  snip(
    {
      trig = 'im',
      name = 'import',
      dscr = 'import a component/function from a package',
    },
    {
      t('import { '),
      i(0, 'component'),
      t(' } '),
      t("from '"),
      i(1, 'package'),
      t("'"),
    }
  ),
  snip(
    {
      trig = 'require',
      dscr = 'require statement'
    },
    {
      t('const '),
      d(2, function (nodes)
        return sn(1, {i(1, nodes[1][1])})
      end, {1}),
      t(" = require('"),
      i(1, 'ModuleName'),
      t("');"),
    }
  ),
}

-- load all my snippets :D
luasnip.snippets = {
  all = {},
  javascript = jsts,
  javascriptreact = jsts,
  typescript = jsts,
  typescriptreact = jsts,
  lua = {
    snip({trig="if", wordTrig=true}, {
      t({"if "}),
      i(1),
      t({" then", "\t"}),
      i(0),
      t({"", "end"})
    }),
  },
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
