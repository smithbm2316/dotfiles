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

local rustywind = {
  function()
    return {
      exe = 'rustywind',
      args = {
        '--stdin',
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      },
    }
  end,
}

local prettier_config = {
  function()
    return {
      exe = 'prettierd',
      args = {
        '--plugin-search-dir=.',
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      },
      stdin = true,
    }
  end,
}

local dprint_config = {
  function()
    local args = {
      'fmt',
    }
    local local_config = vim.fn.glob '.dprint.json'

    if local_config == '' then
      table.insert(args, '--config')
      table.insert(args, vim.env.XDG_CONFIG_HOME .. 'dprint/dprint.json')
    end

    return {
      exe = 'dprint',
      args = args,
      stdin = false,
    }
  end,
}

-- add a prettier_config for all js/ts/vue/svelte filetypes
for _, ft in pairs {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'html',
  'css',
  'astro',
  'json',
  'svelte',
  'vue',
} do
  filetype_configs[ft] = prettier_config
end

-- setup formatter
formatter.setup {
  log_level = vim.log.levels.WARN,
  filetype = filetype_configs,
}

-- call formatter.nvim automatically on save
create_augroup('AutoFormattingLua', {
  {
    events = 'BufWritePost',
    pattern = {
      '*.lua',
    },
    command = 'FormatWrite',
  },
})
create_augroup('AutoFormattingGolang', {
  {
    events = 'BufWritePre',
    pattern = {
      '*.go',
    },
    callback = function()
      vim.cmd 'GoImportAll'
      vim.lsp.buf.format { async = false }
    end,
  },
})
create_augroup('AutoFormattingWebDev', {
  {
    events = 'BufWritePost',
    pattern = {
      '*.js',
      '*.mjs',
      '*.cjs',
      '*.jsx',
      '*.ts',
      '*.tsx',
      '*.astro',
      '*.json',
      '*.jsonc',
      '*.svelte',
      '*.vue',
    },
    command = 'FormatWrite',
  },
})

-- toggle auto-formatting per language
nnoremap('<leader>tfw', function()
  _G.BS_toggle_augroup 'AutoFormattingWebDev'
end, 'Toggle auto-formatting WebDev')

nnoremap('<leader>tfl', function()
  _G.BS_toggle_augroup 'AutoFormattingLua'
end, 'Toggle auto-formatting Lua')

nnoremap('<leader>tfg', function()
  _G.BS_toggle_augroup 'AutoFormattingGolang'
end, 'Toggle auto-formatting Go')

-- if we are in a Deno project, don't use prettier for formatting
if vim.fn.glob('deno.json*'):len() > 0 then
  _G.BS_toggle_augroup 'AutoFormattingWebDev'
  create_augroup('AutoFormattingDeno', {
    {
      events = 'BufWritePre',
      pattern = {
        '*.js',
        '*.mjs',
        '*.cjs',
        '*.jsx',
        '*.ts',
        '*.tsx',
      },
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    },
  })
end

-- auto formatting for Prisma schema files
create_augroup('AutoFormattingPrisma', {
  {
    events = 'BufWritePre',
    pattern = {
      '*.prisma',
    },
    callback = function()
      vim.lsp.buf.format { async = false }
    end,
  },
})

-- auto formatting for JSON files
--[[
create_augroup('AutoFormattingJSON', {
  {
    events = 'BufWritePre',
    pattern = {
      '*.json',
      '*.jsonc',
    },
    callback = function()
      vim.lsp.buf.format { async = false }
    end,
  },
})
--]]
