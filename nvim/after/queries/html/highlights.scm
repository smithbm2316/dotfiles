; extends

; highlight Livewire `wire:` attributes
; adapted from: https://github.com/bennypowers/webc.nvim/blob/main/queries/html/highlights.scm
((attribute_name) @keyword
                  (#offset! @keyword 0 5 0 0)
                  (#match? @keyword "^wire:"))
