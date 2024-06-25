-- extra text object for copy/pasting to the system clipboard, its soo good
return {
  'christoomey/vim-system-copy',
  event = 'VeryLazy',
  config = function()
    if vim.fn.has 'mac' == 1 then
      vim.g['system_copy#copy_command'] = 'pbcopy'
      vim.g['system_paste#paste_command'] = 'pbpaste'
    else
      if vim.env.XDG_SESSION_TYPE == 'wayland' then
        vim.g['system_copy#copy_command'] = 'wl-copy'
        vim.g['system_paste#paste_command'] = 'wl-paste'
      else
        vim.g['system_copy#copy_command'] = 'xclip -sel clipboard'
        vim.g['system_paste#paste_command'] = 'xclip -sel clipboard -o'
      end
    end
    vim.g['system_copy_silent'] = 1
  end,
}
