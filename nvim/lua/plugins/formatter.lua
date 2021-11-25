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

-- configuration options for prettier
local prettier_config = {
  function()
    return {
      exe = 'prettier',
      args = {
        '--stdin-filepath',
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
        '--single-quote',
        '--tab-width 2',
        '--trailing-comma all',
        '--jsx-single-quote',
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
} do
  filetype_configs[ft] = prettier_config
end

-- require formatter.nvim
require('formatter').setup {
  logging = false,
  filetype = filetype_configs,
}

-- call formatter.nvim automatically on save
vim.cmd [[
augroup AutoFormatting
  au!
  au BufWritePost *.js,*.jsx,*.ts,*.tsx,*.svelte,*.vue,*.lua,*.go FormatWrite
augroup END
]]
