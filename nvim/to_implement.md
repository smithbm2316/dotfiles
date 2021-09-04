# To implement in my Neovim config

## Yes please now this minute
- [Add easier way to create files/directories to lir](https://github.com/tamago324/lir.nvim/wiki/Custom-actions#input_newfile)
- Refactor autopairs config
  * Add autopairs endwise config
- Setup some luasnip snippets for easier dev stuff
  * Make luasnip go to next insert point when completing an item with nvim-cmp
- Refactor completion/snippets file
  * Remove nvim-compe config
  * Document cmp.lua
- I need to move all configs out of packer's file, because it just is buggy

## Loose Ideas
- Telescope extension for inserting react component based upon lsp server suggestions
- Mapping to get completion from lsp for react components, and complete them without typing angle brackets

## To Do
- [ ] Implement neovim support for Astro components
	- [ ] Write treesitter queries for Astro JS
		- [ ] Open an issue to see how to do this
			* Just extend html_tags and then add the additionally functionality?
			* Do I need a new parser?
		- [ ] Write the necessary queries for Astro
		- [ ] Write a parser for Astro
		- [ ] Open a PR for nvim-treesitter extending Astro support
	- [ ] Implement the LSP config for Astro
		- [x] Get the LSP server working with LSP config
		- [ ] Open an issue on Astro-ls asking if they can make an NPM package to easily install the server globally
		- [ ] Make a PR for lspconfig with astro-ls configuration
- [ ] Work on notetaking please
	- [ ] nvim-workbench for project notes setup
	- [ ] Central place to access and process quick fleeting ideas
	- [ ] Review process for fleeting notes
- [ ] Hammerspoon modal configuration
- [ ] Raycast scripts and commands
