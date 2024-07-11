local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
-- local configs = require 'lspconfig.configs'

-- functions to hook into
local M = {}

-- ~/.local/state/nvim/lsp.log
vim.lsp.set_log_level(vim.log.levels.WARN)

-- manage lsp diagnostics
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  virtual_lines = false,
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  update_in_insert = false,
  float = {
    header = 'Diagnostic',
    source = 'always',
    format = function(diagnostic)
      if diagnostic.code then
        return string.format('[%s]\n%s', diagnostic.code, diagnostic.message)
      else
        return diagnostic.message
      end
    end,
  },
}

-- toggle diagnostics
vim.keymap.set('n', '<leader>td', function()
  if vim.b.show_diagnostics then
    vim.diagnostic.hide()
    vim.b.show_diagnostics = false
  else
    vim.diagnostic.show()
    vim.b.show_diagnostics = true
  end
end, { desc = 'Toggle diagnostics' })

-- lsp renamer function that provides extra information
M.lsp_rename = function()
  local curr_name = vim.fn.expand '<cword>'
  vim.ui.input({
    prompt = 'LSP Rename: ',
    default = curr_name,
  }, function(new_name)
    if new_name then
      ---@diagnostic disable-next-line: missing-parameter
      local lsp_params = vim.lsp.util.make_position_params()

      if not new_name or #new_name == 0 or curr_name == new_name then
        return
      end

      -- request lsp rename
      lsp_params.newName = new_name
      vim.lsp.buf_request(
        0,
        'textDocument/rename',
        lsp_params,
        function(_, res, ctx, _)
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
              changed_instances_count = changed_instances_count
                + #changed_file.edits
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
            vim.log.levels.INFO
          )
        end
      )
    end
  end)
end

-- close signature_help on following events
vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'shadow',
    close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
  })
-- handle hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'shadow',
})

-- TODO: refactor the diagnostic keymaps and settings into its own module, it's
-- separate from LSP now
--
--- Go to a specific diagnostic message in a particular direction
---@param direction string value can be 'prev' or 'next', direction in which message to show
---@param shouldGoToAny? boolean if false (default), only go to errors and warnings, otherwise go to any message
function goto_diagnostic_msg(direction, shouldGoToAny)
  vim.diagnostic['goto_' .. direction] {
    float = true,
    wrap = true,
    severity = not shouldGoToAny and {
      min = vim.diagnostic.severity.WARN,
    } or nil,
  }
  vim.wo.linebreak = true
end

---
---@param _ any a reference to the lsp client
---@param bufnr number the buffer number
M.my_on_attach = function(_, bufnr)
  -- show hover
  vim.keymap.set(
    'n',
    'gh',
    vim.lsp.buf.hover,
    { desc = 'Hover lsp docs', buffer = bufnr }
  )

  -- signature help
  vim.keymap.set(
    { 'n', 'i' },
    '<c-s>',
    vim.lsp.buf.signature_help,
    { desc = 'Show lsp signature help', buffer = bufnr }
  )

  -- code action
  vim.keymap.set(
    'n',
    '<leader>ca',
    vim.lsp.buf.code_action,
    { desc = 'Lsp code action', buffer = bufnr }
  )

  -- rename symbol
  vim.keymap.set(
    'n',
    '<leader>rn',
    M.lsp_rename,
    { desc = 'Lsp rename symbol', buffer = bufnr }
  )

  -- lsp references
  vim.keymap.set('n', '<leader>lr', function()
    require('telescope.builtin').lsp_references()
  end, { desc = 'Show lsp references', buffer = bufnr })

  -- workspace symbols
  vim.keymap.set(
    'n',
    '<leader>ps',
    require('telescope.builtin').lsp_dynamic_workspace_symbols,
    { desc = 'Project symbols' }
  )

  -- lsp implementations
  vim.keymap.set(
    'n',
    '<leader>li',
    vim.lsp.buf.implementation,
    { desc = 'Go to lsp implementation', buffer = bufnr }
  )

  -- lsp symbols
  vim.keymap.set('n', '<leader>lsw', function()
    require('telescope.builtin').lsp_dynamic_workspace_symbols()
  end, { desc = 'Lsp workspace symbols', buffer = bufnr })
  vim.keymap.set('n', '<leader>lsd', function()
    require('telescope.builtin').lsp_dynamic_document_symbols()
  end, { desc = 'Lsp document symbols', buffer = bufnr })

  -- lsp diagnostics
  vim.keymap.set('n', '<leader>ldd', function()
    require('telescope.builtin').lsp_workspace_diagnostics()
  end, { desc = 'Lsp workspace diagnostics', buffer = bufnr })
  vim.keymap.set('n', '<leader>ldw', function()
    require('telescope.builtin').lsp_document_diagnostics()
  end, { desc = 'Lsp document diagnostics', buffer = bufnr })

  -- lsp definition
  vim.keymap.set('n', 'gd', function()
    require('telescope.builtin').lsp_definitions()
  end, { desc = 'Goto lsp definition', buffer = bufnr })
  vim.keymap.set(
    'n',
    'gD',
    vim.lsp.buf.definition,
    { desc = 'Goto lsp definition', buffer = bufnr }
  )

  -- lsp type definition
  vim.keymap.set(
    'n',
    'gt',
    vim.lsp.buf.type_definition,
    { desc = 'Goto lsp type definition', buffer = bufnr }
  )

  -- prev diagnostic
  vim.keymap.set('n', '<leader>dp', function()
    goto_diagnostic_msg 'prev'
  end, { desc = 'Previous diagnostic', buffer = bufnr })
  vim.keymap.set('n', '<leader>dP', function()
    goto_diagnostic_msg('prev', true)
  end, { desc = 'Previous diagnostic', buffer = bufnr })

  -- next diagnostic
  vim.keymap.set('n', '<leader>dn', function()
    goto_diagnostic_msg 'next'
  end, { desc = 'Next diagnostic', buffer = bufnr })
  vim.keymap.set('n', '<leader>dN', function()
    goto_diagnostic_msg('next', true)
  end, { desc = 'Next diagnostic', buffer = bufnr })

  -- show diagnostics on current line in floating window: hover diagnostics for line
  vim.keymap.set('n', '<leader>dh', function()
    vim.diagnostic.open_float { popup_bufnr_opts = { border = 'single' } }
  end, { desc = 'Hover diagnostic message', buffer = bufnr })

  -- define buffer-local variable for toggling diangostic buffer decorations
  ---@diagnostic disable-next-line: inject-field
  vim.b.show_diagnostics = true
