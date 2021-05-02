vim.g.completion_enable_snippet = 'UltiSnips'
vim.g.completion_matching_smart_case = 1

vim.cmd [[ autocmd BufEnter * lua require'completion'.on_attach() ]]
