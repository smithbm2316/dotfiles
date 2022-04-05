-- if package.loaded['nvim-treesitter'] then
--   vim.api.nvim_exec(
--     [[TSBufDisable indent highlight incremental_selection textobjects.lsp_interop textobjects.swap textobjects.move textobjects.select context_commentstring textsubjects rainbow]],
--     false
--   )
-- end

vim.cmd 'syntax on'
vim.cmd 'set syntax=typescriptreact'
