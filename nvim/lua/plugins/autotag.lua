local ok, autotag = pcall(require, 'nvim-ts-autotag')
if not ok then
  return
end

autotag.setup {
  filetypes = {
    'astro',
    'edge',
    'html',
    'liquid',
    'django',
    'htmldjango',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'jinja',
    'jinja.html',
    'nunjucks',
    'webc',
    'templ',
  },
  skip_tags = {
    'area',
    'base',
    'br',
    'col',
    'command',
    'embed',
    'hr',
    'img',
    'slot',
    'input',
    'keygen',
    'link',
    'meta',
    'menuitem',
    'param',
    'source',
    'track',
    'wbr',
  },
}
