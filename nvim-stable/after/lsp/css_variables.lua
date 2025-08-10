local filetypes = {
  'css',
  'scss',
  'svelte',
  'vue',
}

---@type string[]
local lookupFiles = {}
for ft in ipairs(filetypes) do
  for root in ipairs { 'app', 'styles', 'src' } do
    table.insert(lookupFiles, string.format('%s/**/*.%s', root, ft))
  end
  table.insert(lookupFiles, '*.' .. ft)
end

return {
  filetypes = filetypes,
  root_markers = { 'package.json', 'deno.json', 'deno.jsonc' },
  settings = {
    cssVariables = {
      --[[blacklistFolders = {
        -- common folders
        '**/.DS_Store',
        '**/.cache',
        '**/.git',
        '**/.vscode',
        '**/tmp',
        -- common js project folders/output folders
        '**/dist',
        '**/node_modules',
        '**/tests',
        -- nextjs
        '**/.next',
        -- nuxt
        '**/.nuxt',
        '**/.output',
        -- sveltekit
        '**/.svelte-kit',
        -- work
        '**/.shopify',
        '**/.shopify',
      },--]]
      languages = filetypes,
      lookupFiles = lookupFiles,
    },
  },
}
