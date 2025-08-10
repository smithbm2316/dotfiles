return {
  filetypes = { 'templ' },
  -- use project-local templ if it exits, default to lspconfig global templ if not
  cmd = {
    exists_in_cwd './bin/templ' and './bin/templ' or 'templ',
    'lsp',
  },
}
