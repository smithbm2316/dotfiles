return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  opts = {
    enable_autocmd = false,
    languages = {
      bash = '# %s',
      blade = '{-- %s --}',
      djangohtml = '{# %s #}',
      dosini = '# %s',
      ego = '<%# %s %>',
      ejs = '<%# %s %>',
      env = '# %s',
      erb = '<%# %s %>',
      etlua = '<%# %s %>',
      odin = '// %s',
      sh = '# %s',
      webc = '<!--- %s --->',
      zsh = '# %s',
    },
  },
  config = function(_, opts)
    require('ts_context_commentstring').setup(opts)

    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      -- if we have a custom override in our plugin config, then use that
      -- instead of what treesitter provides. this will allow us to use proper
      -- comments supported especially by html-template-engines if we are using
      -- treesitter to create a custom filetype that simply extends the html
      -- parser
      local ft = vim.api.nvim_buf_get_option(0, 'filetype')
      if vim.tbl_contains(vim.tbl_keys(opts.languages), ft) then
        return opts.languages[ft]
      end

      return option == 'commentstring'
          and require('ts_context_commentstring.internal').calculate_commentstring()
        or get_option(filetype, option)
    end

    vim.keymap.set({ 'n', 'x', 'o' }, 'cm', 'gc', { remap = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'cl', 'gc', { remap = true })
  end,
}
