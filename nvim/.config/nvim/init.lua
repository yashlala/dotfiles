-- `init.lua`

--[[ TODO TODO:
Roadmap:

1. Switch to easymotion, hop, or something. We may be blocking on a PR going
   through, if this is the case then set up a proper reminder.

2. Figure out why lua LSP isn't autostarting.

5. Create binds for LSP commands - `gd`, etc.

2. Use telescope for a solid file browser.
   We should have the prompt include the CWD
   We can use this to make the rest of these pervasive changes.

3. Once we have a file browser, implement other telescope pickers, TJ style.
   This may allow us to remove `autochdir` and reinstate `project.nvim`.

4. Set up luasnip style snippets.

6. Improve the highlighting (treesitter) using colorbuddy. Get the LSP
   diagnostics on point.

7. Remove all `TODO`s from our configs. Too many weird bugs.

8. Set a better abbreviation so we can't quit when there are multiple buffers.

10. Set up the quickfix binds to be smarter (as per comment there)
11. Set up a grand telescope picker menu (not jus tbuiltins)

9. Set up a better git plugin. Install neogit instead, then get rid of signs
   and fugitive? Might be easier.
]]


-- Cache our compiled config modules.
pcall(require, 'impatient')

-- Set global variables and lua functions early in our config, so all modules
-- will see them.
vim.g.mapleader = ' '
require('lala.globals')

-- If this is the first time we're running Neovim, install packer.nvim etc.
require('lala.fresh-install')()

-- Source basic options and keymaps first.
-- All more complicated things are in the `after/plugin` dir.
require('lala.options')()
require('lala.mappings')()

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
  use 'junegunn/seoul256.vim'
  use 'overcache/NeoSolarized'
  use 'nisavid/vim-colors-solarized'
  use 'kyazdani42/nvim-web-devicons'
  use 'tjdevries/colorbuddy.nvim'

  -- Diary + Wiki
  use 'vimwiki/vimwiki'
  use 'mattn/calendar-vim'

 -- Automatically match file format/indentation.
 -- TODO: Rewrite this so defaults make sense.
  use 'tpope/vim-sleuth'
  -- Strip trailing whitespace on lines we've modified.
  -- This plugin can only keep track of about 95 changed lines
  -- before it runs out of stack space and defaults to "strip the entire file".
  -- May cause issues for us later. 
  use 'axelf4/vim-strip-trailing-whitespace'

  -- Vim motions that don't require counts.
  -- TODO: Why do all of these suck?
  -- use 'easymotion/vim-easymotion'
  use 'phaazon/hop.nvim'
  use 'ggandor/lightspeed.nvim'

  -- Automatic table alignment.
  use 'junegunn/vim-easy-align'
  -- Surround vim motions.
  use 'tpope/vim-surround'
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
  -- TODO: Try neogit instead
  -- Looks like neogit just runs out of memory when dealing with large number
  -- of changes. Eek.
  -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- Better quickfix list.
  use 'kevinhwang91/nvim-bqf'
  -- Better marks
  -- TODO: Make a telescope previewer for the marks in the current buffer.
  use 'chentau/marks.nvim'
  -- Project-specific file "marks"
  use 'ThePrimeagen/harpoon'

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
  use 'hrsh7th/cmp-nvim-lua' -- Includes Neovim API!
  use 'hrsh7th/cmp-nvim-lsp'

  use 'L3MON4D3/LuaSnip' -- Snippets plugin. TODO: Set this up.
  use 'saadparwaiz1/cmp_luasnip'

  -- Global Menu and Fuzzy Finder.
  use { 'nvim-telescope/telescope.nvim', requires = {
    { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    run = 'make'
  }
  --
  use 'nvim-telescope/telescope-file-browser.nvim'
  -- Automatically `cd` to project root. Integrates with Telescope.
  -- Use this to quickly return to old projects (as opposed to searching *in*
  -- a project, which we do with the regular telescope builtins.
  -- TODO: Not working for some reason.
  use 'ahmedkhalf/project.nvim'
  use 'AckslD/nvim-neoclip.lua' -- TODO: Setup

  use 'folke/which-key.nvim'

  -- Allow plugins to use the `.` key (if they support it).
  use 'tpope/vim-repeat'
end)

-- Load colorscheme *before* other plugins are set up.
vim.g.seoul256_srgb = 1
vim.api.nvim_command('colorscheme seoul256')
-- TODO: Highlight the signs column like we do in gitsigns.
vim.api.nvim_command('highlight SignColumn ctermbg=238')
