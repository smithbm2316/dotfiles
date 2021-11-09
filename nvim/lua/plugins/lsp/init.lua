local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

-- functions to hook into
local M = {}

-- zk cli lsp setup
configs.zk = {
  default_config = {
    cmd = { 'zk', 'lsp', '--log', '/tmp/zk-lsp.log' },
    filetypes = { 'markdown' },
    root_dir = function()
      return vim.loop.cwd()
    end,
    settings = {},
  },
}

configs.zk.index = function()
  vim.lsp.buf.execute_command {
    command = 'zk.index',
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
end

configs.zk.new = function(...)
  vim.lsp.buf_request(0, 'workspace/executeCommand', {
    command = 'zk.new',
    arguments = {
      vim.api.nvim_buf_get_name(0),
      ...,
    },
  }, function(_, _, result)
    if not (result and result.path) then
      return
    end
    vim.cmd('edit ' .. result.path)
  end)
end

vim.cmd [[command! -nargs=0 ZkIndex :lua require'lspconfig'.zk.index()]]
vim.cmd [[command! -nargs=? ZkNew :lua require'lspconfig'.zk.new(<args>)]]

-- astro lsp setup
configs.astro_language_server = {
  default_config = {
    cmd = { 'astro-ls', '--stdio' },
    filetypes = { 'astro' },
    root_dir = function(fname)
      return util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
    end,
    docs = {
      description = 'https://github.com/snowpackjs/astro-language-tools',
      root_dir = [[root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")]],
    },
    settings = {},
  },
}

configs.ls_emmet = {
  default_config = {
    filetypes = {
      'javascript',
      'typescript',
      'typescriptreact',
      'javascriptreact',
      'html',
      'css',
      'sass',
      'scss',
      'astro',
      'vue',
      'svelte',
    },
    cmd = { 'ls_emmet', '--stdio' },
    root_dir = function(fname)
      return vim.loop.cwd()
    end,
  },
}

local my_on_attach = function(client, bufnr)
  -- show hover, enter hover menu on second run
  nnoremap('gh', [[<cmd>lua vim.lsp.buf.hover()<cr>]], nil, bufnr)
  -- code action
  nnoremap('ca', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], nil, bufnr)
  -- rename symbol
  nnoremap('<leader>rs', [[<cmd>lua vim.lsp.buf.rename()<cr>]], nil, bufnr)
  -- lsp references
  nnoremap('<leader>lr', [[<cmd>lua require'telescope.builtin'.lsp_references()<cr>]], nil, bufnr)
  -- lsp symbols
  nnoremap('<leader>lsw', [[<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<cr>]], nil, bufnr)
  nnoremap('<leader>lsd', [[<cmd>lua require'telescope.builtin'.lsp_dynamic_document_symbols()<cr>]], nil, bufnr)
  -- lsp diagnostics
  nnoremap('<leader>ldd', [[<cmd>lua require'telescope.builtin'.lsp_workspace_diagnostics()<cr>]], nil, bufnr)
  nnoremap('<leader>ldw', [[<cmd>lua require'telescope.builtin'.lsp_document_diagnostics()<cr>]], nil, bufnr)
  -- lsp definition
  nnoremap('gD', [[<cmd>lua vim.lsp.buf.definition()<cr>]], nil, bufnr)
  -- TODO: update this mapping with the new nightly breaking change
  -- next diagnostic
  nnoremap('[d', [[<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "double" } })<cr>]], nil, bufnr)
  -- prev diagnostic
  nnoremap(']d', [[<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "double" } })<cr>]], nil, bufnr)
  -- signature help hover
  nnoremap('<c-s>', [[<cmd>lua vim.lsp.buf.signature_help()<cr>]], nil, bufnr)
  inoremap('<c-s>', [[<cmd>lua vim.lsp.buf.signature_help()<cr>]], nil, bufnr)
  -- show diagnostics on current line in floating window: hover diagnostics for line
  nnoremap(
    'gh',
    [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ popup_opts = { border = "single" } })<cr>]],
    nil,
    bufnr
  )
  -- zk-cli bindings
  nnoremap('<leader>zi', [[:ZkIndex<cr>', opts]], nil, bufnr)
  vnoremap('<leader>zn', [[:'<,'>lua vim.lsp.buf.range_code_action()<cr>', opts]], nil, bufnr)
  nnoremap('<leader>zn', [[:ZkNew {title = vim.fn.input('Title: ')}<cr>', opts]], nil, bufnr)
  nnoremap('<leader>zl', [[:ZkNew {dir = 'log'}<cr>', opts]], nil, bufnr)

  if package.loaded['goto-preview'] then
    -- goto-preview plugin mappings
    -- TODO: write custom Telescope wrappers for these, we don't need the first two maps otherwise
    nnoremap('<leader>pr', [[<cmd>lua require('goto-preview').goto_preview_references()<cr>]])
    nnoremap('<leader>pi', [[<cmd>lua require('goto-preview').goto_preview_implementation()<cr>]])
    nnoremap('gd', [[<cmd>lua require('goto-preview').goto_preview_definition()<cr>]])
  end

  -- define buffer-local variable for virtual_text toggling
  vim.b.show_virtual_text = true
end

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
local my_capabilities = require('cmp_nvim_lsp').update_capabilities(lsp_capabilities)
my_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.ls_emmet.setup {
  on_attach = my_on_attach,
  capabilities = my_capabilities,
}

-- setup language servers
-- TODO: add user commands similar to vim-go plugin
-- https://github.com/fatih/vim-go
local servers = {
  'astro_language_server',
  'bashls',
  'cssls',
  'eslint',
  'gopls',
  'graphql',
  'html',
  'prismals',
  'pylsp',
  'svelte',
  'texlab',
  'vuels',
  'vimls',
  'yamlls',
  'zk',
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = my_on_attach,
    capabilities = my_capabilities,
  }
end

lspconfig.tsserver.setup {
  filetypes = {
    'javascript',
    'typescript',
    'typescriptreact',
    'javascriptreact',
  },
  on_attach = function(client, bufnr)
    my_on_attach(client, bufnr)
    -- disable tsserver from formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  end,
  commands = {
    OrganizeImports = {
      function()
        local params = {
          command = '_typescript.organizeImports',
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = '',
        }
        vim.lsp.buf.execute_command(params)
      end,
      description = 'Organize Imports',
    },
  },
}

lspconfig.jsonls.setup {
  on_attach = my_on_attach,
  capabilities = my_capabilities,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
        {
          fileMatch = { 'tsconfig*.json' },
          url = 'https://json.schemastore.org/tsconfig.json',
        },
        {
          fileMatch = {
            '.prettierrc',
            '.prettierrc.json',
            'prettier.config.json',
          },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        {
          fileMatch = { '.eslintrc', '.eslintrc.json' },
          url = 'https://json.schemastore.org/eslintrc.json',
        },
        {
          fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
          url = 'https://json.schemastore.org/babelrc.json',
        },
        {
          fileMatch = { 'lerna.json' },
          url = 'https://json.schemastore.org/lerna.json',
        },
        {
          fileMatch = { 'now.json', 'vercel.json' },
          url = 'https://json.schemastore.org/now.json',
        },
        {
          fileMatch = {
            '.stylelintrc',
            '.stylelintrc.json',
            'stylelint.config.json',
          },
          url = 'http://json.schemastore.org/stylelintrc.json',
        },
      },
    },
  },
}

-- sumneko_lua setup, using lua-dev plugin for better lua docs
local sumneko_root_path = os.getenv 'HOME' .. '/builds/lua-language-server'
local system_name = vim.fn.has 'mac' == 0 and 'Linux' or 'macOS'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

-- TODO: remove luadev, install cmp_nvim_lua, update runtime files in library,
-- make sure you have access to signature help still
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
            'spoon',
            'hs', -- hammerspoon
          },
          -- disable specific diagnostic messages
          disable = {
            'lowercase-global',
          },
        },
        workspace = {
          -- hammerspoon support
          library = {
            [vim.fn.expand '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs'] = true,
          },
        },
      },
    },
  },
}
lspconfig.sumneko_lua.setup(luadev)

-- manage lsp diagnostics
vim.diagnostic.config {
  underline = false,
  -- virtual_text = {
  --   severity = { min = vim.diagnostic.severity.WARN },
  -- },
  virtual_text = false,
  signs = true,
  update_in_insert = false,
}

-- toggle diagnostics virtual_text
M.toggle_diagnostics = function()
  if vim.b.show_virtual_text then
    vim.diagnostic.disable()
    vim.b.show_virtual_text = false
  else
    vim.diagnostic.enable()
    vim.b.show_virtual_text = true
  end
end
nnoremap('<leader>td', [[<cmd>lua require'plugins.lsp'.toggle_diagnostics()<cr>]])

-- define signcolumn lsp diagnostic icons
local diagnostic_signs = { ' ', ' ', ' ', ' ' }
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

return M