end

M.my_capabilities = vim.tbl_deep_extend(
  'force',
  require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  }
)

local capabilities_without_formatting =
  vim.tbl_deep_extend('force', M.my_capabilities, {
    textDocument = {
      formatting = false,
      rangeFormatting = false,
    },
  })

-- setup language servers
local servers = {
  astro = {
    capabilities = capabilities_without_formatting,
    init_options = {
      typescript = {},
    },
  },
  bashls = {
    filetypes = { 'sh', 'bash', 'zsh' },
  },
  cssls = {
    init_options = {
      provideFormatter = true,
    },
    settings = {
      -- settings docs:
      -- https://code.visualstudio.com/Docs/languages/CSS#_customizing-css-scss-and-less-settings
      css = {
        completion = {
          completePropertyWithSemicolon = false,
          triggerPropertyValueCompletion = true,
        },
        format = {
          preserveNewLines = true,
          spaceAroundSelectorSeparator = true,
        },
        lint = {
          argumentsInColorFunction = 'error',
          compatibleVendorPrefixes = 'warning',
          duplicateProperties = 'warning',
          hexColorLength = 'error',
          propertyIgnoredDueToDisplay = 'warning',
          vendorPrefix = 'warning',
        },
        validate = true,
      },
    },
  },
  css_variables = {
    capabilities = capabilities_without_formatting,
    cssVariables = {
      lookupFiles = {
        '**/*.less',
        '**/*.scss',
        '**/*.sass',
        '**/*.css',
      },
      blacklistFolders = {
        '**/.cache',
        '**/.DS_Store',
        '**/.git',
        '**/.hg',
        '**/.next',
        '**/.svn',
        '**/bower_components',
        '**/CVS',
        '**/dist',
        '**/node_modules',
        '**/tests',
        '**/tmp',
        -- personal website build folder
        '**/www',
      },
    },
  },
  denols = {
    root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
    single_file_support = false,
    settings = {
      enabled = true,
      lint = true,
      unstable = false,
    },
  },
  emmet_language_server = {
    filetypes = _G.html_like_fts,
  },
  gopls = {
    settings = {
      gopls = {
        analyses = {
          httpresponse = true,
          loopclosure = true,
          nilfunc = true,
          nilness = true,
          printf = true,
          shadow = false,
          unusedparams = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        completeFunctionCalls = true,
        experimentalPostfixCompletions = true,
        matcher = 'Fuzzy',
        staticcheck = false,
        usePlaceholders = false,
      },
    },
  },
  graphql = {
    capabilities = capabilities_without_formatting,
  },
  html = {
    filetypes = _G.html_like_fts,
    single_file_support = false,
    init_options = {
      configurationSection = { 'html', 'css', 'javascript' },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = false,
    },
    settings = {
      css = {
        completion = {
          completePropertyWithSemicolon = false,
          triggerPropertyValueCompletion = true,
        },
        format = {
          preserveNewLines = true,
          spaceAroundSelectorSeparator = true,
        },
      },
    },
  },
  htmx = {
    capabilities = capabilities_without_formatting,
    filetypes = _G.html_like_fts,
    single_file_support = false,
    root_dir = util.root_pattern '.git',
    autostart = false,
  },
  jsonls = {
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
          '.prettierrc.js',
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
        url = 'https://json.schemastore.org/stylelintrc.json',
      },
      {
        fileMatch = {
          'deno.json',
          'deno.jsonc',
        },
        url = 'https://deno.land/x/deno/cli/schemas/config-file.v1.json',
      },
      {
        fileMatch = { 'composer.json' },
        url = 'https://getcomposer.org/schema.json',
      },
    },
  },
  pylsp = {
    capabilities = capabilities_without_formatting,
  },
  --[[ pyright = {
    capabilities = capabilities_without_formatting,
    disableOrganizeImports = false,
    analysis = {
      useLibraryCodeForTypes = true,
      autoSearchPaths = true,
      diagnosticMode = 'workspace',
      autoImportCompletions = true,
    },
  }, ]]
  --[[ sqls = {
    root_dir = util.root_pattern('.sqllsrc.json', 'package.json', '.git'),
  }, ]]
  tailwindcss = {
    capabilities = capabilities_without_formatting,
    filetypes = _G.html_like_fts,
    root_dir = util.root_pattern(
      'tailwind.config.js',
      'tailwind.config.cjs',
      'tailwind.config.ts'
    ),
    -- add support for custom languages
    -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/84#issuecomment-1128278248
    init_options = {
      userLanguages = {
        etlua = 'html',
        templ = 'html',
      },
    },
    settings = {
      tailwindCSS = {
        includeLanguages = {
          templ = 'html',
        },
        classAttributes = { 'class', 'className', 'class:list', 'classList' },
        codeActions = true,
        colorDecorators = true,
        emmetCompletions = false,
        hovers = true,
        rootFontSize = 16,
        showPixelEquivalents = true,
        suggestions = true,
        validate = true,
        lint = {
          cssConflict = 'warning',
          invalidApply = 'error',
          invalidScreen = 'error',
          invalidVariant = 'error',
          invalidConfigPath = 'error',
          invalidTailwindDirective = 'error',
          recommendedVariantOrder = 'warning',
        },
        experimental = {
          classRegex = {
            { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
          },
        },
      },
    },
  },
  templ = {
    -- use project-local templ if it exits, default to lspconfig global templ if not
    cmd = {
      exists_in_cwd './bin/templ' and './bin/templ' or 'templ',
      'lsp',
    },
  },
  vimls = {},
  -- vtsls = {},
}

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend('force', {
    on_attach = M.my_on_attach,
    capabilities = M.my_capabilities,
  }, config))
