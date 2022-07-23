local ok, autotag = pcall(require, 'nvim-ts-autotag')
if not ok then
  return
end

autotag.setup {
  filetypes = {
    'html',
    'javascript',
    'javascriptreact',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
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
