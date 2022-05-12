# To implement in my Neovim config

## To Do

- [ ] Create Neovim 0.7 features update video
  - [List of features](https://neovim.discourse.group/t/neovim-0-7-stabilization-period-begins-today-4-2-2022/2259)
  - [:lua =expr PR](https://github.com/neovim/neovim/pull/16912)
  - [nvim remote](https://www.reddit.com/r/neovim/comments/tva95r/new_feature_nvim_remote/)

- [ ] Create `awesome-neovim-learning/resources` repo to centralize great blog posts, videos, articles, repos, and resources on how to use Lua and Neovim
- [ ] create curl-able dotfile bootstrapper script like [Mike Hartington's](https://github.com/mhartington/dotfiles/blob/main/install.sh)
- [ ] [Add easier way to create files/directories to lir](https://github.com/tamago324/lir.nvim/wiki/Custom-actions#input_newfile)
- [ ] set up basic `.vimrc` file with no dependencies for when I need to edit stuff there
- [ ] set up zk-cli and think about workflows
  - [ ] add hammerspoon|tmux|awesomewm popup to capture quick thoughts into a daily zk note and get back to work
  - [x] add keymaps and settings for LSP integration into Neovim
  - [ ] test out linking and notetaking with zk-cli
  - [ ] integrate a tmux workflow like [sirupsen's scripts](https://github.com/sirupsen/zk)

- [ ] replace bullets.vim with better solution (maybe autopairs luasnip?)
- [ ] add c-n/c-p/c-w commands to linux...im sick of not having that
- [ ] add TJ's emmy-lua-doc generator to `vimconf-2021` project for easy documentation
- [ ] Read up on `:help :map-operator`
- [ ] add astro config to lspconfig repo in a PR
- [ ] check cronjobs
- [ ] list out all my critical dev setup tools and figure out best distro for them

- [ ] Add Treesitter custom queries for Javascript/Typescript to have textobjects
  - [ ] Object entries
  - [ ] JSX props/attributes
  - [ ] cc: [treesitter-textobjects docs](https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/README.md#built-in-textobjects)
  - [ ] cc: [treesitter-textobjects deprecation issue](https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/65#issuecomment-873426234)



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
- [x] create url/links.nvim plugin (someone made this already)
- [x] Make light rose-pine-theme load in the afternoons and switch back to dark when the sun starts to set
- [x] install emmet.vim and func from mhartington's config
- [x] remove `luadev` dependency and configure lua-language-server properly (emmy-lua docs are nice, don't delete)
- [x] write a plugin/script for better recent buffer management/deletion/swapping (someone made a plugin)
- [x] update `lua-language-server`
- [x] maybe start reading the "mouseless dev environment" book to try arch?? (omegalul arch btw, not going down that rabbit hole anytime soon)
- [x] redo lualine config
- [x] Setup some luasnip snippets for easier dev stuff
  - [x] Make luasnip go to next insert point when completing an item with nvim-cmp
- [x] Add operator-pending mode to run `:sort` on a given text-object
  - [x] i.e. `<leader>s + i{` sorts all entries in a Javascript object

- [x] Create your own colorscheme from tjdevries/colorbuddy.nvim
- [x] Telescope extension for inserting react component based upon lsp server suggestions
- [x] Mapping to get completion from lsp for react components, and complete them without typing angle brackets



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