end

lspconfig.intelephense.setup {
  on_attach = function(client, bufnr)
    M.my_on_attach(client, bufnr)

    -- in order to get intelephense to index blade files properly, it needs to
    -- think the filetype is `php` at first so that it kicks off the correct
    -- processes and provides completion to us. so we can get a bit tricky
    -- and check each time that we attach intelephense to a buffer if it's a
    -- blade file, and if it is, set our filetype to blade after it's been
    -- attached. that way we get proper syntax highlighting *AND* we get
    -- auto-completion from intelephense, since for our purposes blade files
    -- are just php files
    if vim.api.nvim_buf_get_name(0):match '%.blade%.php$' ~= nil then
      vim.defer_fn(function()
        vim.cmd 'set ft=blade'
      end, 500)
    end
  end,
  capabilities = capabilities_without_formatting,
  filetypes = { 'blade', 'php' },
}

local null_ok, null_ls = pcall(require, 'null-ls')
if null_ok then
  null_ls.setup {
    on_attach = M.my_on_attach,
    capabilities = M.my_capabilities,
    sources = {
      -- code actions
      null_ls.builtins.code_actions.eslint.with {
        condition = function(utils)
          return utils.root_has_file {
            'eslint.config.js',
            'eslint.config.cjs',
            'eslint.config.mjs',
            '.eslintrc',
            '.eslintrc.cjs',
            '.eslintrc.js',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
          }
        end,
      },
      -- diagnostics
      null_ls.builtins.diagnostics.eslint.with {
        condition = function(utils)
          return utils.root_has_file {
            'eslint.config.js',
            'eslint.config.cjs',
            'eslint.config.mjs',
            '.eslintrc',
            '.eslintrc.cjs',
            '.eslintrc.js',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
          }
        end,
      },
      null_ls.builtins.diagnostics.djlint.with {
        filetypes = {
          'django',
          'htmldjango',
          'jinja.html',
          'liquid',
          'nunjucks',
        },
      },
      -- use `write-good` prose linter in markdown
      -- null_ls.builtins.diagnostics.write_good,
      -- formatting
      null_ls.builtins.formatting.djlint.with {
        filetypes = {
          'django',
          'htmldjango',
          'jinja.html',
          'liquid',
          'nunjucks',
        },
      },
      -- python
      null_ls.builtins.formatting.blue,
      -- php
      -- formatter for blade templates
      --[[ null_ls.builtins.formatting.blade_formatter.with {
        prefer_local = './node_modules/.bin',
        filetypes = { 'blade', 'php' },
        -- only enable if it's a blade file
        runtime_condition = function(params)
          return vim.api.nvim_buf_get_name(0):match '%.blade%.php$' ~= nil
        end,
      }, ]]
      -- format php files with Laravel's pint package
      null_ls.builtins.formatting.pint.with {
        filetypes = { 'blade', 'php' },
      },
      null_ls.builtins.formatting.fixjson,
      null_ls.builtins.formatting.prettier.with {
        prefer_local = './node_modules/.bin',
        filetypes = {
          'css',
          'sass',
          'scss',
          'graphql',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'yaml',
        },
        extra_args = { '--plugin-search-dir', '.' },
      },
      null_ls.builtins.formatting.stylua.with {
        filetypes = { 'lua', 'luau', 'tl' },
      },
    },
  }
  create_augroup('AutoFormatting', {
    {
      events = 'BufWritePre',
      pattern = {
        '*.astro',
        '*.bash',
        '*.cjs',
        '*.css',
        '*.go',
        '*.html',
        '*.js',
        '*.json',
        '*.jsonc',
        '*.jsx',
        '*.liquid',
        '*.lua',
        '*.mjs',
        '*.njk',
        '*.php',
        '*.py',
        '*.rockspec',
        '*.rs',
        '*.sass',
        '*.schema',
        '*.scss',
        '*.sh',
        '*.templ',
        '*.tl',
        '*.ts',
        '*.tsx',
        '*.zsh',
      },
      callback = function()
        vim.lsp.buf.format {
          async = false,
          filter = function(client)
            --- the current filetype
            --- @type string
            local ft = vim.api.nvim_buf_get_option(0, 'filetype')
            --- keys in the table represent filetypes, values represent the name of LSP servers
            local ft_lsp_map = {
              astro = 'astro',
              html = 'html',
              go = 'gopls',
              templ = 'templ',
            }

            -- exit early if the given LSP doesn't support formatting
            if not client.supports_method 'textDocument/formatting' then
              return false
            end

            -- if our LSP client's name is valid for the current filetype, we
            -- can use that LSP's formatter
            if ft_lsp_map[ft] == client.name then
              return true
            -- if `null-ls` is the current formatter, then great you can use that!
            elseif client.name == 'null-ls' then
              return true
            -- only format the document with cssls if we're in a PHP project
            elseif
              client.name == 'cssls'
              and (ft == 'css' or ft == 'scss')
              and util.root_pattern 'composer.json'(
                  vim.api.nvim_buf_get_name(0)
                )
                ~= nil
            then
              return true
            else
              return false
            end
          end,
          timeout_ms = 5000,
        }
      end,
    },
  })
  vim.keymap.set('n', '<leader>tf', function()
    toggle_augroup 'AutoFormatting'
  end, { desc = 'Toggle auto-formatting' })
