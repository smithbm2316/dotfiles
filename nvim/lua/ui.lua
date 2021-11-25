local ui = {}

local nui_input = require 'nui.input'
local event = require('nui.utils.autocmd').event

vim.ui.input = function(opts, on_confirm)
  local default_opts = {
    prompt = '> ',
    default = nil,
    completion = nil,
    highlight = nil,
  }

  local default_input_opts = {
    relative = 'editor',
    position = {
      row = '50%',
      col = '50%',
    },
    size = {
      width = 30,
      height = 1,
    },
    border = {
      style = 'double',
      highlight = 'FloatBorder',
      text = {
        top = '[Input]',
        top_align = 'center',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal',
    },
  }

  local input_opts = opts.input_opts and vim.tbl_deep_extend('keep', opts.input_opts, default_input_opts)
    or default_input_opts

  opts = opts and vim.tbl_extend('keep', opts, default_opts) or default_opts

  local input = nui_input(input_opts, {
    prompt = opts.prompt,
    default_value = '',
    on_submit = function(value)
      on_confirm(value)
    end,
  })

  -- launch input
  input:mount()

  -- mappings
  input:map('n', '<Esc>', input.input_props.on_close, { noremap = true })

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

-- execute an ex-command from an input popup
ui.command_mode = function()
  vim.ui.input({
    input_opts = {
      size = {
        width = 60,
      },
      border = {
        text = {
          top = '[execute ex-command]',
        },
      },
    },
  }, function(input)
    vim.cmd(input)
  end)
end
nnoremap('<leader>go', [[<cmd>lua require'ui'.command_mode()<cr>]])

-- print/vim.inspect the result of a lua or vimscript chunk
ui.dump_command = function(lang)
  vim.ui.input({
    input_opts = {
      size = {
        width = 60,
      },
      border = {
        text = {
          top = '[dump ' .. lang .. ']',
        },
      },
    },
  }, function(input)
    if lang == 'lua' then
      vim.cmd('lua print(vim.inspect(' .. input .. '))')
    else
      vim.cmd('echo ' .. input)
    end
  end)
end
nnoremap('<leader>dl', [[<cmd>lua require'ui'.dump_command('lua')<cr>]])
nnoremap('<leader>dv', [[<cmd>lua require'ui'.dump_command('vimL')<cr>]])

ui.open_float = function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  -- vim.api.nvim_buf_set_option(bufnr, 'buftype', 'prompt')
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'lua')
  local cols = vim.api.nvim_get_option 'columns'
  local lines = vim.api.nvim_get_option 'lines'

  local win_opts = {
    relative = 'editor',
    width = 40,
    height = 1,
    col = cols / 2 - 40 / 2,
    row = lines / 2 - 1,
    style = 'minimal',
    zindex = 50,
    focusable = true,
    border = 'double',
  }

  local winnr = vim.api.nvim_open_win(bufnr, true, win_opts)

  vim.fn.prompt_setcallback(bufnr, function(content)
    dump(content)
  end)

  local keymaps = {
    n = {
      ['<esc>'] = '<cmd>lua vim.api.nvim_win_close(' .. winnr .. ', true)<cr>',
    },
    i = {},
  }
  -- set buffer keymaps
  for mode, mapping in pairs(keymaps) do
    for lhs, rhs in pairs(mapping) do
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
    end
  end

  vim.cmd 'startinsert'
end
nnoremap('<leader>nf', [[<cmd>lua require'ui'.open_float()<cr>]])

return ui
