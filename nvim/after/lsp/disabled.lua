local disabled_servers = {
  emmet_language_server = {
    filetypes = _G.html_like_fts_no_jsx,
  },
  htmx = {
    filetypes = _G.html_like_fts,
    single_file_support = false,
    root_dir = { '.git' },
    autostart = false,
  },
  marksman = {
    single_file_support = false,
  },
  pyright = {
    disableOrganizeImports = false,
    analysis = {
      useLibraryCodeForTypes = true,
      autoSearchPaths = true,
      diagnosticMode = 'workspace',
      autoImportCompletions = true,
    },
  },
  sqls = {
    root_markers = { '.sqllsrc.json', 'package.json', '.git' },
  },
  vimls = {},
}
