require('nvim-autopairs').setup({
	html_break_line_filetype = {
		'html',
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
		'svelte',
		'vue',
	},
  break_line_filetype = nil,
})

-- skip it, if you use another global object
local npairs = require('nvim-autopairs')
_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      vim.fn["compe#confirm"]()
      return npairs.esc("<c-y>")
    else
      vim.defer_fn(function()
        vim.fn["compe#confirm"]("<cr>")
      end, 20)
      return npairs.esc("<c-n>")
    end
  else
    return npairs.check_break_line_char()
  end
end

vim.api.nvim_set_keymap('i' , '<cr>', 'v:lua.MUtils.completion_confirm()', { expr = true, noremap = true })
