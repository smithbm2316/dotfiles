local has_renamer, renamer = pcall(require, 'renamer')

if has_renamer then
  local mappings_utils = require 'renamer.mappings.utils'
  renamer.setup {
    mappings = {
      ['<c-b>'] = mappings_utils.set_cursor_to_start,
      ['<c-e>'] = mappings_utils.set_cursor_to_end,
      ['<c-u>'] = mappings_utils.clear_line,
      ['<c-z>'] = mappings_utils.undo,
      ['<c-r>'] = mappings_utils.redo,
    },
  }
  nnoremap('<leader>rn', [[<cmd>lua require'renamer'.rename()<cr>]])
end
