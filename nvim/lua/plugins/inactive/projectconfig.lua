require'nvim-projectconfig'.load_project_config {
  project_dir = '~/dotfiles/nvim/projects/',
}

vim.cmd([[command! ProjectConfig lua require'nvim-projectconfig'.edit_project_config()]])
