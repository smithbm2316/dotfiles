; queries adapted from:
; https://github.com/gbprod/php-enhanced-treesitter.nvim

;;;;;;;;;;;;;
; BACKTICKS ;
;;;;;;;;;;;;;

; SELECT...FROM
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ss][Ee][Ll][Ee][Cc][Tt]%s+.+[Ff][Rr][Oo][Mm]"))

; WITH...AS
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ww][Ii][Tt][Hh]%s+.*[Aa][Ss].*"))

; UPSERT...INTO
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Uu][Pp][Ss][Ee][Rr][Tt]%s+[Ii][Nn][Tt][Oo]%s+.*"))

; EXPLAIN
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ee][Xx][Pp][Ll][Aa][Ii][Nn]"))

; ALTER TABLE
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Aa][Ll][Tt][Ee][Rr]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

; TRUNCATE TABLE
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Tt][Rr][Uu][Nn][Cc][Aa][Tt][Ee]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

; DROP TABLE
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Dd][Rr][Oo][Pp]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

; INSERT...INTO
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ii][Nn][Ss][Ee][Rr][Tt]%s+[Ii][Nn][Tt][Oo]"))

; CREATE FUNCTION
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]"))

; CREATE INDEX
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Ii][Nn][Dd][Ee][Xx]"))

; DROP INDEX
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Dd][Rr][Oo][Pp]%s+[Ii][Nn][Dd][Ee][Xx]"))

; UPDATE...SET
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Uu][Pp][Dd][Aa][Tt][Ee]%s+.+[Ss][Ee][Tt]"))

; DELETE FROM
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Dd][Ee][Ll][Ee][Tt][Ee]%s+[Ff][Rr][Oo][Mm]"))

; CREATE TABLE
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Tt][Aa][Bb][Ll][Ee]"))

; CREATE USER
((raw_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Uu][Ss][Ee][Rr]"))


;;;;;;;;;;;;;;;;;
; DOUBLE QUOTES ;
;;;;;;;;;;;;;;;;;


; SELECT...FROM
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ss][Ee][Ll][Ee][Cc][Tt]%s+.+[Ff][Rr][Oo][Mm]"))

; WITH...AS
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ww][Ii][Tt][Hh]%s+.*[Aa][Ss].*"))

; UPSERT...INTO
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Uu][Pp][Ss][Ee][Rr][Tt]%s+[Ii][Nn][Tt][Oo]%s+.*"))

; EXPLAIN
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ee][Xx][Pp][Ll][Aa][Ii][Nn]"))

; ALTER TABLE
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Aa][Ll][Tt][Ee][Rr]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

; TRUNCATE TABLE
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Tt][Rr][Uu][Nn][Cc][Aa][Tt][Ee]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

; DROP TABLE
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Dd][Rr][Oo][Pp]%s+[Tt][Aa][Bb][Ll][Ee]%s+.*"))

; INSERT...INTO
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Ii][Nn][Ss][Ee][Rr][Tt]%s+[Ii][Nn][Tt][Oo]"))

; CREATE FUNCTION
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]"))

; CREATE INDEX
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Ii][Nn][Dd][Ee][Xx]"))

; DROP INDEX
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Dd][Rr][Oo][Pp]%s+[Ii][Nn][Dd][Ee][Xx]"))

; UPDATE...SET
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Uu][Pp][Dd][Aa][Tt][Ee]%s+.+[Ss][Ee][Tt]"))

; DELETE FROM
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Dd][Ee][Ll][Ee][Tt][Ee]%s+[Ff][Rr][Oo][Mm]"))

; CREATE TABLE
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Tt][Aa][Bb][Ll][Ee]"))

; CREATE USER
((interpreted_string_literal_content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
  (#any-lua-match? @injection.content
    "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s+[Uu][Ss][Ee][Rr]"))
