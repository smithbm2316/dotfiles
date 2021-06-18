local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
require'neuron'.setup {
  virtual_titles = true,
  mappings = false,
  run = nil, -- function to run when in neuron dir
  neuron_dir = '~/neuron', -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
  leader = nil, -- the leader key to for all mappings, remember with 'go zettel'
}

-- click enter on [[my_link]] or [[[my_link]]] to enter it
map('n', '<cr>', [[<cmd>lua require'neuron'.enter_link()<cr>]], opts)

-- Neuron Create: create a new note
map('n', '<leader>nc', [[<cmd>lua require'neuron/cmd'.new_edit(require'neuron'.config.neuron_dir)<cr>]], opts)

-- Neuron Find: find your notes, click enter to create the note if there are not notes that match
map('n', '<leader>nf', [[<cmd>lua require'neuron/telescope'.find_zettels()<cr>]], opts)
-- Neuron Insert: insert the id of the note that is found
map('n', '<leader>ni', [[<cmd>lua require'neuron/telescope'.find_zettels {insert = true}<cr>]], opts)

-- Neuron Backlinks: find the backlinks of the current note all the note that link this note
map('n', '<leader>nb', [[<cmd>lua require'neuron/telescope'.find_backlinks()<cr>]], opts)
-- Neuron Links: same as above but insert the found id
map('n', '<leader>nl', [[<cmd>lua require'neuron/telescope'.find_backlinks {insert = true}<cr>]], opts)

-- Neuron Tags: find all tags and insert
map('n', '<leader>nt', [[<cmd>lua require'neuron/telescope'.find_tags()<cr>]], opts)

-- Neuron Serve/Start: start the neuron server and render markdown, auto reload on save
map('n', '<leader>ns', [[<cmd>lua require'neuron'.rib {address = "127.0.0.1:8200", verbose = true}<cr>]], opts)

-- Neuron Next: go to next [[my_link]] or [[[my_link]]]
map('n', '<leader>nn', [[<cmd>lua require'neuron'.goto_next_extmark()<cr>]], opts)
-- Neuron Previous: go to previous
map('n', '<leader>np', [[<cmd>lua require'neuron'.goto_prev_extmark()<cr>]], opts)