end

require('typescript-tools').setup {
  on_attach = M.my_on_attach,
  filetypes = {
    'javascript',
    'typescript',
    'typescriptreact',
    'javascriptreact',
  },
  capabilities = capabilities_without_formatting,
  -- ignore specific tsserver errors
  handlers = {
    ['textDocument/publishDiagnostics'] = require('typescript-tools.api').filter_diagnostics {
      -- ignore "file may be converted to from a commonjs module to an es module" error
      -- https://stackoverflow.com/a/70294761/15089697
      80001,
      -- ignore "Could not find a declaration file for module ..." error
      7016,
    },
  },
  root_dir = util.root_pattern 'package.json',
  settings = {
    ---@type string|string[] array of strings("fix_all"|"add_missing_imports"|
    --- "remove_unused"|"remove_unused_imports"|"organize_imports") -- or
    --- string "all" to include all supported code actions
    expose_as_code_action = 'all',
    -- https://github.com/pmizio/typescript-tools.nvim/issues/135#issuecomment-1680768637
    ---@type string|nil - specify a custom path to `tsserver.js` file, if this
    --- is nil or file under path - not exists then standard path resolution
    --- strategy is applied
    tsserver_path = vim.env.HOME
      .. '/.volta/tools/image/packages/typescript/lib/node_modules/typescript/lib/tsserver.js',
  },
}

