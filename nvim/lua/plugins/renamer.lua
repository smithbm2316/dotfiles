local mappings_utils = require 'renamer.mappings.utils'
require('renamer').setup {
  mappings = {
    ['<c-b>'] = mappings_utils.set_cursor_to_start,
    ['<c-e>'] = mappings_utils.set_cursor_to_end,
    ['<c-u>'] = mappings_utils.clear_line,
    ['<c-z>'] = mappings_utils.undo,
    ['<c-r>'] = mappings_utils.redo,
  },
}
nnoremap('<leader>rn', [[<cmd>lua require'renamer'.rename()<cr>]])
