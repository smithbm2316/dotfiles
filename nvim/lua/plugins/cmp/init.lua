vim.o.completeopt = 'menuone,noselect'

-- plugin modules used in this file
local cmp = require 'cmp'
local lspkind = require'lspkind'

-- override rose-pine nvim-cmp highlight groups
if package.loaded['rose-pine'] then
  local palette = require'rose-pine.palette'
  local hl = require'rose-pine.util'.highlight
  local hl_groups = {
    CmpItemAbbr = { fg = palette.subtle },
    CmpItemAbbrDeprecated = { fg = palette.highlight_inactive, style = 'strikethrough' },
    CmpItemAbbrMatch = { fg = palette.iris, style = 'bold' },
    CmpItemAbbrMatchFuzzy = { fg = palette.foam, style = 'bold' },
    CmpItemKind = { fg = palette.rose },
    CmpGhostText = { fg = palette.inactive, style = 'italic' },
  }
  for hl_group, color_tbl in pairs(hl_groups) do
    hl(hl_group, color_tbl)
  end
end

-- setup nvim-cmp
cmp.setup {
  documentation = {
    border = 'double',
  },
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = math.floor(vim.api.nvim_win_get_width(0) / 2),
      maxheight = math.floor(vim.api.nvim_win_get_height(0) / 3 * 2),
      menu = ({
        buffer = '[buf]',
        nvim_lsp = '[lsp]',
        luasnip = '[snip]',
        nvim_lua = '[lua]',
        latex_symbols = '[latex]',
      }),
    }),
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
    ['<tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<c-k>', true, true, true))
      -- elseif require'luasnip'.expand_or_jumpable() then
        -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<s-tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<c-p>', true, true, true), 'n')
      -- elseif require'luasnip'.jumpable(-1) then
        -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
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
  }
}
