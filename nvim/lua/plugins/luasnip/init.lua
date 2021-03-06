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
local r = ls.restore_node
local rep = require('luasnip.extras').rep
local events = require 'luasnip.util.events'
local types = require 'luasnip.util.types'
local fmt = require('luasnip.extras.fmt').fmt
local ai = require 'luasnip.nodes.absolute_indexer'
--}}}

-- luasnip config setup
--{{{
ls.config.set_config {
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '●', 'DiagnosticHint' } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { '', 'DiagnosticWarn' } },
      },
    },
  },
  history = true,
  delete_check_events = 'InsertLeave',
  update_events = 'TextChanged,TextChangedI',
  ft_func = require('luasnip.extras.filetype_functions').from_cursor,
}
--}}}

-- luasnip helpers
--- insert an extra insert node for a type annotation if the current filetype matches
---@param position number the luasnip jump-node to use
---@param type_pattern string the pattern to insert for a type, use a `|` to show where the cursor should end up
---@param show_annotation_choice_first boolean whether the annotation should be the first choice in the choice node
---@return nil
--{{{
local add_ts_type = function(position, type_pattern, show_annotation_choice_first)
  return d(position, function()
    local ft = vim.api.nvim_buf_get_option(0, 'ft')

    if ft:match 'typescript' then
      -- generate the type annotation insert node based upon the position of the
      -- `|` character (where the cursor should be)
      local text_nodes = vim.split(type_pattern, '|')
      local choices = {
        {
          t(text_nodes[1]),
          i(1),
          t(text_nodes[2]),
        },
      }

      -- decide whether the type annotation insert node should be the first
      -- or second choice node
      if show_annotation_choice_first then
        table.insert(choices, t '')
      else
        table.insert(choices, 1, t '')
      end

      return sn(nil, c(1, choices))
    else
      return sn(nil, t '')
    end
  end)
end
---}}}

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
      -- name = i(0),
      name = c(2, {
        sn(nil, { t '{ ', i(1), t ' }' }),
        i(nil),
        sn(nil, { t 'type { ', i(1), t ' }' }),
      }),
    })
  ),
  --}}}
  -- insert a function component
  --{{{
  snip(
    {
      trig = 'fc',
      name = 'function component',
      dscr = 'insert a function component',
    },
    fmt(
      [[
  {export}function {name}({params}){return_type} {{
    {body}
  }}
  ]],
      {
        export = c(1, {
          t 'export default ',
          t 'export ',
          t '',
        }),
        name = i(2),
        params = i(3),
        return_type = i(4),
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
  const {name} = ({params}){return_type} => {{
    {body}
  }}
  {export}
  ]],
      {
        name = i(1),
        params = i(2),
        return_type = i(3),
        export = d(4, function(args)
          return sn(
            nil,
            c(1, {
              t('export default ' .. args[1][1]),
              t '',
            })
          )
        end, {
          1,
        }),
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
    fmt([[const [{state}, {setState}] = useState{type_annotation}({initial_value})]], {
      state = i(1),
      setState = f(function(args)
        if args[1][1]:len() > 0 then
          return 'set' .. args[1][1]:sub(1, 1):upper() .. args[1][1]:sub(2)
        else
          return ''
        end
      end, 1),
      type_annotation = add_ts_type(2, '<|>', true),
      initial_value = i(0),
    })
  ),
  --}}}
  -- useEffect with type annotation
  -- add the ability to auto-import this from React in your file,
  -- probably using LSP capabilities somehow. Maybe run the helper
  -- func from nvim-ts-lsp-utils or nvim-cmp that imports automatically
  --{{{
  snip(
    {
      trig = 'ue',
      name = 'useEffect',
      desc = 'useEffect',
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
  -- className attribute for easy Tailwind usage
  --{{{
  snip(
    {
      trig = 'cn',
      name = 'className',
      desc = 'Insert className attribute',
    },
    fmt([[className='{}']], {
      i(0),
    })
  ),
  --}}}
  -- console.dir an object with infinite depth for command line viewing
  --{{{
  snip(
    {
      trig = 'co',
      name = 'Console.Object',
      desc = 'console.dir(obj, { depth: Infinity })',
    },
    fmt([[console.dir({}, {{ depth: Infinity }})]], {
      i(1),
    })
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
      local ok, {var_name} = pcall(require, '{module_name}')
      if not ok then
        return
      end
      {end_point}
      ]],
      {
        module_name = i(1),
        var_name = c(2, { rep(1), i(nil) }),
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
for _, ft in ipairs { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'astro' } do
  ls.add_snippets(ft, webdev_snippets, {
    key = ft,
  })
end
ls.add_snippets('lua', lua_snippets, {
  key = 'lua',
})
-- why do we use a key here: https://github.com/L3MON4D3/LuaSnip/issues/81#issuecomment-1073301357

-- add keymap to reload snippets on demand
nnoremap('<leader>rs', function()
  vim.cmd [[luafile $XDG_CONFIG_HOME/nvim/lua/plugins/luasnip/init.lua]]
  vim.notify('Reloaded snippets!', 'info')
end, 'Reload Luasnip Snippets')
-- select next choice node
inoremap('<c-j>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, 'Choose next Luasnip choice node')
-- jump to next snippet point
inoremap('<c-l>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, 'Expand or jump to next Luasnip node')
-- jump to previous snippet point
inoremap('<c-h>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, 'Jump to previous Luasnip node')
