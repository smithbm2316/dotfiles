require('copy_with_context').setup {
  -- Customize mappings
  mappings = {
    relative = '<leader>cp',
    absolute = '<leader>cP',
    remote = '<leader>cu',
  },
  formats = {
    default = '# {filepath}:{line}', -- Used by relative and absolute mappings
    remote = '# {remote_url}',
  },
  -- whether to trim lines or not
  trim_lines = false,
}
