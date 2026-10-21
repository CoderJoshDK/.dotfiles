# Joshie's personal NeoVim setup

Starting point from kickstart with extra customization.
This config is not made for others. But feel free to take inspiration or ~~steal~~ borrow some of my ideas/code.

## Setup

Use Neovim 0.12 or newer (required by the current nvim-treesitter `main` branch).
On first launch, lazy.nvim installs plugins and Mason installs the configured language servers.
Git and a C compiler are needed for plugin/parser installation; completion currently uses Blink's
Lua fuzzy matcher.

### Quick Look at Plugins

#### custom behavior

* remap
  * key mappings. In some cases, keymaps are defined in specific plugin setups.

#### plugins

* auto format
  * conform.nvim; format-on-save and manual formatting
* completion
  * blink.cmp with LuaSnip, Git, conventional-commit, and command-line completion
* lsp
  * lsp-config and Mason
* plugins
  * all other plugins that do not require special configs or are not important enough to pull out
* snacks
  * file explorer, pickers, scratch buffers, notifications, and other QoL features
* treesitter
  * treesitter

### Blog posts

I created a few blog post tutorials for setting up specific things.

* [Spell checker on code](https://coderjoshdk.github.io/tutorials/2024-01-15-Setting-Up-Spellcheck-on-Code-in-NeoVim.html)
* [Python things to keep in mind] (coming soon)
