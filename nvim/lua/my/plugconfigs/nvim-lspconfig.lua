require('lspkind').init()
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)

  -- aliases for keybinds below
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- set up omnifunc
  buf_set_option('omnifunc', 'v:lua,vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', '<leader>gi', ':lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', '<leader>pa', ':lua vim.lsp.buf.add_workspace_folder()<cr>', opts) -- project add directory
  buf_set_keymap('n', '<leader>pr', ':lua vim.lsp.buf.remove_workspace_folder()<cr>', opts) -- project remove directory
  buf_set_keymap('n', '<leader>pd', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts) -- project directory
  buf_set_keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<leader>td', ':lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', '<leader>gr', ':lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', '[d', ':lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', ']d', ':lua vim.lsp.diagnostic.goto_next()<cr>', opts)
end

-- setup language servers
local servers = { 'bashls', 'cssls', 'gopls', 'hls', 'html', 'jedi_language_server', 'tsserver', 'vimls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
