-- configuration options for stylua
local filetype_configs = {
  lua = {
    function()
      return {
        exe = 'stylua',
        args = {
          '--config-path ~/dotfiles/stylua/stylua.toml',
          '-',
        },
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
        vim.api.nvim_buf_get_name(0),
        '--single-quote',
        '--tab-width 2',
        '--trailing-comma all',
        '--jsx-bracket-same-line',
        '--jsx-single-quote',
      },
      stdin = true,
    }
  end,
}

-- add a prettier_config for all js/ts/vue/svelte filetypes
for i, ft in pairs({ 'javascript', 'javascriptreact', 'typescript', 'typescript', 'svelte', 'vue' }) do
  filetype_configs[ft] = prettier_config
end

-- require formatter.nvim
require('formatter').setup({
  logging = false,
  filetype = filetype_configs,
})

-- call formatter.nvim automatically on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.svelte,*.vue FormatWrite
augroup END
]],
  false
)