-- disable diangostics for .etlua files. unfortunately we have to do it via
-- the lua_ls settings, not just with vim.diagnostic.enable(false, { bufnr = 0 })
-- i dunno why
-- local group_id =
--   vim.api.nvim_create_augroup('LuaLsDiagnosticsToggler', { clear = true })
-- vim.api.nvim_create_autocmd({ 'LspAttach', 'BufEnter' }, {
--   -- pattern = { '*.lua', '*.tl', '*.luau', '*.etlua' },
--   pattern = { '*.etlua' },
--   group = group_id,
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local attached_lsps = vim.lsp.get_clients {
--       bufnr = bufnr,
--       name = 'lua_ls',
--     }
--     if attached_lsps[1] == nil then
--       return
--     end
--
--     local client = attached_lsps[1]
--     local ns_id = vim.lsp.diagnostic.get_namespace(client.id)
--
--     if client.config.settings.Lua.diagnostics.enable == false then
--       return
--     end
--
--     vim.diagnostic.reset(ns_id, bufnr)
--     client.config.settings.Lua.diagnostics.enable = false
--     client.notify(
--       'workspace/didChangeConfiguration',
--       { settings = client.config.settings }
--     )
--   end,
-- })
-- vim.api.nvim_create_autocmd({ 'LspAttach', 'BufEnter' }, {
--   pattern = { '*.lua', '*.tl', '*.luau' },
--   group = group_id,
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local attached_lsps = vim.lsp.get_clients {
--       bufnr = bufnr,
--       name = 'lua_ls',
--     }
--     if attached_lsps[1] == nil then
--       return
--     end
--
--     local client = attached_lsps[1]
--     if client.config.settings.Lua.diagnostics.enable == true then
--       return
--     end
--
--     client.config.settings.Lua.diagnostics.enable = true
--     client.notify(
--       'workspace/didChangeConfiguration',
--       { settings = client.config.settings }
--     )
--   end,
-- })

lspconfig.lua_ls.setup {
  on_attach = M.my_on_attach,
  capabilities = M.my_capabilities,
  cmd = { 'lua-language-server' },
  filetypes = {
    'lua',
    'tl',
    'luau',
    -- 'etlua'
  },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Disable',
        keywordSnippet = 'Disable',
      },
      diagnostics = {
        enable = true,
        -- disable specific diagnostic messages
        disableScheme = { '.etlua' },
        disable = {
          'inject-field',
          'lowercase-global',
        },
        --[[ severity = {
          ['inject-field'] = 'Hint',
        }, ]]
      },
      workspace = {
        -- https://www.reddit.com/r/neovim/comments/wgu8dx/configuring_neovim_for_l%C3%B6velua_i_always_get/ij22yo9/
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local rt_ok, rt = pcall(require, 'rust-tools')
if rt_ok then
  rt.setup {
    server = {
      on_attach = M.my_on_attach,
      capabilities = M.my_capabilities,
      settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ['rust-analyzer'] = {
          -- enable clippy on save
          checkOnSave = {
            command = 'clippy',
            enable = true,
          },
        },
      },
    },
  }
  -- enable inlay hints
  rt.inlay_hints.enable()
end

-- define signcolumn lsp diagnostic icons
-- define diagnostic icons/highlights for signcolumn and other stuff
local define_icon = function(long_name, short_name, icon)
  vim.fn.sign_define('DiagnosticSign' .. short_name, {
    text = icon,
    texthl = 'Diagnostic' .. short_name,
    linehl = '',
    numhl = '',
  })

  vim.fn.sign_define('LspDiagnosticsSign' .. long_name, {
    text = icon,
    texthl = 'LspDiagnosticsSign' .. long_name,
    linehl = '',
    numhl = '',
  })
end

define_icon('Error', 'Error', _G.diagnostic_icons.error)
define_icon('Warning', 'Warn', _G.diagnostic_icons.warn)
define_icon('Information', 'Info', _G.diagnostic_icons.info)
define_icon('Hint', 'Hint', _G.diagnostic_icons.hint)

return M
