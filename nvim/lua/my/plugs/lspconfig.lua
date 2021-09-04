local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'
local map = vim.api.nvim_set_keymap

-- zk cli lsp setup
configs.zk = {
  default_config = {
    cmd = { 'zk', 'lsp' },
    filetypes = { 'markdown' },
    root_dir = function()
      return vim.loop.cwd()
    end,
    settings = {},
  },
}

-- astro lsp setup
configs.astro_language_server = {
  default_config = {
    cmd = {
      os.getenv('HOME') .. '/builds/astro-language-tools/packages/language-server/bin/server.js',
      '--stdio'
    },
    filetypes = { 'astro' },
    root_dir = function(fname)
      return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
    end,
    docs = {
      description = 'https://github.com/snowpackjs/astro-language-tools',
      root_dir = [[root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")]],
    },
    settings = {},
  },
}

local my_on_attach = function(client, bufnr)
  -- aliases for keybinds below
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings
  local opts = { noremap = true, silent = true }
  -- show hover, enter hover menu on second run
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  -- code action
  buf_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  -- rename symbol
  buf_set_keymap('n', '<leader>rs', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  -- lsp references
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  -- lsp definition
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  -- next diagnostic
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  -- prev diagnostic
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  -- show diagnostics on current line in floating window
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)

  -- show icons in completion
  local has_lspkind, lspkind = pcall(require, 'lspkind')
  if has_lspkind then
    lspkind.init({
      with_text = true,
    })
  end

  -- TODO: setup lspsaga instead of lspsignature
  -- TODO: setup custom tsserver settings
  -- show signature help automatically
  local has_lsp_signature, lsp_signature = pcall(require, 'lsp_signature')
  if not has_lsp_signature then
    lsp_signature.on_attach {
      bind = true,
      lsp_saga = false,
      hint_prefix = nil,
      handler_opts = {
        border = 'double',
      },
      hint_enable = true,
      doc_lines = 10,
    }
  end
end

-- setup language servers
local servers = { 'bashls', 'cssls', 'gopls', 'graphql', 'html', 'jedi_language_server', 'jsonls', 'vimls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = my_on_attach,
  })
end

lspconfig.tsserver.setup({
  filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'javascript.jsx', 'typescript.tsx' },
  on_attach = function(client, bufnr)
    my_on_attach(client, bufnr)
    -- autocommand to automatically organize imports for tsserver files
    -- vim.cmd([[
    --   augroup TSServerOrganizeImports
    --     au!
    --     au BufWritePost * lua vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}, title = "" })
    --   augroup END
    -- ]])
    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup {
      debug = false,
      enable_formatting = false,
      formatter = 'prettier',
      enable_import_on_completion = true,
    }
    ts_utils.setup_client(client)
  end,
})

lspconfig.zk.setup({
  on_attach = my_on_attach,
})

lspconfig.astro_language_server.setup {
  on_attach = my_on_attach,
}

-- sumneko_lua setup, using lua-dev plugin for better lua docs
local sumneko_root_path = os.getenv('HOME') .. '/builds/lua-language-server'
local system_name = vim.fn.has('mac') == 0 and 'Linux' or 'macOS'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

-- TODO: find a way to conditionally load awesomeWM's runtime files and add globals when editing awesome files
local luadev = require('lua-dev').setup({
  library = {
    vimruntime = true,
    types = true,
    plugins = {
      'telescope.nvim',
      'plenary.nvim',
    },
  },
  lspconfig = {
    on_attach = my_on_attach,
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'awesome', -- awesomewm
            'spoon', 'hs', -- hammerspoon
          },
        },
      },
    },
  },
})

lspconfig.sumneko_lua.setup(luadev)

-- manage lsp diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = false,
    -- Use a function to dynamically turn virtual_text off
    -- and on, using buffer local variables
    virtual_text = function()
      if vim.b.show_virtual_text == nil then
        vim.b.show_virtual_text = true
        return true
      else
        return vim.b.show_virtual_text
      end
    end,
    signs = true,
    update_in_insert = false,
  }
)
map('n', '<leader>td', '<cmd>lua vim.b.show_virtual_text = not vim.b.show_virtual_text; vim.lsp.diagnostic.redraw()<cr>', { noremap = true, silent = true })

-- define signcolumn lsp diagnostic icons
local signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = " "
}

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
