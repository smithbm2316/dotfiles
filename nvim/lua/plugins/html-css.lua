local ok, html_css = pcall(require, 'html-css')
if not ok then
  return
end

html_css.setup {
  option = {
    max_count = {}, -- not ready yet
    file_types = {
      'html',
      'astro',
      'javascriptreact',
      'typescriptreact',
    },
    css_file_extensions = {
      'css',
      'scss',
      'sass',
      'less',
    },
    should_load_cwd_files = true,
    --[[ style_sheets = {
      -- example of remote styles
      -- 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css',
      -- example of local styles that can be found inside root folder
      './style.css',
      'index.css',
    }, ]]
  },
}
