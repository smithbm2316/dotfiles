-- stylua: ignore start
local file = assert(
  io.open(
    vim.env.XDG_CONFIG_HOME .. '/nvim/after/queries/html/injections.scm',
    'r'
  )
)
-- stylua: ignore end
local html_injections_text = file:read '*a' --[[@as string]]
file:close()

-- override astro parser's treesitter injections queries only when we are in a WebC file, include injections from html since we are overriding those here too. we only want to override astro
vim.treesitter.query.set('astro', 'injections', html_injections_text .. [[
; inject yaml into frontmatter
; adapted from: https://github.com/virchau13/tree-sitter-astro/blob/master/queries/injections.scm
(frontmatter
  (raw_text) @injection.content
  (#set! injection.language "yaml"))

; set <script> tags raw_text to be javascript
; adapted from: https://github.com/virchau13/tree-sitter-astro/blob/master/queries/injections.scm
(script_element
  (raw_text) @injection.content
  (#set! injection.language "javascript"))

; set <style> tags raw_text to be css
; adapted from: https://github.com/virchau13/tree-sitter-astro/blob/master/queries/injections.scm
((style_element
  (raw_text) @injection.content)
 (#set! injection.language "css"))

; inject javascript into all dynamic webc attributes that parse valid javascript
; adapted from: https://github.com/bennypowers/webc.nvim/blob/main/queries/html/injections.scm
; 11ty docs: https://www.11ty.dev/docs/languages/webc/#dynamic-attributes-and-properties
((attribute_name) @_name
                  [
                    (attribute_value) @injection.content
                    (quoted_attribute_value
                      (attribute_value) @injection.content)
                  ]
                  (#not-eq? @_name "webc:root")
                  (#not-eq? @_name "webc:type")
                  (#not-eq? @_name "11ty:type")
                  (#not-eq? @_name "11ty:import")
                  (#match? @_name "^((webc)?:|\\@(html|raw|text))")
                  (#set! injection.language "javascript"))

; when using a <template> tag with `webc:type='11ty'` and `11ty:type='md'` as attributes, inject markdown into the raw content
; taken from: https://github.com/bennypowers/webc.nvim/blob/main/queries/html_tags/injections.scm
; 11ty docs: https://www.11ty.dev/docs/languages/webc/#using-template-syntax-to-generate-content
((element
  (start_tag
    (tag_name) @_tag_name (#eq? @_tag_name "template")
    ((attribute
       (attribute_name) @_attr1_name
       [
         (attribute_value) @_attr1_val
         (quoted_attribute_value
                 ((attribute_value) @_attr1_val))
       ]
       (#eq? @_attr1_name "webc:type")
       (#eq? @_attr1_val "11ty")
       ))
    ((attribute
       (attribute_name) @_attr2_name
       [
         (attribute_value) @_attr2_val
         (quoted_attribute_value
                 ((attribute_value) @_attr2_val))
       ]
       (#eq? @_attr2_name "11ty:type")
       (#eq? @_attr2_val "md"))))
  (text) @injection.content
  (#set! injection.language "markdown")))
]])

-- setup the commentstrings for webc
local ok, comment_ft = pcall(require, 'Comment.ft')
if ok then
  comment_ft.set('webc', {
    '<!---%s--->',
    '<!---%s--->',
  })
end
