# To implement in my Neovim config

## To Do

- [ ] create url/links.nvim plugin
  - [ ] Search in buffer for regex pattern of links and return a table of all the found links
    - [ ] Display in qf list by default
    - [ ] Pipe into a Telescope picker
    - [ ] Expose API function that directly returns all links so users can extend it
  - [ ] Search in line for regex pattern of links (like <CWORD>, but more powerful with regex search)
    - [ ] Use `vim.api.nvim_get_current_line()` 
    - [ ] Expose API function that directly returns all links in the line so users can extend it
    - [ ] Potentially only allow it to return links where the cursor is found to be within the match (<CWORD> -ish functionality)
  - [ ] Run `open`/`xdg-open` for current link
    - [ ] Should open a single link or list of links
    - [ ] Open link under cursor in browser
  - [ ] Popup window to add label for a markdown link and retrieve link in clipboard and add it to a daily ZK-cli note
  - [ ] Telescope popup that receives all of the links in the current buffer(s) and launches them on `<cr>`
  - [ ] Jump to next/previous link in the document with a motion

- [ ] Make light rose-pine-theme load in the afternoons and switch back to dark when the sun starts to set
- [ ] set up basic `.vimrc` file with no dependencies for when I need to edit stuff there
- [ ] set up zk-cli and think about workflows
  - [ ] add hammerspoon|tmux|awesomewm popup to capture quick thoughts into a daily zk note and get back to work
  - [ ] add keymaps and settings for LSP integration into Neovim
  - [ ] test out linking and notetaking with zk-cli
  - [ ] integrate a tmux workflow like [sirupsen's scripts](https://github.com/sirupsen/zk)

- [ ] replace bullets.vim with better solution (maybe autopairs luasnip?)
- [ ] add c-n/c-p/c-w commands to linux...im sick of not having that
- [ ] add TJ's emmy-lua-doc generator to `vimconf-2021` project for easy documentation
- [ ] Read up on `:help :map-operator`
- [ ] install emmet.vim and func from mhartington's config
- [ ] Create `awesome-neovim-learning/resources` repo to centralize great blog posts, videos, articles, repos, and resources on how to use Lua and Neovim
- [ ] remove `luadev` dependency and configure lua-language-server properly
- [ ] add astro config to lspconfig repo in a PR
- [ ] write a plugin/script for better recent buffer management/deletion/swapping
- [ ] update `lua-language-server`
- [ ] check cronjobs
- [ ] list out all my critical dev setup tools and figure out best distro for them
- [ ] maybe start reading the "mouseless dev environment" book to try arch??
- [ ] redo lualine config
- [ ] create curl-able dotfile bootstrapper script like [Mike Hartington's](https://github.com/mhartington/dotfiles/blob/main/install.sh)
- [ ] [Add easier way to create files/directories to lir](https://github.com/tamago324/lir.nvim/wiki/Custom-actions#input_newfile)

- [ ] Setup some luasnip snippets for easier dev stuff
  - [x] Make luasnip go to next insert point when completing an item with nvim-cmp

- [ ] Add Treesitter custom queries for Javascript/Typescript to have textobjects
  - [ ] Object entries
  - [ ] JSX props/attributes
  - [ ] cc: [treesitter-textobjects docs](https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/README.md#built-in-textobjects)
  - [ ] cc: [treesitter-textobjects deprecation issue](https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/65#issuecomment-873426234)

- [ ] Add operator-pending mode to run `:sort` on a given text-object
  - [ ] i.e. `<leader>s + i{` sorts all entries in a Javascript object

- [ ] Create your own colorscheme from tjdevries/colorbuddy.nvim
- [ ] Telescope extension for inserting react component based upon lsp server suggestions
- [ ] Mapping to get completion from lsp for react components, and complete them without typing angle brackets

- [ ] Work on notetaking please
	- [ ] nvim-workbench for project notes setup
	- [ ] Central place to access and process quick fleeting ideas
	- [ ] Review process for fleeting notes



## Learn

- [ ] How does `modeline` work?
- [ ] Read `:h runtimepath`
- [ ] [How can you create a new operator?](https://stackoverflow.com/questions/8994276/how-to-define-a-new-vim-operator-with-a-parameter#8998136)
  - [ ] How does `opfunc` work for creating new operators?
- [ ] Set custom `equalprg`/`formatprg` to `prettier` for web dev files to format/indent with prettier
- [ ] `:<C-U>` in mappings -> deletes all text before the cursor to remove the visual line inserted range



## Done

- [x] Add a telescope custom picker to get currently loaded Packer plugins
- [x] Refactor autopairs config
  - [x] Add autopairs endwise config
- [x] Refactor completion/snippets file
  - [x] Remove nvim-compe config
  - [x] Document cmp.lua
- [x] I need to move all configs out of packer's file, because it just is buggy
- [x] install harpoon please
- [x] add revealjs integration to vimconf-2021 presentation



## Maybe one day

- [ ] Implement neovim support for Astro components
	- [ ] Write treesitter queries for Astro JS
		- [ ] Open an issue to see how to do this
			- Just extend html_tags and then add the additionally functionality?
			- Do I need a new parser?
		- [ ] Write the necessary queries for Astro
		- [ ] Write a parser for Astro
		- [ ] Open a PR for nvim-treesitter extending Astro support
	- [ ] Implement the LSP config for Astro
		- [x] Get the LSP server working with LSP config
		- [ ] Open an issue on Astro-ls asking if they can make an NPM package to easily install the server globally
		- [ ] Make a PR for lspconfig with astro-ls configuration
