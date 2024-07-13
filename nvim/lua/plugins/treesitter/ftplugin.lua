vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.html',
  },
  group = vim.api.nvim_create_augroup('DjangoTemplateFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-i>t', '{%  %}', 'template', 'middle')
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.ego',
    '*.ejs',
    '*.erb',
    '*.etlua',
  },
  group = vim.api.nvim_create_augroup(
    'EmbeddedTemplateFtCmds',
    { clear = true }
  ),
  callback = function()
    insert_at_cursor_map('<c-i>t', '<%  %>', 'template', 'middle')
    insert_at_cursor_map('<c-i>.', '<%  %>', 'template', 'middle')
    insert_at_cursor_map('<c-i>=', '<%=  %>', 'template', 'middle')
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.blade.php', '*.php' },
  group = vim.api.nvim_create_augroup('PhpFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-i>-', '->', 'php')
    insert_at_cursor_map('<c-i>.', '->', 'php')

    insert_at_cursor_map('<c-i>;', '::', 'php')
    insert_at_cursor_map('<c-i>c', '::class', 'php')

    insert_at_cursor_map('<c-i>=', '=>', 'php')

    insert_at_cursor_map('<c-i>v', '$', 'php')

    insert_at_cursor_map('<c-i>t', '$this->', 'php')
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.go', '*.templ' },
  group = vim.api.nvim_create_augroup('GoFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-i>=', ':=', 'go')
    insert_at_cursor_map('<c-i>;', ':=', 'go')
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'markdown' },
  group = vim.api.nvim_create_augroup('MarkdownFtCmds', { clear = true }),
  callback = function()
    vim.opt_local.conceallevel = 2
    -- vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 0
    vim.opt_local.wrap = true

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

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'man' },
  group = vim.api.nvim_create_augroup('ManFtCmds', { clear = true }),
  callback = function()
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 0
    vim.opt_local.wrap = true
    vim.opt_local.wrapmargin = 4
  end,
})
