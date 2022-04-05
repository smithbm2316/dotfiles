local ok, formatter = pcall(require, 'formatter')
if not ok then
  return
end

-- configuration options for stylua
local filetype_configs = {
  lua = {
    function()
      return {
        exe = 'stylua',
        args = {
          -- '--config-path ~/dotfiles/stylua/stylua.toml',
          '--search-parent-directories',
          '-',
        },
        stdin = true,
      }
    end,
  },
  go = {
    function()
      return {
        exe = 'gofmt',
        args = {},
        stdin = true,
      }
    end,
  },
}

local prettier_config = {
  function()
    return {
      exe = 'prettierd',
      args = {
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      },
      stdin = true,
    }
  end,
}

-- add a prettier_config for all js/ts/vue/svelte filetypes
for _, ft in pairs {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'svelte',
  'vue',
  'html',
  'css',
  'astro',
  'json',
} do
  filetype_configs[ft] = prettier_config
end

-- setup formatter
formatter.setup {
  logging = false,
  filetype = filetype_configs,
}

-- call formatter.nvim automatically on save
create_augroup('AutoFormatting', {
  {
    events = 'BufWritePost',
    pattern = {
      '*.js',
      '*.mjs',
      '*.cjs',
      '*.jsx',
      '*.ts',
      '*.tsx',
      '*.svelte',
      '*.vue',
      '*.json',
      '*.lua',
      '*.go',
    },
    command = 'FormatWrite',
  },
})
nnoremap('<leader>tF', function()
  _G.BS_toggle_augroup 'AutoFormatting'
end, 'Toggle auto-formatting')
