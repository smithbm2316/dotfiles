return {
  'nvim-tree/nvim-web-devicons',
  lazy = true,
  config = function()
    local shared_configs = {
      rc_file = {
        icon = '',
        name = 'RCFile',
      },
      docker = {
        icon = '',
        color = '#2496ed',
        name = 'Docker',
      },
    }

    local filename_configs = {
      ['.gitignore'] = {
        icon = '',
        color = '#f54d27',
        name = 'Gitignore',
      },
      ['yarn.lock'] = {
        icon = '',
        color = '#2188b6',
        name = 'YarnLockfile',
      },
      ['package-lock.json'] = {
        icon = '',
        color = '#84ba64',
        name = 'NPMLockfile',
      },
      ['package.json'] = {
        icon = '',
        color = '#cb0000',
        name = 'PackageJSON',
      },
      ['tsconfig.json'] = {
        icon = '',
        color = '#3278c6',
        name = 'TSConfig',
      },
      ['go.mod'] = {
        icon = '󰟓',
        color = '#519aba',
        name = 'GolangSum',
      },
      ['.prettierrc'] = shared_configs.rc_file,
      ['.prettierignore'] = shared_configs.rc_file,
      ['.prettierrc.json'] = shared_configs.rc_file,
      ['.prettierrc.js'] = shared_configs.rc_file,
      ['prettier.config.js'] = shared_configs.rc_file,
      ['.eslintrc'] = shared_configs.rc_file,
      ['.eslintignore'] = shared_configs.rc_file,
      ['.eslintrc.json'] = shared_configs.rc_file,
      ['eslint.config.js'] = shared_configs.rc_file,
      ['.djlintrc'] = shared_configs.rc_file,
      Dockerfile = shared_configs.docker,
      ['.dockerignore'] = shared_configs.docker,
      ['docker-compose.yml'] = shared_configs.docker,
    }

    local web_tool_configs = {
      astro = {
        icon = '󱓞',
        color = '#ff7e33',
        name = 'AstroConfig',
      },
      next = {
        icon = '',
        color = '#000000',
        name = 'NextjsConfig',
      },
      remix = {
        icon = '',
        color = '#d83cd2',
        name = 'RemixConfig',
      },
      tailwind = {
        icon = '󱏿',
        color = '#0fa5e9',
        name = 'TailwindCSSConfig',
      },
      vite = {
        icon = '',
        color = '#ffcc24',
        name = 'ViteConfig',
      },
    }

    local web_config_file_endings = { '.js', '.ts', '.mjs', '.cjs' }
    for tool_name, icon_config in pairs(web_tool_configs) do
      for _, file_ending in ipairs(web_config_file_endings) do
        filename_configs[tool_name .. '.config' .. file_ending] = icon_config
      end
    end

    local file_extension_configs = {
      go = {
        icon = '',
        color = '#519aba',
        cterm_color = '74',
        name = 'Go',
      },
      tmpl = {
        icon = '󰗀',
        color = '#519aba',
        name = 'GolangHTMLTemplate',
      },
      templ = {
        icon = '󰗀',
        color = '#dbbd30',
        name = 'Templ',
      },
      html = {
        icon = '',
        color = '#f16529',
        name = 'HTML',
      },
      njk = {
        icon = '',
        color = '#5cb85c',
        name = 'Nunjucks',
      },
      jinja = {
        icon = '',
        color = '#b41717',
        name = 'Jinja',
      },
      j2 = {
        icon = '',
        color = '#b41717',
        name = 'Jinja',
      },
      css = {
        icon = '',
        color = '#409ad6',
        name = 'CSS',
      },
      js = {
        icon = '󰌞',
        color = '#f6e400',
        name = 'Javascript',
      },
      mjs = {
        icon = '󰌞',
        color = '#f6e400',
        name = 'Javascript',
      },
      cjs = {
        icon = '󰌞',
        color = '#f6e400',
        name = 'Javascript',
      },
      ts = {
        icon = '󰛦',
        color = '#3278c6',
        name = 'Typescript',
      },
      ['test.js'] = {
        icon = '󰙨',
        color = '#cbcb41',
        name = 'JsTest',
      },
      ['spec.js'] = {
        icon = '󰙨',
        color = '#f6e400',
        name = 'JsSpec',
      },
      ['test.lua'] = {
        icon = '󰙨',
        color = '#51a0cf',
        name = 'LuaTest',
      },
      ['spec.lua'] = {
        icon = '󰙨',
        color = '#51a0cf',
        name = 'LuaSpec',
      },
      tl = {
        icon = '󰢱',
        color = '#0095a0',
        name = 'Teal',
      },
      jsonc = {
        icon = '',
        color = '#f6e400',
        name = 'JsonC',
      },
      graphql = {
        icon = '󰡷',
        color = '#e10298',
        name = 'GraphQL',
      },
      astro = {
        icon = '󱓞',
        color = '#ff7e33',
        name = 'Astro',
      },
      scm = {
        icon = '',
        color = '#afdb89',
        name = 'TreesitterQuery',
      },
      ['css.ts'] = {
        icon = '',
        color = '#3278c6',
        name = 'CSS.TS',
      },
      edge = {
        icon = '󱩅',
        color = '#0cbba4',
        name = 'EdgeJS',
      },
      ['blade.php'] = {
        icon = '󰫐',
        color = '#f33a2f',
        name = 'Blade',
      },
    }

    require('nvim-web-devicons').setup {
      override_by_filename = filename_configs,
      override_by_extension = file_extension_configs,
      default = false,
    }
  end,
}
