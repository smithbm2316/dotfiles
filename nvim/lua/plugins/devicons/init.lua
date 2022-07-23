require('nvim-web-devicons').setup {
  override = {
    ['.gitignore'] = {
      icon = '',
      color = '#f54d27',
      name = 'Gitignore',
    },
    ['yarn.lock'] = {
      icon = '',
      color = '#2188b6',
      name = 'YarnLockfile',
    },
    ['package-lock.json'] = {
      icon = '',
      color = '#cb0000',
      name = 'NPMLockfile',
    },
    ['package.json'] = {
      icon = '',
      color = '#84ba64',
      name = 'PackageJSON',
    },
    ['tailwind.config.js'] = {
      icon = '',
      color = '#0fa5e9',
      name = 'TailwindCSSConfig',
    },
    ['next.config.js'] = {
      icon = '',
      color = '#000000',
      name = 'NextjsConfig',
    },
    ['remix.config.js'] = {
      icon = '',
      color = '#d83cd2',
      name = 'RemixConfig',
    },
    ['tsconfig.json'] = {
      icon = '',
      color = '#3278c6',
      name = 'TSConfig',
    },
    html = {
      icon = '',
      color = '#f16529',
      name = 'HTML',
    },
    css = {
      icon = '',
      color = '#409ad6',
      name = 'CSS',
    },
    js = {
      icon = '',
      color = '#f6e400',
      name = 'Javascript',
    },
    mjs = {
      icon = '',
      color = '#f6e400',
      name = 'Javascript',
    },
    cjs = {
      icon = '',
      color = '#f6e400',
      name = 'Javascript',
    },
    ts = {
      icon = 'ﯤ',
      color = '#3278c6',
      name = 'Typescript',
    },
    njk = {
      icon = '',
      color = '#5cb85c',
      name = 'Nunjucks',
    },
    lir_folder_icon = {
      icon = '',
      color = '#7ebae4',
      name = 'LirFolderNode',
    },
    ['test.js'] = {
      icon = 'ﭧ',
      color = '#cbcb41',
      name = 'JsTest',
    },
    ['spec.js'] = {
      icon = '',
      color = '#f6e400',
      name = 'JsSpec',
    },
    ['test.lua'] = {
      icon = 'ﭧ',
      color = '#51a0cf',
      name = 'LuaTest',
    },
    ['spec.lua'] = {
      icon = '',
      color = '#51a0cf',
      name = 'LuaSpec',
    },
    jsonc = {
      icon = '',
      color = '#f6e400',
      name = 'JsonC',
    },
    graphql = {
      icon = '',
      color = '#e10298',
      name = 'GraphQL',
    },
    -- eventually add icons for folders!
    --[[ ["*/"] = {
      icon = "",
      color = "#0fbfcf",
      name = "Folder",
    }; ]]
  },
  default = false,
}
