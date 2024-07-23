-- extra text object for copy/pasting to the system clipboard, its soo good
return {
  'christoomey/vim-system-copy',
  event = 'VeryLazy',
  config = function()
    vim.g['system_copy_silent'] = 1

    if vim.fn.has 'mac' == 1 then
      vim.g['system_copy#copy_command'] = 'pbcopy'
      vim.g['system_paste#paste_command'] = 'pbpaste'
      return
    end

    if vim.env.XDG_SESSION_TYPE == 'wayland' then
      vim.g['system_copy#copy_command'] = 'wl-copy'
      vim.g['system_paste#paste_command'] = 'wl-paste'
    elseif vim.env.XDG_SESSION_TYPE == 'x11' then
      vim.g['system_copy#copy_command'] = 'xclip -sel clipboard'
      vim.g['system_paste#paste_command'] = 'xclip -sel clipboard -o'
    else
      vim.notify(
        "Not in an x11 or wayland session, clipboard copying disabled.",
        vim.log.levels.WARN
      )
      vim.g['system_copy#copy_command'] = ''
      vim.g['system_paste#paste_command'] = ''
      vim.g['system_copy_silent'] = 0
      return
    end
  end,
}
