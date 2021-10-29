-- luasnip modules
local ls = require 'luasnip'
local snip = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = require('luasnip.extras').rep
local events = require 'luasnip.util.events'
local types = require 'luasnip.util.types'

ls.config.set_config {
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '', 'LspDiagnosticsSignHint' } }, -- ●
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { '', 'LspDiagnosticsSignWarning' } },
      },
    },
  },
  delete_check_events = 'InsertLeave',
}

local snippets = {}

-- snippets for web development
local webdev_snippets = {
  snip({
    trig = 'log',
    name = 'console.log',
    dscr = 'console.log something out',
  }, {
    t 'console.log(',
    i(0),
    t ')',
  }),
  snip({
    trig = 'imdc',
    dscr = 'import default component',
  }, {
    t 'import ',
    r(2),
    t " from '@",
    i(1, 'location'),
    t '/',
    i(2, 'component'),
    t "'",
  }),
  snip({
    trig = 'im',
    name = 'import',
    dscr = 'import a component/function from a package',
  }, {
    t 'import { ',
    i(0, 'component'),
    t ' } ',
    t "from '",
    i(1, 'package'),
    t "'",
  }),
  snip({
    trig = 'require',
    dscr = 'require statement',
  }, {
    t 'const ',
    d(2, function(nodes)
      return sn(1, { i(1, nodes[1][1]) })
    end, { 1 }),
    t " = require('",
    i(1, 'ModuleName'),
    t "');",
  }),
  snip({
    trig = 'logc',
    dscr = 'colored console.log',
  }, {
    t 'console.log(',
    i(0, 'output'),
    t ');',
  }),
  snip({
    trig = 'logf',
    dscr = 'formatted console.log',
  }, {
    t 'console.log(`',
    i(1, 'varName'),
    t ': ${',
    i(0, 'var'),
    t '}`);',
  }),
}

snippets.javascript = webdev_snippets
snippets.javascriptreact = webdev_snippets
snippets.typescript = webdev_snippets
snippets.typescriptreact = webdev_snippets

-- wrapper for basic lua snippets
local lua_snippet = function(trig, text)
  -- set a cmd-line abbreviation for luasnip expansions
  vim.cmd(string.format('cnoreabbrev %s lua %s', trig, text))

  return snip({ trig = trig }, {
    t { text },
  })
end

snippets.lua = {
  --[[
  snip({trig='if', wordTrig=true}, {
    t({'if '}),
    i(1),
    t({' then', '\t'}),
    i(0),
    t({'', 'end'})
  }),
  snip({trig='for', wordTrig=true}, {
    t({'for '}),
    i(1),
    t({' do', '\t'}),
    i(0),
    t({'', 'end'})
  }),
  --]]
  lua_snippet('nv', 'vim.api.nvim_'),
  lua_snippet('nvb', 'vim.api.nvim_buf_'),
  lua_snippet('nvw', 'vim.api.nvim_win_'),
  lua_snippet('nvt', 'vim.api.nvim_tabpage_'),
  lua_snippet('fn', 'vim.fn.'),
  lua_snippet('diag', 'vim.diagnostic.'),
  lua_snippet('lsp', 'vim.lsp.'),
  lua_snippet('opt', 'vim.opt.'),
  lua_snippet('tbl', 'vim.tbl_'),
}

-- load all my snippets :D
ls.snippets = snippets
