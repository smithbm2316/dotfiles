-- nvim-lua/completion.nvim
local has_completion = pcall(require, 'completion')
if has_completion then
  vim.g.completion_enable_auto_popup = 1
  vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
  vim.g.completion_trigger_keyword_length = 1
  vim.g.completion_enable_auto_hover = 1
  vim.g.completion_enable_auto_signature = 1
  vim.g.completion_matching_smart_case = 1
  vim.g.completion_trigger_on_delete = 0
  vim.g.completion_timer_cycle = 200
end

-- nvim-compe
local has_compe, compe = pcall(require, 'compe')
if has_compe then
  compe.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'disable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 80,
    max_kind_width = 100,
    max_menu_width = 80,
    documentation = true,
    source = {
      -- enabled
      nvim_lsp = {
        enable = true,
        priority = 10001,
      },
      path = true,
      buffer = true,
      -- disabled
      nvim_lua = false,
      calc = false,
      nvim_treesitter = false,
      tags = false,
      spell = false,
      emoji = false,
      omni = false,
      snippets_nvim = false,
      vsnip = false,
    },
  }
  vim.api.nvim_set_keymap('i', '<c-y>', 'compe#confirm("<c-y>")', { silent = true, noremap = true, expr = true })
  vim.api.nvim_set_keymap('i', '<c-e>', 'compe#close("<c-e>")', { silent = true, noremap = true, expr = true })
  vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { silent = true, noremap = true, expr = true })
  -- vim.cmd 'autocmd! CursorHoldI * lua vim.lsp.buf.hover()'
end
