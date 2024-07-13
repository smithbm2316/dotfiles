return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim', -- icons for cmp
  },
  event = 'InsertEnter',
  config = function()
    vim.o.completeopt = 'menuone,noselect'
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local types = require 'cmp.types'

    -- setup nvim-cmp
    cmp.setup {
      -- disable this so that gopls doesn't put your selection in the middle of
      -- the menu by default
      -- https://github.com/hrsh7th/nvim-cmp/discussions/1670#discussioncomment-8391873
      preselect = cmp.PreselectMode.None,
      window = {
        documentation = {
          border = 'double',
        },
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      -- Neat trick for showing the exact LSP server that the completion comes from
      -- https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/cmp.lua
      formatting = {
        format = function(entry, vim_item)
          vim_item = lspkind.cmp_format {
            with_text = true,
            maxwidth = math.floor(vim.api.nvim_win_get_width(0) / 2),
            maxheight = math.floor(vim.api.nvim_win_get_height(0) / 3 * 2),
          }(entry, vim_item)

          local alias = {
            buffer = 'buf',
            path = 'path',
            nvim_lsp = 'lsp',
            luasnip = 'snip',
            nvim_lua = 'lua',
            tmux = 'tmux',
            latex_symbols = 'latex',
            nvim_lsp_signature_help = 'sig_help',
          }

          if entry.source.name == 'nvim_lsp' then
            vim_item.menu = entry.source.source.client.name
          else
            vim_item.menu = alias[entry.source.name] or entry.source.name
          end
          vim_item.menu = '[' .. vim_item.menu .. ']'
          return vim_item
        end,
      },
      mapping = {
        ['<c-p>'] = cmp.mapping.select_prev_item(),
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-e>'] = cmp.mapping.complete(),
        ['<c-y>'] = cmp.mapping.close(),
        ['<c-k>'] = cmp.mapping(function(--[[fallback]])
          if cmp.visible() then
            cmp.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }
          end
        end, {
          'i',
          's',
        }),
      },
      sources = cmp.config.sources({
        {
          name = 'nvim_lsp',
          -- disable "Text" completions from LSP
          -- https://github.com/hrsh7th/nvim-cmp/pull/1067
          entry_filter = function(entry, _) -- entry, ctx
            -- don't disable "Text" completions for markdown files
            -- https://github.com/artempyanykh/marksman/issues/295#issuecomment-1930741104
            local ft = vim.api.nvim_buf_get_option(0, 'filetype')
            if ft == 'markdown' then
              return true
            end

            local kind = types.lsp.CompletionItemKind[entry:get_kind()]
            if kind == 'Text' then
              return false
            end
            return true
          end,
        },
        { name = 'lazydev', group_index = 0 },
        { name = 'luasnip', max_item_count = 5 },
      }, {
        { name = 'path' },
      }),
      view = {
        entries = 'custom',
      },
      experimental = {
        ghost_text = {
          hl_group = 'CmpGhostText',
        },
      },
    }
  end,
  import = 'plugins.cmp.tailwind',
}
