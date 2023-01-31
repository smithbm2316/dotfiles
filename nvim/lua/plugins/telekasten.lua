local ok, telekasten = pcall(require, 'telekasten')
if not ok then
  return
end

-- setup the home folder for your notes
local zk_wiki_dir = vim.fn.expand '~/wiki'

telekasten.setup {
  home = zk_wiki_dir,
  -- if true, telekasten will be enabled when opening a note within the configured home
  take_over_my_home = true,

  -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
  --                               and thus the telekasten syntax will not be loaded either
  auto_set_filetype = true,

  -- dir names for special notes (absolute path or subdir name)
  dailies = zk_wiki_dir .. '/' .. 'daily',
  weeklies = zk_wiki_dir .. '/' .. 'weekly',
  templates = zk_wiki_dir .. '/' .. 'templates',

  -- image (sub)dir for pasting
  -- dir name (absolute path or subdir name)
  -- or nil if pasted images shouldn't go into a special subdir
  image_subdir = 'img',

  -- markdown file extension
  extension = '.md',

  -- Generate note filenames. One of:
  -- "title" (default) - Use title if supplied, uuid otherwise
  -- "uuid" - Use uuid
  -- "uuid-title" - Prefix title by uuid
  -- "title-uuid" - Suffix title with uuid
  new_note_filename = 'uuid-title',
  -- file uuid type ("rand" or input for os.date()")
  uuid_type = '%Y%m%d%H%M',
  -- UUID separator
  uuid_sep = '-',

  -- following a link to a non-existing note will create it
  follow_creates_nonexisting = true,
  dailies_create_nonexisting = true,
  weeklies_create_nonexisting = true,

  -- skip telescope prompt for goto_today and goto_thisweek
  journal_auto_open = false,

  -- template for new notes (new_note, follow_link)
  -- set to `nil` or do not specify if you do not want a template
  template_new_note = zk_wiki_dir .. '/' .. 'templates/new_note.md',

  -- template for newly created daily notes (goto_today)
  -- set to `nil` or do not specify if you do not want a template
  template_new_daily = zk_wiki_dir .. '/' .. 'templates/daily.md',

  -- template for newly created weekly notes (goto_thisweek)
  -- set to `nil` or do not specify if you do not want a template
  template_new_weekly = zk_wiki_dir .. '/' .. 'templates/weekly.md',

  -- image link style
  -- wiki:     ![[image name]]
  -- markdown: ![](image_subdir/xxxxx.png)
  image_link_style = 'markdown',

  -- default sort option: 'filename', 'modified'
  sort = 'filename',

  -- integrate with calendar-vim
  plug_into_calendar = false,
  --[[ calendar_opts = {
    -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
    weeknm = 4,
    -- use monday as first day of week: 1 .. true, 0 .. false
    calendar_monday = 1,
    -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
    calendar_mark = 'left-fit',
  }, ]]

  -- telescope actions behavior
  close_after_yanking = false,
  insert_after_inserting = true,

  -- tag notation: '#tag', ':tag:', 'yaml-bare'
  tag_notation = '#tag',

  -- command palette theme: dropdown (window) or ivy (bottom panel)
  command_palette_theme = 'dropdown',

  -- tag list theme:
  -- get_cursor: small tag list at cursor; ivy and dropdown like above
  show_tags_theme = 'dropdown',

  -- when linking to a note in subdir/, create a [[subdir/title]] link
  -- instead of a [[title only]] link
  subdirs_in_links = true,

  -- template_handling
  -- What to do when creating a new note via `new_note()` or `follow_link()`
  -- to a non-existing note
  -- - prefer_new_note: use `new_note` template
  -- - smart: if day or week is detected in title, use daily / weekly templates (default)
  -- - always_ask: always ask before creating a note
  template_handling = 'prefer_new_note',

  -- path handling:
  --   this applies to:
  --     - new_note()
  --     - new_templated_note()
  --     - follow_link() to non-existing note
  --
  --   it does NOT apply to:
  --     - goto_today()
  --     - goto_thisweek()
  --
  --   Valid options:
  --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
  --              all other ones in home, except for notes/with/subdirs/in/title.
  --              (default)
  --
  --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
  --                    except for notes with subdirs/in/title.
  --
  --     - same_as_current: put all new notes in the dir of the current note if
  --                        present or else in home
  --                        except for notes/with/subdirs/in/title.
  new_note_location = 'prefer_home',

  -- should all links be updated when a file is renamed
  rename_update_links = true,

  vaults = {
    -- alternate configuration for vault2 here. Missing values are defaulted to
    -- default values from telekasten.
    -- e.g.
    -- vault2 = {
    --   home = "/home/user/vaults/personal",
    -- },
  },

  -- how to preview media files
  -- "telescope-media-files" if you have telescope-media-files.nvim installed
  -- "catimg-previewer" if you have catimg installed
  media_previewer = 'viu-previewer',

  -- A customizable fallback handler for urls.
  follow_url_fallback = nil,
}

-- find notes in wiki
nnoremap('<leader>wj', function()
  telekasten.find_notes()
end, 'Wiki find notes')
-- find daily notes
nnoremap('<leader>wd', function()
  telekasten.find_daily_notes()
end, 'Wiki find daily notes')
-- find weekly notes
nnoremap('<leader>ww', function()
  telekasten.find_weekly_notes()
end, 'Wiki find weekly notes')
-- search/grep the contents of my wiki notes
nnoremap('<leader>wg', function()
  telekasten.search_notes()
end, 'Wiki grep notes')
-- follow a wiki link or markdown link
nnoremap('<leader>wo', function()
  telekasten.follow_link()
end, 'Wiki follow link')
-- create a new wiki note
nnoremap('<leader>wn', function()
  telekasten.new_note()
end, 'Wiki new note')
-- open the wiki command picker
nnoremap('<leader>wp', function()
  telekasten.panel()
end, 'Wiki command picker')
-- open the wiki tags picker
nnoremap('<leader>wt', function()
  telekasten.show_tags()
end, 'Wiki tags', { silent = false })
-- open the wiki link picker
nnoremap('<leader>wi', function()
  telekasten.insert_link()
end, 'Wiki insert link', { silent = false })
