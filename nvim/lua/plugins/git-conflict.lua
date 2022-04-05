local ok, git_conflict = pcall(require, 'git-conflict')
if not ok then
  return
end

git_conflict.setup {
  default_mappings = false,
  disable_diagnostics = false,
  highlights = {
    incoming = 'DiffText',
    current = 'DiffAdd',
  },
}

nnoremap('<leader>gco', '<Plug>(git-conflict-ours)', 'Git choose ours')
nnoremap('<leader>gct', '<Plug>(git-conflict-theirs)', 'Git choose theirs')
nnoremap('<leader>gcb', '<Plug>(git-conflict-both)', 'Git choose both')
nnoremap('<leader>gcn', '<Plug>(git-conflict-none)', 'Git choose ignore both')
nnoremap(']c', '<Plug>(git-conflict-next-conflict)', 'Jump to next git conflict')
nnoremap('[c', '<Plug>(git-conflict-prev-conflict)', 'Jump to previous git conflict')
