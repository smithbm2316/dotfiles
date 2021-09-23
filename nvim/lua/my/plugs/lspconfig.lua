local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

-- functions to hook into
local m = {}

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
    -- os.getenv('HOME') .. '/builds/astro-language-tools/packages/language-server/bin/server.js',
    cmd = { 'astro-ls', '--stdio' },
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

-- eslint setup
local null_ls = require 'null-ls'
null_ls.config {}
lspconfig['null-ls'].setup {
  debug = false,
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
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  -- next diagnostic
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" } })<cr>', opts)
  -- prev diagnostic
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" } })<cr>', opts)
  buf_set_keymap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  -- show diagnostics on current line in floating window: hover diagnostics for line
  buf_set_keymap('n', '<leader>hd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ popup_opts = { border = "single" } })<cr>', opts)

  -- define buffer-local variable for virtual_text toggling
  vim.b.show_virtual_text = true

  -- show icons in completion
  local has_lspkind, lspkind = pcall(require, 'lspkind')
  if has_lspkind then
    lspkind.init({
      with_text = true,
    })
  end
end

-- setup language servers
local servers = { 'bashls', 'cssls', 'gopls', 'graphql', 'html', 'jedi_language_server', 'jsonls', 'vimls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = my_on_attach,
  })
end

lspconfig.tsserver.setup {
  filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'javascript.jsx', 'typescript.tsx' },
  on_attach = function(client, bufnr)
    my_on_attach(client, bufnr)
    -- disable tsserver from formatting, only use null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')

    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup {
      debug = false,
      enable_import_on_completion = true,
      -- prettier
      enable_formatting = true,
      formatter = 'prettier',
      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_enable_diagnostics = true,
      eslint_bin = 'eslint_d',
    }
    ts_utils.setup_client(client)
  end,
}

lspconfig.zk.setup {
  on_attach = my_on_attach,
}

lspconfig.astro_language_server.setup {
  on_attach = my_on_attach,
}

-- sumneko_lua setup, using lua-dev plugin for better lua docs
local sumneko_root_path = os.getenv('HOME') .. '/builds/lua-language-server'
local system_name = vim.fn.has('mac') == 0 and 'Linux' or 'macOS'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

-- TODO: find a way to conditionally load awesomeWM's runtime files and add globals when editing awesome files
local luadev = require('lua-dev').setup {
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
          -- disable specific diagnostic messages
          disable = {
            'lowercase-global',
          },
        },
        workspace = {
          -- hammerspoon support
          library = {
            [vim.fn.expand('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')] = true,
          }
        }
      },
    },
  },
}
lspconfig.sumneko_lua.setup(luadev)

-- manage lsp diagnostics
vim.diagnostic.config {
  underline = {
    severity = 'Error',
  },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = true,
  update_in_insert = false,
}

-- toggle diagnostics virtual_text
m.toggle_diagnostics = function()
  if vim.b.show_virtual_text then
    vim.diagnostic.disable()
    vim.b.show_virtual_text = false
  else
    vim.diagnostic.enable()
    vim.b.show_virtual_text = true
  end
end
nnoremap('<leader>td', [[<cmd>lua require'my.plugs.lspconfig'.toggle_diagnostics()<cr>]])

-- define signcolumn lsp diagnostic icons
local diagnostic_signs = { " ", " ", " ", " " }
local diagnostic_severity_fullnames = { 'Error', 'Warning', 'Hint', 'Information' }
local diagnostic_severity_shortnames = { 'Error', 'Warn', 'Hint', 'Info' }

-- define diagnostic icons/highlights for signcolumn and other stuff
for index, icon in ipairs(diagnostic_signs) do
  local fullname = diagnostic_severity_fullnames[index]
  local shortname = diagnostic_severity_shortnames[index]

  vim.fn.sign_define('DiagnosticSign' .. shortname, {
    text = icon,
    texthl = 'Diagnostic' .. shortname,
    linehl = '',
    numhl = '',
  })

  vim.fn.sign_define('LspDiagnosticsSign' .. fullname, {
    text = icon,
    texthl = 'LspDiagnosticsSign' .. fullname,
    linehl = '',
    numhl = '',
  })
end

return m
