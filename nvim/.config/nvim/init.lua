-- `init.lua`

-- Experimental opt in. Report bugs we find to the relevant neovim issue.
-- https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
vim.g.do_filetype_lua = 1

--[[ TODO TODO:
Roadmap:

1. Improve the highlighting (treesitter) using colorbuddy. Get the LSP
   diagnostics on point.
2. Remove all `TODO`s from our configs. Too many weird bugs.
3. Set up the quickfix binds to be smarter (as per comment there)
4. Set up a grand telescope picker menu (not jus tbuiltins)
]]


-- Cache our compiled config modules.
pcall(require, 'impatient')

-- Set global variables and lua functions early in our config, so all modules
-- will see them.
vim.g.mapleader = ' '
require('yashlala.globals')

-- If this is the first time we're running Neovim, install packer.nvim etc.
require('yashlala.fresh-install')()

-- Source basic options and keymaps first.
-- All more complicated things are in the `after/plugin` dir.
require('yashlala.options')()
require('yashlala.mappings')()

-- Source our plugins
local use = require('packer').use
require('packer').startup(function()
  -- Package manager.
  use 'wbthomason/packer.nvim'
  -- Utility functions used by other plugins.
  use 'nvim-lua/plenary.nvim'
  -- Caches lua modules. Will eventually be merged into mainline.
  use 'lewis6991/impatient.nvim'

  -- Fancier statusline.
  use 'nvim-lualine/lualine.nvim'

  -- Colorscheme.
  use 'yashlala/seoul256.vim'
  use 'kyazdani42/nvim-web-devicons'
  use 'tjdevries/colorbuddy.nvim'

  -- Diary + Wiki
  use 'vimwiki/vimwiki'

 -- Automatically match file format/indentation.
 -- TODO: Rewrite this so defaults make sense.
  use 'tpope/vim-sleuth'
  -- Automatically respect `.editorconfig` files. 
  use 'gpanders/editorconfig.nvim'
  -- Strip trailing whitespace on lines we've modified.
  -- This plugin can only keep track of about 95 changed lines
  -- before it runs out of stack space and defaults to "strip the entire file".
  -- May cause issues for us later.
  -- use 'axelf4/vim-strip-trailing-whitespace'

  -- Vim motions that don't require counts.
  -- TODO: Why do all of these suck?
  -- use 'easymotion/vim-easymotion'
  use 'phaazon/hop.nvim'

  -- Automatic table alignment.
  use 'junegunn/vim-easy-align'
  -- Surround vim motions.
  use 'tpope/vim-surround'
  -- Better text objects (eg: dia to delete one function argument)
  use 'wellle/targets.vim'
  -- Substitute areas of text with register contents (motion style)
  use 'svermeulen/vim-subversive'
  -- "gc" keybinding to comment visual regions/lines.
  use 'numToStr/Comment.nvim'
  -- Date increments and decrements w/ <c-a> and <c-x>
  use 'tpope/vim-speeddating'
  -- Unix commands.
  use 'tpope/vim-eunuch'

  -- Git commands + Status page.
  use 'tpope/vim-fugitive'
  -- Git related info in signs column and popups.
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Better quickfix list.
  use 'kevinhwang91/nvim-bqf'
  -- Better marks
  -- TODO: Make a telescope previewer for the marks in the current buffer.
  use 'chentoast/marks.nvim'
  -- Project-specific file "marks" and terminals
  use 'ThePrimeagen/harpoon'
  -- Use for a generic persistent terminal keybind.
  use 'akinsho/toggleterm.nvim'
  -- Allow searching through custom terminals (names etc)
  use { 'tknightz/telescope-termfinder.nvim',
    requires = { "nvim-telescope/telescope.nvim", "akinsho/nvim-toggleterm.lua" }
  }
  -- Delete a buffer without affecting the window layout.
  use 'yashlala/vim-sayonara'

  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  use 'mfussenegger/nvim-jdtls'

  -- Highlighting, editing, etc. using incremental parsing.
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Autocompletion plugin
  -- TODO: It's new! set it up!
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua' -- Includes Neovim API!
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'

  use 'saadparwaiz1/cmp_luasnip'
  use { 'L3MON4D3/LuaSnip', after = 'nvim-cmp', }
  use 'rafamadriz/friendly-snippets'

  -- More discoverable LSP code actions
  use { 'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim'
  }
  -- Better menu for LSP code actions
  use 'weilbith/nvim-code-action-menu'

  -- Global Menu and Fuzzy Finder.
  use { 'nvim-telescope/telescope.nvim', requires = {
    { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    run = 'make'
  }
  use 'nvim-telescope/telescope-file-browser.nvim'
  -- Automatically `cd` to project root. Integrates with Telescope.
  -- Use this to quickly return to old projects (as opposed to searching *in*
  -- a project, which we do with the regular telescope builtins.
  -- TODO: Not working for some reason.
  use 'ahmedkhalf/project.nvim'
  use 'stevearc/dressing.nvim' -- Prettify built-in UIs.
  use 'AckslD/nvim-neoclip.lua' -- TODO: Setup

  -- Allow plugins to use the `.` key (if they support it).
  use 'tpope/vim-repeat'
end)

-- TODO: Colorscheme things
-- Load colorscheme *before* other plugins are set up.
vim.g.seoul256_srgb = 1
vim.api.nvim_command('colorscheme seoul256')
-- TODO: Highlight the signs column like we do in gitsigns.
vim.api.nvim_command('highlight WinSeparator guibg=None')
