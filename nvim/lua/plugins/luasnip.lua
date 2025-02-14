return {
  'L3MON4D3/LuaSnip',
  enabled = false,
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  build = 'make install_jsregexp',
  event = 'InsertEnter',
  config = function()
    -- luasnip module imports
    local ls = require 'luasnip'
    local snip = ls.snippet
    local sn = ls.snippet_node
    -- local isn = ls.indent_snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    -- local r = ls.restore_node
    local rep = require('luasnip.extras').rep -- repeat node
    -- local events = require 'luasnip.util.events'
    local types = require 'luasnip.util.types'
    local fmt = require('luasnip.extras.fmt').fmt
    -- local ai = require 'luasnip.nodes.absolute_indexer'

    -- luasnip config setup
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

    -- luasnip helpers
    --- insert an extra insert node for a type annotation if the current filetype
    --- matches
    ---@param position number the luasnip jump-node to use
    ---@param type_pattern string the pattern to insert for a type, use a `|` to
    --- show where the cursor should end up
    ---@param show_annotation_choice_first boolean whether the annotation should
    --- be the first choice in the choice node
    ---@return nil
    ---@diagnostic disable-next-line
    local add_ts_type = function(
      position,
      type_pattern,
      show_annotation_choice_first
    )
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

    -- golang snippets
    local go_snippets = {
      -- handle error clause
      snip(
        {
          trig = 'er',
          name = 'handle error',
          desc = 'handle errors with err != nil clause',
        },
        fmt(
          [[
if err != nil {{
  {}
}}
]],
          { i(0) }
        )
      ),
      -- short variable declaration
      snip(
        {
          trig = 'var',
          name = 'short variable declaration',
          desc = 'shortcut for defining variables with := short declaration',
        },
        fmt([[{vars} := {value}]], {
          vars = i(1, 'vars'),
          value = i(0, 'value'),
        })
      ),
      snip(
        {
          trig = 'lv',
          name = 'log a value',
          desc = 'log.Printf/fmt.Sprintf/fmt.Printf',
        },
        fmt([[{func}("{format}", {val}, {repval})]], {
          func = c(1, {
            t 'log.Printf',
            t 'fmt.Sprintf',
            t 'fmt.Printf',
          }),
          format = c(2, {
            t '%#v',
            t '%T, %#v',
          }),
          val = i(3),
          repval = rep(3),
        })
      ),
    }
    ls.add_snippets('go', go_snippets, { key = 'go' })

    -- makefile snippets
    ls.add_snippets('make', {
      -- variable declaration
      snip(
        {
          trig = 'var',
          name = 'variable declaration',
        },
        fmt([[{var} := {value}]], {
          var = i(1, 'vars'),
          value = i(0, 'value'),
        })
      ),
    }, { key = 'make' })

    -- snippets for web development
    local webdev_snippets = {
      -- console.log shortcut
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
      -- console.dir shortcut
      snip(
        {
          trig = 'dir',
          name = 'console.dir',
          dscr = 'console.dir shortcut',
        },
        fmt([[console.dir({debug})]], {
          debug = i(0),
        })
      ),
      -- console.dir Infinity shortcut
      snip(
        {
          trig = 'dinf',
          name = 'console.dir inf',
          dscr = 'console.dir Infinity shortcut',
        },
        fmt([[console.dir({debug}, {{ depth: Infinity }})]], {
          debug = i(0),
        })
      ),
      -- node.js require() snippet
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
      -- import from node_modules package
      snip(
        {
          trig = 'im',
          name = 'import',
          dscr = 'import a component/function from a package',
        },
        fmt([[import {name} from '{path}';]], {
          path = i(1),
          name = c(2, {
            sn(nil, { t '{ ', i(1), t ' }' }),
            sn(nil, { t 'type { ', i(1), t ' }' }),
            sn(nil, { i(1) }),
          }),
        })
      ),
      -- import default export from node_modules package
      snip(
        {
          trig = 'imd',
          name = 'import default export',
          dscr = 'import a default export from a package',
        },
        fmt([[import {name} from '{path}';]], {
          path = i(1),
          name = i(0),
        })
      ),
      -- insert a function component
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
      -- insert an arrow function component
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
      -- console.dir an object with infinite depth for command line viewing
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
      -- console.log shortcut
      snip(
        {
          trig = 'ee',
          name = 'ts-expect-error',
          dscr = 'insert a ts-expect-error comment',
        },
        fmt([[// @ts-expect-error {reason}]], {
          reason = i(0),
        })
      ),
    }

    local lua_snippets = {
      -- luasnip snippet generator: *i used the luasnip to create the luasnip snippet* - thanos
      snip(
        {
          trig = 'lsnip',
          name = 'new luasnip snippet',
          desc = '*i used the luasnip to create the luasnip snippet* - thanos',
        },
        fmt(
          [[
  -- {comment}
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
      -- protected (pcall) require snippet
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
    for _, ft in ipairs {
      'javascript',
      'typescript',
      'typescriptreact',
      'javascriptreact',
      'astro',
    } do
      ls.add_snippets(ft, webdev_snippets, {
        key = ft,
      })
    end

    ls.add_snippets('lua', lua_snippets, {
      key = 'lua',
    })
    -- why do we use a key here: https://github.com/L3MON4D3/LuaSnip/issues/81#issuecomment-1073301357

    ls.add_snippets('all', {
      -- html5 boilerplate
      snip(
        {
          trig = 'html5',
          name = 'html5',
          dscr = 'html5 boilerplate',
        },
        fmt(
          [[<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="dark light">
  <title>Title</title>
</head>
<body>
  {content}
</body>
</html>]],
          {
            content = i(0),
          }
        )
      ),
      snip(
        'MIT',
        fmt(
          [[MIT License

Copyright (c) {year}-present Ben Smith

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.]],
          {
            year = f(function()
              return os.date '%Y'
            end),
          }
        )
      ),
    })

    -- load rafamadriz/friendly-snippets snippets
    require('luasnip.loaders.from_vscode').lazy_load {
      exclude = { 'css', 'go', 'html', 'javascript' },
    }
    -- load my local snippets
    require('luasnip.loaders.from_vscode').lazy_load {
      paths = { './snippets' },
    }

    -- add keymap to reload snippets on demand
    vim.keymap.set('n', '<leader>rs', function()
      vim.cmd [[luafile $XDG_CONFIG_HOME/nvim/lua/plugins/luasnip/init.lua]]
      vim.notify('Reloaded snippets!', vim.log.levels.INFO)
    end, { desc = 'Reload Luasnip Snippets' })
    -- select next choice node
    vim.keymap.set('i', '<c-j>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { desc = 'Choose next Luasnip choice node' })
    -- jump to next snippet point
    vim.keymap.set('i', '<c-l>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { desc = 'Expand or jump to next Luasnip node' })
    -- jump to previous snippet point
    vim.keymap.set('i', '<c-h>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { desc = 'Jump to previous Luasnip node' })
  end,
}
