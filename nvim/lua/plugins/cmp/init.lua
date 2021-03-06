local nvim_cmp = {}

vim.o.completeopt = 'menuone,noselect'
local cmp = require 'cmp'
local lspkind = require 'lspkind'

-- override rose-pine nvim-cmp highlight groups
local rose_pine_installed, palette = pcall(require, 'rose-pine.palette')
if not rose_pine_installed then
  return
end
local hl_groups = {
  CmpItemAbbr = { fg = palette.subtle },
  CmpItemAbbrDeprecated = { fg = palette.highlight_inactive, style = 'strikethrough' },
  CmpItemAbbrMatch = { fg = palette.iris, style = 'bold' },
  CmpItemAbbrMatchFuzzy = { fg = palette.foam, style = 'bold' },
  CmpItemKind = { fg = palette.rose },
  CmpGhostText = { fg = palette.highlight_med, style = 'italic' },
}
for hl_group, color_tbl in pairs(hl_groups) do
  Utils.hl(hl_group, color_tbl)
end

-- setup nvim-cmp
cmp.setup {
  --[[ completion = {
    -- autocomplete = false,
    keyword_length = 3,
  }, ]]
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
  preselect = false,
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
    ['<c-d>'] = cmp.mapping.scroll_docs(-4),
    ['<c-u>'] = cmp.mapping.scroll_docs(4),
    ['<c-e>'] = cmp.mapping.complete(),
    ['<c-y>'] = cmp.mapping.close(),
    ['<c-k>'] = cmp.mapping(function(fallback)
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
  sources = {
    -- { name = 'nvim_lua' },
    -- { name = 'copilot' },
    { name = 'nvim_lsp', max_item_count = 30, keyword_length = 3 },
    { name = 'luasnip', max_item_count = 5 },
    { name = 'path' },
    --[[ {
      name = 'buffer',
      keyword_length = 4,
      max_item_count = 5,
    }, ]]
  },
  view = {
    entries = 'custom',
  },
  experimental = {
    ghost_text = {
      hl_group = 'CmpGhostText',
    },
  },
}

return nvim_cmp
