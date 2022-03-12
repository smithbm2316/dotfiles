local nvim_cmp = {}

vim.o.completeopt = 'menuone,noselect'
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local has_luasnip, luasnip = pcall(require, 'luasnip')

-- override rose-pine nvim-cmp highlight groups
nvim_cmp.load_cmp_hlgroups = function()
  local has_palette, palette = pcall(require, 'rose-pine.palette')
  if has_palette then
    local hl_groups = {
      CmpItemAbbr = { fg = palette.subtle },
      CmpItemAbbrDeprecated = { fg = palette.highlight_inactive, style = 'strikethrough' },
      CmpItemAbbrMatch = { fg = palette.iris, style = 'bold' },
      CmpItemAbbrMatchFuzzy = { fg = palette.foam, style = 'bold' },
      CmpItemKind = { fg = palette.rose },
      CmpGhostText = { fg = palette.inactive, style = 'italic' },
    }
    for hl_group, color_tbl in pairs(hl_groups) do
      utils.hl(hl_group, color_tbl)
    end
  end
end
nvim_cmp.load_cmp_hlgroups()

-- setup nvim-cmp
cmp.setup {
  documentation = {
    border = 'double',
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
    ['<c-d>'] = cmp.mapping.scroll_docs(-4),
    ['<c-u>'] = cmp.mapping.scroll_docs(4),
    ['<c-e>'] = cmp.mapping.complete(),
    ['<c-y>'] = cmp.mapping.close(),
    ['<c-k>'] = cmp.mapping(function(fallback)
      if has_luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    --[[ ['<c-k>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }, function(fallback)
      if has_luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end), ]]
  },
  sources = {
    -- { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    {
      name = 'buffer',
      keyword_length = 4,
      max_item_count = 12,
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = {
      hl_group = 'CmpGhostText',
    },
  },
}

return nvim_cmp
