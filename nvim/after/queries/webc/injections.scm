; inherits: html

; if the `frontmatter_lang` node has a value of `js`, embed javascript into the `frontmatter_content` node
(frontmatter
  ((frontmatter_lang) @_frontmatter_lang
                      (#eq? @_frontmatter_lang "js")
                      (frontmatter_content) @injection.content
                      (#set! injection.language "javascript")
                      (#set! injection.combined)))

; if the `frontmatter_lang` node has a value of `json`, embed JSON into the `frontmatter_content` node
(frontmatter
  ((frontmatter_lang) @_frontmatter_lang
                      (#eq? @_frontmatter_lang "json")
                      (frontmatter_content) @injection.content
                      (#set! injection.language "json")
                      (#set! injection.combined)))

; otherwise fallback to the default of `yaml` if our `frontmatter_lang` node is an empty string
(frontmatter
  ((frontmatter_lang) @_frontmatter_lang
                      (#eq? @_frontmatter_lang "")
                      (frontmatter_content) @injection.content
                      (#set! injection.language "yaml")
                      (#set! injection.combined)))

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
