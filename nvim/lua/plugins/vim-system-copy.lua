if vim.fn.has('mac') == 1 then
  vim.g['system_copy#copy_command'] = 'pbcopy'
  vim.g['system_paste#paste_command'] = 'pbpaste'
else
  vim.g['system_copy#copy_command'] = 'xclip -sel clipboard'
  vim.g['system_paste#paste_command'] = 'xclip -sel clipboard -o'
end
vim.g['system_copy_silent'] = 1
