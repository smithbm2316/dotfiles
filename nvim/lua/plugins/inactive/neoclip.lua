require('neoclip').setup({
  history = 500,
  filter = function(...)
    -- event, filetype, buffer_name params from neoclip
    local _, ft, buf_name = ...
    -- don't save yanks from .env files
    if ft == 'sh' and buf_name:match('.env') then
      return false
    else
      return true
    end
  end,
  preview = true,
  default_register = '"',
  content_spec_column = false,
  on_paste = {
    set_reg = false,
  },
  keys = {
    i = {
      select = '<cr>',
      paste = '<c-p>',
      paste_behind = '<c-k>',
    },
    n = {
      select = '<cr>',
      paste = 'p',
      paste_behind = 'P',
    },
  },
})
