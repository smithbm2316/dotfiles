-- luasnip module imports
--{{{
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
local fmt = require('luasnip.extras.fmt').fmt
--}}}

-- luasnip config setup
--{{{
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
  history = true,
  delete_check_events = 'InsertLeave',
}

local snippets = {}
--}}}

-- snippets for web development
local webdev_snippets = {
  -- console.log shortcut
  --{{{
  snip(
    {
      trig = 'log',
      name = 'console.log',
      dscr = 'console.log shortcut',
    },
    fmt([[console.log({debug})]], {
      debug = i(0),
    })
  ),
  --}}}
  -- node.js require() snippet
  --{{{
  snip(
    {
      trig = 'req',
      name = 'require()',
      dscr = 'node.js require import statement',
    },
    fmt([[const {importName} = require('{package}')]], {
      importName = i(0),
      package = i(1),
    })
  ),
  --}}}
  -- import from node_modules package
  --{{{
  snip(
    {
      trig = 'im',
      name = 'import',
      dscr = 'import a component/function from a package',
    },
    fmt([[import {name} from '{path}']], {
      path = i(1),
      name = i(0),
    })
  ),
  --}}}
  -- insert a function component
  --{{{
  snip(
    {
      trig = 'fc',
      name = 'function component',
      dscr = 'export a function component',
    },
    fmt(
      [[
  export function {name}({params}) {{
    {body}
  }}
  ]],
      {
        name = i(1),
        params = i(2),
        body = i(0),
      }
    )
  ),
  --}}}
  -- insert an arrow function component
  --{{{
  snip(
    {
      trig = 'ac',
      name = 'arrow component',
      dscr = 'export an arrow function component',
    },
    fmt(
      [[
  export const {name} = ({params}) => {{
    {body}
  }}
  ]],
      {
        name = i(1),
        params = i(2),
        body = i(0),
      }
    )
  ),
  --}}}
  -- insert a default arrow function component
  --{{{
  snip(
    {
      trig = 'dac',
      name = 'default arrow component',
      dscr = 'export a default arrow function component',
    },
    fmt(
      [[
  const {name} = ({params}) => {{
    {body}
  }}

  export default {exportName}
  ]],
      {
        name = i(1),
        params = i(2),
        body = i(0),
        exportName = r(1),
      }
    )
  ),
  --}}}
  -- insert a default function component
  --{{{
  snip(
    {
      trig = 'dfc',
      name = 'default function component',
      dscr = 'export a default function component',
    },
    fmt(
      [[
  export default function {name}({params}) {{
    {body}
  }}
  ]],
      {
        name = i(1),
        params = i(2),
        body = i(0),
      }
    )
  ),
  --}}}
  -- import a component and its 'links' export in remix
  --{{{
  snip(
    {
      trig = 'ric',
      name = 'remix import component',
      dscr = 'import a component/function from a package with its corresponding links func',
    },
    fmt([[import {{ {name}, links as {linksAlias} }} from '{path}']], {
      path = i(1),
      name = i(2),
      linksAlias = i(0),
    })
  ),
  --}}}
  -- useState with type annotation
  --{{{
  snip(
    {
      trig = 'us',
      name = 'useState',
      desc = 'useState with type annotation',
    },
    fmt([[const [{}, {}] = useState<{}>({})]], {
      i(1),
      f(function(args)
        if args[1][1]:len() > 0 then
          return 'set' .. args[1][1]:sub(1, 1):upper() .. args[1][1]:sub(2)
        else
          return ''
        end
      end, 1),
      i(2),
      i(0),
    })
  ),
  --}}}
  -- useEffect with type annotation
  --{{{
  snip(
    {
      trig = 'ue',
      name = 'useEffect',
      desc = 'useEffect with type annotation',
    },
    fmt(
      [[
    useEffect(() => {{
      {body}
    }}, [{deps}])
    ]],
      {
        deps = i(1),
        body = i(0),
      }
    )
  ),
  --}}}
}

local lua_snippets = {
  -- luasnip snippet generator: *i used the luasnip to create the luasnip snippet* - thanos
  --{{{
  snip(
    {
      trig = 'lsnip',
      name = 'new luasnip snippet',
      desc = '*i used the luasnip to create the luasnip snippet* - thanos',
    },
    fmt(
      [[
  -- {comment}
  --{{{{{{
  snip(
    {{
      trig = '{trig}',
      name = '{name}',
      desc = '{description}',
    }}, fmt(
      {snipText},
      {{
        {opts}
      }}
    )
  ),
  --}}}}}}
  ]],
      {
        comment = i(1),
        trig = i(2),
        name = i(3),
        description = i(4),
        snipText = i(5),
        opts = i(0),
      }
    )
  ),
  ---}}}
  -- protected (pcall) require snippet
  --{{{
  snip(
    {
      trig = 'preq',
      name = 'protected require',
      desc = 'ensure the module is loaded before requiring it',
    },
    fmt(
      [[
      local has_{name}, {name2} = pcall(require, '{module_name}')
      if has_{name3} then
        {name4}.{end_point}
      end
      ]],
      {
        name = i(1),
        name2 = r(1),
        module_name = i(2),
        name3 = r(1),
        name4 = r(1),
        end_point = i(0),
      }
    )
  ),
  --}}}
}

-- simple text node snippets for lua
local lua_text_snippets = {
  nv = 'vim.api.nvim_',
  nvb = 'vim.api.nvim_buf_',
  nvw = 'vim.api.nvim_win_',
  nvt = 'vim.api.nvim_tabpage_',
  fn = 'vim.fn.',
  diag = 'vim.diagnostic.',
  lsp = 'vim.lsp.',
  opt = 'vim.opt.',
  tbl = 'vim.tbl_',
}
for trig, text in pairs(lua_text_snippets) do
  table.insert(lua_snippets, snip({ trig = trig }, { t(text) }))
end

-- add snippets to luasnip
for _, ft in ipairs { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' } do
  ls.add_snippets(ft, webdev_snippets)
end
ls.add_snippets('lua', lua_snippets)

-- add keymap to reload snippets on demand
vim.keymap.set({ 'n' }, '<leader>rs', function()
  vim.cmd [[source $XDG_CONFIG_HOME/nvim/lua/plugins/luasnip/init.lua]]
  vim.notify('Reloaded snippets!', vim.log.levels.INFO)
end, {
  silent = true,
})
