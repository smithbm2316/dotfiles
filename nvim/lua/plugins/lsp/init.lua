local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local util = require 'lspconfig.util'

-- functions to hook into
local M = {}

local status = require 'plugins.lsp.status'
status.activate()

-- lsp renamer function that provides extra information
M.lsp_rename = function()
  local curr_name = vim.fn.expand '<cword>'
  vim.ui.input({
    prompt = 'LSP Rename: ',
    default = curr_name,
  }, function(value)
    if value then
      local lsp_params = vim.lsp.util.make_position_params()

      if not value or #value == 0 or curr_name == value then
        return
      end

      -- request lsp rename
      lsp_params.newName = value
      vim.lsp.buf_request(0, 'textDocument/rename', lsp_params, function(_, res, ctx, _)
        if not res then
          return
        end

        -- apply renames
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

        -- print renames
        local changed_files_count = 0
        local changed_instances_count = 0

        if res.documentChanges then
          for _, changed_file in pairs(res.documentChanges) do
            changed_files_count = changed_files_count + 1
            changed_instances_count = changed_instances_count + #changed_file.edits
          end
        elseif res.changes then
          for _, changed_file in pairs(res.changes) do
            changed_instances_count = changed_instances_count + #changed_file
            changed_files_count = changed_files_count + 1
          end
        end

        -- compose the right print message
        vim.notify(
          string.format(
            'Renamed %s instance%s in %s file%s. %s',
            changed_instances_count,
            changed_instances_count == 1 and '' or 's',
            changed_files_count,
            changed_files_count == 1 and '' or 's',
            changed_files_count > 1 and "To save them run ':cfdo w'" or ''
          ),
          'info'
        )
      end)
    end
  end)
end

-- close signature_help on following events
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
  close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
})

M.my_on_attach = function(client, bufnr)
  local bufnr_opts = { buffer = bufnr }

  -- show hover
  nnoremap('gh', function()
    vim.lsp.buf.hover()
  end, 'Hover lsp docs', bufnr_opts)
  inoremap('<c-h>', function()
    vim.lsp.buf.hover()
  end, 'Hover lsp docs', bufnr_opts)

  -- signature help
  noremap({ 'n', 'i' }, '<c-s>', function()
    vim.lsp.buf.signature_help()
  end, 'Show lsp signature help', bufnr_opts)

  -- code action
  nnoremap('<leader>ca', function()
    vim.lsp.buf.code_action()
  end, 'Lsp code action', bufnr_opts)

  -- rename symbol
  nnoremap('<leader>rn', M.lsp_rename, 'Lsp rename symbol', bufnr_opts)

  -- lsp references
  nnoremap('<leader>lr', function()
    require('telescope.builtin').lsp_references()
  end, 'Show lsp references', bufnr_opts)

  -- lsp symbols
  nnoremap('<leader>lsw', function()
    require('telescope.builtin').lsp_dynamic_workspace_symbols()
  end, 'Lsp workspace symbols', bufnr_opts)
  nnoremap('<leader>lsd', function()
    require('telescope.builtin').lsp_dynamic_document_symbols()
  end, 'Lsp document symbols', bufnr_opts)

  -- lsp diagnostics
  nnoremap('<leader>ldd', function()
    require('telescope.builtin').lsp_workspace_diagnostics()
  end, 'Lsp workspace diagnostics', bufnr_opts)
  nnoremap('<leader>ldw', function()
    require('telescope.builtin').lsp_document_diagnostics()
  end, 'Lsp document diagnostics', bufnr_opts)

  -- lsp definition
  nnoremap('gD', [[<cmd>lua vim.lsp.buf.definition()<cr>]], 'Goto lsp definition', bufnr_opts)

  -- prev diagnostic
  nnoremap('<leader>dp', function()
    vim.diagnostic.goto_prev { popup_bufnr_opts = { border = 'double' } }
  end, 'Previous diagnostic', bufnr_opts)

  -- next diagnostic
  nnoremap('<leader>dn', function()
    vim.diagnostic.goto_next { popup_bufnr_opts = { border = 'double' } }
  end, 'Next diagnostic', bufnr_opts)

  -- show diagnostics on current line in floating window: hover diagnostics for line
  nnoremap('<leader>dh', function()
    vim.diagnostic.open_float { popup_bufnr_opts = { border = 'single' } }
  end, 'Hover diagnostic message', bufnr_opts)

  -- goto-preview plugin mappings
  if pcall(require, 'goto-preview') then
    -- TODO: write custom Telescope wrappers for these, we don't need the first two maps otherwise
    nnoremap('<leader>pr', function()
      require('goto-preview').goto_preview_references()
    end, 'Preview lsp references', bufnr_opts)
    nnoremap('<leader>pi', function()
      require('goto-preview').goto_preview_implementation()
    end, 'Preview lsp implementations', bufnr_opts)
    nnoremap('gd', function()
      require('goto-preview').goto_preview_definition()
    end, 'Preview lsp definition', bufnr_opts)
  end

  -- define buffer-local variable for virtual_text toggling
  vim.b.show_virtual_text = true

  -- show status
  status.on_attach(client)
