-- manage DBs in vim
return {
  {
    'tpope/vim-dadbod',
    cmd = {
      'DB',
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = 'tpope/vim-dadbod',
    cmd = {
      'DB',
      'DBUI',
      'DBUIAddConnection',
      'DBUIClose',
      'DBUIFindBuffer',
      'DBUILasyQueryInfo',
      'DBUIRenameBuffer',
      'DBUIToggle',
    },
  },
}
