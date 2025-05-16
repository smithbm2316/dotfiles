vim.api.nvim_create_autocmd({ 'BufRead' }, {
  pattern = { '*.mdx' },
  group = vim.api.nvim_create_augroup('MdxFtCmds', { clear = true }),
  callback = function()
    vim.bo.commentstring = '{{-- %s --}}'
    vim.bo.filetype = 'markdown'
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'markdown' },
  group = vim.api.nvim_create_augroup('MarkdownFtCmds', { clear = true }),
  callback = function()
    -- https://thoughtbot.com/blog/wrap-existing-text-at-80-characters-in-vim

    -- add a <c-u>[index] mapping to insert a new header at the cursor with the
    -- appropriate amount of hashtags preceding it for the heading level
    for _, i in ipairs { 1, 2, 3, 4, 5, 6 } do
      insert_at_cursor_map(
        string.format('<c-u>%d', i),
        string.rep('#', i) .. ' ',
        'md'
      )
    end

    set_tab_width(2, 'local')
    vim.opt_local.conceallevel = 0 -- 2

    -- https://www.reddit.com/r/neovim/comments/zmvk7j/comment/j0dsq99
    -- https://stackoverflow.com/a/50415982
    vim.opt_local.textwidth = 0
    vim.opt_local.wrapmargin = 80
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    -- vim.opt_local.columns = 80

    vim.keymap.set('n', '<leader>rl', [[<cmd>%s/^\(\s*\)\*/\1-/g<cr>]], {
      desc = '[R]eplace [l]ist bullets in markdown',
    })

    vim.cmd [[
      function! ScreenMovement(movement)
        if &wrap
          return "g" . a:movement
        else
          return a:movement
        endif
      endfunction
      augroup MarkdownMovement
        au!
        " remap regular commands
        au FileType markdown onoremap <silent> <expr> j ScreenMovement("j")
        au FileType markdown onoremap <silent> <expr> k ScreenMovement("k")
        au FileType markdown onoremap <silent> <expr> 0 ScreenMovement("0")
        au FileType markdown onoremap <silent> <expr> ^ ScreenMovement("^")
        au FileType markdown onoremap <silent> <expr> $ ScreenMovement("$")
        au FileType markdown nnoremap <silent> <expr> j ScreenMovement("j")
        au FileType markdown nnoremap <silent> <expr> k ScreenMovement("k")
        au FileType markdown nnoremap <silent> <expr> 0 ScreenMovement("0")
        au FileType markdown nnoremap <silent> <expr> ^ ScreenMovement("^")
        au FileType markdown nnoremap <silent> <expr> $ ScreenMovement("$")
      augroup END
    ]]
  end,
})