end

M.my_capabilities = vim.lsp.protocol.make_client_capabilities()
M.my_capabilities = vim.tbl_deep_extend('keep', M.my_capabilities, require('lsp-status').capabilities)
M.my_capabilities = require('cmp_nvim_lsp').update_capabilities(M.my_capabilities)
M.my_capabilities.textDocument.completion.completionItem.snippetSupport = true

-- astro lsp setup
if not configs.astro_ls then
  -- local astro_ls_path = vim.loop.cwd() .. '/node_modules/@astrojs/language-server/bin/nodeServer.js'
  local cmd = { 'astro-ls', '--stdio' }
  configs.astro_ls = {
    default_config = {
      cmd = cmd,
      filetypes = { 'astro' },
      root_dir = lspconfig.util.find_node_modules_ancestor,
      settings = {},
    },
  }
  lspconfig.astro_ls.setup {
    cmd = cmd,
    on_attach = M.my_on_attach,
  }
end

-- setup language servers
-- TODO: add user commands similar to vim-go plugin
-- https://github.com/fatih/vim-go
local servers = {
  'bashls',
  'gopls',
  'html',
  'prismals',
  'pylsp',
  'svelte',
  'texlab',
  'vuels',
  'vimls',
  'yamlls',
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = M.my_on_attach,
    capabilities = M.my_capabilities,
  }
end

lspconfig.eslint.setup {
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = 'all',
    },
    format = true,
    nodePath = '',
    onIgnoredFiles = 'off',
    packageManager = 'npm',
    quiet = false,
    -- https://github.com/microsoft/vscode-eslint#settings-options
    -- rulesCustomizations lets me override Prettier suggestions to
    -- use a lower severity diagnostic (info)
    rulesCustomizations = {
      { rule = 'prettier*', severity = 'info' },
    },
    run = 'onType',
    useESLintClass = false,
    validate = 'on',
    workingDirectory = {
      mode = 'location',
    },
  },
}

--[[ lspconfig.tailwindcss.setup {
  capabilities = M.my_capabilities,
  on_attach = M.my_on_attach,
  root_dir = util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
} ]]

lspconfig.cssls.setup {
  filetypes = { 'css', 'scss' },
  capabilities = M.my_capabilities,
  on_attach = M.my_on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    css = {
      validate = false,
    },
  },
}

lspconfig.graphql.setup {
  filetypes = { 'graphql' },
  capabilities = M.my_capabilities,
  on_attach = M.my_on_attach,
}

