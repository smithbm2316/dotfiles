local ok, autotag = pcall(require, 'nvim-ts-autotag')
if not ok then
  return
end

autotag.setup {
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
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
  aliases = {
    edge = 'html',
    webc = 'html',
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
