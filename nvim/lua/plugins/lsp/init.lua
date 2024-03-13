local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local configs = require 'lspconfig.configs'

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
nnoremap('<leader>td', function()
  if vim.b.show_diagnostics then
    vim.diagnostic.hide()
    vim.b.show_diagnostics = false
  else
    vim.diagnostic.show()
    vim.b.show_diagnostics = true
  end
end, nil, 'Toggle diagnostics')

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
          vim.log.levels.INFO
        )
      end)
    end
  end)
end

-- close signature_help on following events
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'shadow',
  close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
})
-- handle hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'shadow',
})

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

M.my_on_attach = function(client, bufnr)
  local bufnr_opts = { buffer = bufnr }

  -- show hover
  nnoremap('gh', function()
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

  -- lsp implementations
  nnoremap('<leader>li', function()
    vim.lsp.buf.implementation()
  end, 'Go to lsp implementation', bufnr_opts)

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
  nnoremap('gd', function()
    require('telescope.builtin').lsp_definitions()
  end, 'Goto lsp definition', bufnr_opts)
  nnoremap('gD', function()
    vim.lsp.buf.definition()
  end, 'Goto lsp definition', bufnr_opts)

  -- lsp type definition
  nnoremap('gt', function()
    vim.lsp.buf.type_definition()
  end, 'Goto lsp type definition', bufnr_opts)

  -- prev diagnostic
  nnoremap('<leader>dp', function()
    goto_diagnostic_msg 'prev'
  end, 'Previous diagnostic', bufnr_opts)
  nnoremap('<leader>dP', function()
    goto_diagnostic_msg('prev', true)
  end, 'Previous diagnostic', bufnr_opts)

  -- next diagnostic
  nnoremap('<leader>dn', function()
    goto_diagnostic_msg 'next'
  end, 'Next diagnostic', bufnr_opts)
  nnoremap('<leader>dN', function()
    goto_diagnostic_msg('next', true)
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
      require('goto-preview').goto_preview_implementation {}
    end, 'Preview lsp implementations', bufnr_opts)
    nnoremap('<leader>pd', function()
      require('goto-preview').goto_preview_definition {}
    end, 'Preview lsp definition', bufnr_opts)
    nnoremap('<leader>pt', function()
      require('goto-preview').goto_preview_type_definition {}
    end, 'Preview type definition', bufnr_opts)
  end

  -- define buffer-local variable for toggling diangostic buffer decorations
  vim.b.show_diagnostics = true
end

M.my_capabilities = vim.lsp.protocol.make_client_capabilities()
M.my_capabilities = require('cmp_nvim_lsp').default_capabilities(M.my_capabilities)
M.my_capabilities.textDocument.completion.completionItem.snippetSupport = true

---Returns a custom data file parsed as JSON into a lua table
---@param file_path string
---@return CustomDataFile
local function parse_file_to_json(file_path)
  local file = assert(io.open(file_path, 'r'))
  local data = file:read '*a' --[[@as string]]
  local json_data = vim.json.decode(data) --[[@as CustomDataFile]]
  file:close()
  return json_data
end

-- directory for HTML custom data JSON files
--[[ ---@diagnostic disable-next-line: param-type-mismatch
local custom_data_file_paths = vim.fn.globpath('~/dotfiles/nvim/htmlCustomData', '*.json', false, true)

local html_custom_data_files_parsed = {}
---@diagnostic disable-next-line: param-type-mismatch
for _, file_path in ipairs(custom_data_file_paths) do
  table.insert(html_custom_data_files_parsed, parse_file_to_json(file_path))
end ]]

-- stylua: ignore start
--[[ local cssCustomData = vim.split(
  vim.fn.globpath(vim.fn.getcwd(), '.vscode/**/*.css-data.json'),
  '\n'
)
local htmlCustomDataFilepaths = vim.split(
  vim.fn.globpath(vim.fn.getcwd(), '.vscode/**/*.html-data.json'),
  '\n'
) ]]

-- local htmlCustomData = {}
-- for _, file_path in ipairs(htmlCustomDataFilepaths) do
--   local file = assert(io.open(file_path, 'r'))
--   local data = file:read '*a' --[[@as string]]
--   local json_data = vim.json.decode(data)
--   file:close()
--
--   table.insert(htmlCustomData, json_data)
-- end
-- stylua: ignore end

-- setup language servers
local servers = {
  cssls = {
    -- disable diagnostics for cssls, i just want the autocompletion
    --[[ handlers = {
      ['textDocument/publishDiagnostics'] = function(...) end,
    }, ]]
    -- filetypes = { 'css', 'scss', 'less', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
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
        -- customData = cssCustomData,
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
  denols = {
    root_dir = function(filename, bufnr)
      local first_line_arr = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
      if #first_line_arr > 0 and first_line_arr[1]:match '#!.*/usr/bin/env.*deno' ~= nil then
        return vim.fn.getcwd()
      end
      return util.root_pattern('deno.json', 'deno.jsonc')(filename)
    end,
    single_file_support = false,
    settings = {
      enabled = true,
      lint = true,
      unstable = false,
    },
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
        usePlaceholders = true,
      },
    },
    commands = {
      -- imports all packages used but not defined into the file
      GoImportAll = {
        function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { 'source.organizeImports' } }
          ---@diagnostic disable-next-line: param-type-mismatch
          local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, 'UTF-8')
              else
                vim.lsp.buf.execute_command(r.command)
              end
            end
          end
        end,
        description = 'Import all used packages into the file',
      },
    },
  },
  graphql = {
    filetypes = { 'graphql' },
  },
  html = {
    --[[ cmd = {
      'node',
      '/home/smithbm/code/vscode-extension-samples/lsp-embedded-language-service/server/out/server.js',
      '--stdio',
    }, ]]
    capabilities = vim.tbl_deep_extend('force', M.my_capabilities, {
      textDocument = {
        formatting = true,
        rangeFormatting = true,
      },
    }),
    filetypes = {
      'html',
      'django',
      'htmldjango',
      'jinja',
      'jinja.html',
      'liquid',
      'nunjucks',
      'templ',
      'webc',
    },
    single_file_support = false,
    init_options = {
      -- dataPaths = htmlCustomDataFilepaths,
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
    filetypes = {
      'astro',
      'html',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'templ',
      'tmpl',
    },
    single_file_support = false,
    root_dir = util.root_pattern 'package.json',
    autostart = false,
  },
  phpactor = {
    capabilities = vim.tbl_deep_extend('force', M.my_capabilities, {
      textDocument = {
        formatting = false,
        rangeFormatting = false,
      },
    }),
  },
  pyright = {
    disableOrganizeImports = false,
    analysis = {
      useLibraryCodeForTypes = true,
      autoSearchPaths = true,
      diagnosticMode = 'workspace',
      autoImportCompletions = true,
    },
  },
  --[[ sqls = {
    root_dir = util.root_pattern('.sqllsrc.json', 'package.json', '.git'),
  }, ]]
  tailwindcss = {
    autostart = true,
    filetypes = {
      'astro',
      'astro-markdown',
      'gohtml',
      'gohtmltmpl',
      'html',
      'django',
      'htmldjango',
      -- 'jinja.html',
      'nunjucks',
      'liquid',
      'markdown',
      'mdx',
      'css',
      'less',
      'postcss',
      'sass',
      'scss',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'templ',
      'webc',
    },
    root_dir = util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts'),
    -- add support for custom languages
    -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/84#issuecomment-1128278248
    init_options = {
      userLanguages = {
        templ = 'html',
        webc = 'html',
      },
    },
    settings = {
      tailwindCSS = {
        includeLanguages = {
          templ = 'html',
          webc = 'html',
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
      util.path.exists './bin/templ' and './bin/templ' or 'templ',
      'lsp',
    },
  },
  vimls = {},
}

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend('force', {
    on_attach = M.my_on_attach,
    capabilities = M.my_capabilities,
  }, config))
end

lspconfig.bashls.setup {
  on_attach = function(client, bufnr)
    -- if we are in a .env/.env.* file, don't load bashls
    if client.name == 'bashls' then
      if vim.api.nvim_buf_get_name(bufnr):match '%.env.*$' ~= nil then
        -- vim.lsp.buf_detach_client(bufnr, client.id)
        client.stop()
        return
      end
    end

    M.my_on_attach(client, bufnr)
  end,
  capabilities = M.my_capabilities,
}

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    -- if the buffer is a cypress test, then don't attach eslint
    if client.name == 'eslint' then
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if vim.regex([[cypress\/.*\.[tj]sx\?]]):match_str(bufname) ~= nil then
        vim.lsp.buf_detach_client(bufnr, client.id)
        return
      end
    end

    M.my_on_attach(client, bufnr)
  end,
  capabilities = M.my_capabilities,
  autostart = true,
  filetypes = { 'astro', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(filename, bufnr)
    local first_line_arr = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
    if
      (#first_line_arr > 0 and first_line_arr[1]:match '#!.*/usr/bin/env.*deno' ~= nil)
      or util.root_pattern('deno.json', 'deno.jsonc')(filename)
    then
      return nil
    end
    return util.root_pattern(
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      '.eslintrc.json',
      'eslint.config.js'
      -- 'package.json',
    )(filename)
  end,
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
    experimental = {
      useFlatConfig = true,
    },
    format = true,
    nodePath = '',
    onIgnoredFiles = 'off',
    -- packageManager = 'npm',
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

local null_ok, null_ls = pcall(require, 'null-ls')
if null_ok then
  null_ls.setup {
    on_attach = M.my_on_attach,
    capabilities = M.my_capabilities,
    sources = {
      -- code actions
      -- null_ls.builtins.code_actions.eslint,
      -- null_ls.builtins.code_actions.gitsigns,
      -- null_ls.builtins.code_actions.proselint,
      --[[ null_ls.builtins.code_actions.shellcheck.with {
        condition = function()
          return vim.api.nvim_buf_get_name(0):match '%.env.*$' == nil
        end,
      }, ]]
      -- completion
      -- diagnostics
      -- null_ls.builtins.diagnostics.eslint,
      -- null_ls.builtins.diagnostics.luacheck,
      -- null_ls.builtins.diagnostics.proselint,
      --[[ null_ls.builtins.diagnostics.shellcheck.with {
        condition = function()
          return vim.api.nvim_buf_get_name(0):match '%.env.*$' == nil
        end,
      }, ]]
      -- null_ls.builtins.diagnostics.stylelint,
      -- null_ls.builtins.diagnostics.teal,
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
      null_ls.builtins.diagnostics.write_good,
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
      null_ls.builtins.formatting.deno_fmt,
      null_ls.builtins.formatting.gofmt.with {
        extra_args = { '-s' },
      },
      -- python
      null_ls.builtins.formatting.blue,
      -- php
      null_ls.builtins.formatting.blade_formatter, -- formatter for blade templates
      null_ls.builtins.formatting.pint, -- comes with laravel
      -- null_ls.builtins.formatting.phpcsfixer,
      -- null_ls.builtins.formatting.eslint,
      null_ls.builtins.formatting.fixjson,
      null_ls.builtins.formatting.prettier.with {
        -- extra_filetypes = { 'webc' },
        condition = function(utils)
          return not utils.root_has_file { 'deno.json', 'deno.jsonc' }
        end,
        extra_args = { '--plugin-search-dir', '.' },
      },
      null_ls.builtins.formatting.stylelint,
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
        '*.cjs',
        '*.js',
        '*.mjs',
        '*.ts',
        '*.jsx',
        '*.tsx',
        '*.json',
        '*.jsonc',
        '*.css',
        '*.sass',
        '*.scss',
        '*.lua',
        '*.tl',
        '*.go',
        '*.bash',
        '*.sh',
        '*.zsh',
        '*.schema',
        '*.rs',
        '*.py',
        '*.php',
        '*.webc',
        '*.njk',
        '*.liquid',
        '*.templ',
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
              webc = 'html',
            }

            -- exit early if the given LSP doesn't support formatting
            if not client.supports_method 'textDocument/formatting' then
              return false
            end

            -- if our LSP client's name is valid for the current filetype, we can use that LSP's formatter
            if ft_lsp_map[ft] == client.name then
              return true
            -- if `null-ls` is the current formatter, then great you can use that!
            elseif client.name == 'null-ls' then
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
  nnoremap('<leader>tf', function()
    toggle_augroup 'AutoFormatting'
  end, 'Toggle auto-formatting')
end

-- https://github.com/antonk52/cssmodules-language-server
lspconfig.cssmodules_ls.setup {
  on_attach = function(client, bufnr)
    -- avoid accepting `definitionProvider` responses from this LSP
    client.server_capabilities.definitionProvider = false
    M.my_on_attach(client, bufnr)
  end,
  capabilities = M.my_capabilities,
  init_options = {
    camelCase = true,
  },
  autostart = false,
}

lspconfig.astro.setup {
  on_attach = M.my_on_attach,
  capabilities = vim.tbl_deep_extend('force', M.my_capabilities, {
    textDocument = {
      formatting = false,
      rangeFormatting = false,
    },
  }),
  filetypes = { 'astro' },
  init_options = {
    typescript = {},
  },
  autostart = true,
}

local ts_tools_ok, ts_tools = pcall(require, 'typescript-tools')
if ts_tools_ok then
  -- disable formatting for tsserver
  local custom_capabilities = {
    textDocument = {
      formatting = false,
      rangeFormatting = false,
    },
  }
  vim.tbl_deep_extend('force', M.my_capabilities, custom_capabilities)

  ts_tools.setup {
    on_attach = M.my_on_attach,
    filetypes = {
      'javascript',
      'typescript',
      'typescriptreact',
      'javascriptreact',
      -- 'webc',
    },
    capabilities = custom_capabilities,
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
    root_dir = function(filename, bufnr)
      local first_line_arr = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
      if
        (#first_line_arr > 0 and first_line_arr[1]:match '#!.*/usr/bin/env.*deno' ~= nil)
        or util.root_pattern('deno.json', 'deno.jsonc')(filename)
      then
        return nil
      end
      return util.root_pattern('package.json', 'tsconfig.json')(filename)
    end,
    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = 'insert_leave',
      -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
      -- specify commands exposed as code_actions
      expose_as_code_action = { 'add_missing_imports', 'remove_unused', 'fix_all' },
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = 'auto',
      -- described below
      tsserver_format_options = {},
      tsserver_file_preferences = {},
      -- locale of all tsserver messages, supported locales you can find here:
      -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
      tsserver_locale = 'en',
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = false,
      include_completions_with_insert_text = true,
      -- CodeLens
      -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
      -- possible values: ("off"|"all"|"implementations_only"|"references_only")
      code_lens = 'off',
      -- by default code lenses are displayed on all referencable values and for some of you it can
      -- be too much this option reduce count of them by removing member references from lenses
      disable_member_code_lens = true,
      -- JSXCloseTag
      -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
      -- that maybe have a conflict if enable this feature. )
      jsx_close_tag = {
        enable = false,
        filetypes = { 'javascriptreact', 'typescriptreact' },
      },
    },
  }
end

--[[ lspconfig.tsserver.setup {
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
        filter_out_diagnostics_by_code = {
          80001, -- https://stackoverflow.com/a/70294761/15089697
          7016,
        },

        -- inlay hints
        auto_inlay_hints = true,
        inlay_hints_highlight = 'Comment',
        inlay_hints_priority = 200, -- priority of the hint extmarks
        inlay_hints_throttle = 150, -- throttle the inlay hint request
        inlay_hints_format = {
          -- format options for individual hint kind
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
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
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
  root_dir = function(filename, bufnr)
    local first_line_arr = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
    if
      (#first_line_arr > 0 and first_line_arr[1]:match '#!.*/usr/bin/env.*deno' ~= nil)
      or util.root_pattern('deno.json', 'deno.jsonc')(filename)
    then
      return nil
    end
    return util.root_pattern('package.json', 'tsconfig.json')(filename)
  end,
  single_file_support = false,
} ]]

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
            '.prettierrc.js',
            '.prettierrc.json',
            'prettier.config.json',
          },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        {
          fileMatch = { '.eslintrc', '.eslintrc.json', '.eslintrc.js' },
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
        {
          fileMatch = {
            'deno.json',
            'deno.jsonc',
          },
          url = 'https://deno.land/x/deno/cli/schemas/config-file.v1.json',
        },
      },
    },
  },
}

---@diagnostic disable-next-line: missing-parameter
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local library_files = vim.api.nvim_get_runtime_file('', true)
-- add local nvim config to enable goto definitions, etc
table.insert(library_files, vim.env.XDG_CONFIG_HOME .. 'nvim/lua')

-- load hammerspoon runtime files if in dotfiles/hammerspoon/init.lua and on OSX
if vim.fn.has 'mac' == 1 and vim.fn.expand '%:p' == (vim.env.HOME .. '/dotfiles/hammerspoon/init.lua') then
  table.insert(library_files, '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')
end

local neodev_ok, neodev = pcall(require, 'neodev')
if not neodev_ok then
  return
end

local cwd = vim.fn.getcwd()

neodev.setup {
  library = {
    enabled = true,
    runtime = true,
    types = cwd:match(vim.env.HOME .. '/dotfiles/nvim') ~= nil,
    plugins = true,
  },
  setup_jsonls = true,
  pathStrict = true,
}

--[[
local testing_globals = {
  'describe',
  'it',
  'before_each',
  'after_each',
}
--]]
local lua_globals = {}

if cwd:match(vim.env.HOME .. '/dotfiles/awesome') then
  lua_globals = {
    'awesome',
    'client',
    'mouse',
    'root',
    'screen',
    'love',
  }
elseif cwd:match(vim.env.HOME .. '/dotfiles/hammerspoon') then
  lua_globals = {
    'hs',
    'spoon',
  }
elseif cwd:match(vim.env.HOME .. '/dotfiles/nvim') then
  lua_globals = {
    'package',
    'vim',
  }
end

lspconfig.lua_ls.setup {
  on_attach = M.my_on_attach,
  cmd = { 'lua-language-server' },
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
        globals = lua_globals,
        -- disable specific diagnostic messages
        disable = {
          'lowercase-global',
        },
      },
      workspace = {
        -- https://www.reddit.com/r/neovim/comments/wgu8dx/configuring_neovim_for_l%C3%B6velua_i_always_get/ij22yo9/
        checkThirdParty = false,
        library = library_files,
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

lspconfig.emmet_language_server.setup {
  filetypes = { 'html', 'javascriptreact', 'typescriptreact', 'webc' },
  -- **Note:** only the options listed in the table are supported.
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = 'always',
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = true,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
}

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