lspconfig.tsserver.setup {
  filetypes = {
    'javascript',
    'typescript',
    'typescriptreact',
    'javascriptreact',
  },
  on_attach = function(client, bufnr)
    local has_ts_utils, ts_utils = pcall(require, 'nvim-lsp-ts-utils')
    if has_ts_utils then
      ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = true,

        -- import all
        import_all_timeout = 5000, -- ms
        -- lower numbers = higher priority
        import_all_priorities = {
          same_file = 1, -- add to existing import statement
          local_files = 2, -- git files or files with relative path markers
          buffer_content = 3, -- loaded buffer content
          buffers = 4, -- loaded buffer names
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,
        -- if false will avoid organizing imports
        always_organize_imports = true,

        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},

        -- inlay hints
        auto_inlay_hints = true,
        inlay_hints_highlight = 'Comment',
        inlay_hints_priority = 200, -- priority of the hint extmarks
        inlay_hints_throttle = 150, -- throttle the inlay hint request
        inlay_hints_format = { -- format options for individual hint kind
          Type = {},
          Parameter = {},
          Enum = {},
          -- Example format customization for `Type` kind:
          -- Type = {
          --     highlight = "Comment",
          --     text = function(text)
          --         return "->" .. text:sub(2)
          --     end,
          -- },
        },

        -- update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
      }

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)
    end
    M.my_on_attach(client, bufnr)
    -- disable tsserver from formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  flags = {
    debounce_text_changes = 150,
  },
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
  on_attach = M.my_on_attach,
  capabilities = M.my_capabilities,
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
local sumneko_root_path = vim.env.HOME .. '/builds/lua-language-server'
local system_name = vim.fn.has 'Linux' == 1 and 'Linux' or 'macOS'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local library_files = vim.api.nvim_get_runtime_file('', true)
-- add local nvim config to enable goto definitions, etc
table.insert(library_files, vim.env.XDG_CONFIG_HOME .. 'nvim/lua')
-- load hammerspoon runtime files if in dotfiles/hammerspoon/init.lua
if vim.fn.expand '%:p' == (vim.env.HOME .. '/dotfiles/hammerspoon/init.lua') then
  table.insert(library_files, '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')
end

local luadev = require('lua-dev').setup {
  library = {
    vimruntime = false,
    types = true,
    plugins = vim.loop.cwd():match(vim.env.HOME .. '/dotfiles/nvim') and true or false,
  },
  lspconfig = {
    on_attach = M.my_on_attach,
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        completion = {
          callSnippet = 'Disable',
          keywordSnippet = 'Disable',
        },
        diagnostics = {
          globals = {
            'awesome', -- awesomewm
            'spoon', -- hammerspoon
            'hs', -- hammerspoon
            'package', -- neovim
            'vim', -- neovim
            'describe', -- lua testing
            'it', -- lua testing
            'before_each', -- lua testing
            'after_each', -- lua testing
          },
          -- disable specific diagnostic messages
          disable = {
            'lowercase-global',
          },
        },
        workspace = {
          library = library_files,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
}
lspconfig.sumneko_lua.setup(luadev)

-- manage lsp diagnostics
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  virtual_lines = false,
  signs = true,
  update_in_insert = false,
}
vim.b.show_virtual_text = false

-- toggle diagnostics
M.toggle_diagnostics = function()
  if vim.b.show_virtual_text then
    vim.diagnostic.config {
      underline = false,
      virtual_text = false,
      virtual_lines = false,
      signs = true,
      update_in_insert = false,
    }
    vim.b.show_virtual_text = false
    vim.notify('Virtual Text off', 'info')
  else
    vim.diagnostic.config {
      underline = false,
      virtual_text = {
        severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR },
      },
      virtual_lines = true,
      signs = true,
      update_in_insert = false,
    }
    vim.b.show_virtual_text = true
    vim.notify('Virtual Text on', 'info')
  end
end
nnoremap('<leader>td', function()
  M.toggle_diagnostics()
end, nil, 'Toggle diagnostics')

-- lsp_lines plugin for diagnostics
-- local has_lsp_lines, lsp_lines = pcall(require, 'lsp_lines')
-- if has_lsp_lines then
--   lsp_lines.register_lsp_virtual_lines()
-- end

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
