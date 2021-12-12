-- `init.lua`

--[[ TODO TODO:
Roadmap:

1. Figure out why everything breaks when we put it in the `after` directory. 
   Figured it out. The plugin dir is sourced before the after dir -- so all
   global variables we set in the after dir won't actually do anything.
   What a pain. We'll make corresponding entries in the regular plugin dirs then. 

2. Use the previous insight to fully move from EasyMotion to hop. 

2. Use telescope for a solid file browser.
   We should have the prompt include the CWD
   We can use this to make the rest of these pervasive changes.

3. Once we have a file browser, implement other telescope pickers, TJ style.
   This may allow us to remove `autochdir` and reinstate `project.nvim`.

4. Set up luasnip style snippets.

5. Create binds for LSP commands - `gd`, etc. 
6. Improve the highlighting (treesitter) using colorbuddy. Get the LSP
   diagnostics on point. 
7. Remove all `TODO`s from our configs. Too many weird bugs. 
8. Set a better abbreviation so we can't quit when there are multiple buffers. 
10. Set up the quickfix binds to be smarter (as per comment there)
9. Set up a better git plugin. 
11. Set up a grand telescope picker menu (not jus tbuiltins)
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
  use 'itchyny/lightline.vim'
  -- Buffer list for statusline.
  use 'mengelbrecht/lightline-bufferline'

  -- Colorscheme.
  use 'junegunn/seoul256.vim'
  use 'overcache/NeoSolarized'
  use 'nisavid/vim-colors-solarized'
  use 'kyazdani42/nvim-web-devicons'
  use 'tjdevries/colorbuddy.nvim'

  -- Diary + Wiki
  use 'vimwiki/vimwiki'
  use 'itchyny/calendar.vim' -- TODO: Can't select diary date? 

 -- Automatically match file format/indentation.
 -- TODO: Rewrite this so defaults make sense. 
  use 'tpope/vim-sleuth'
  -- Vim motions that don't require counts. 
  use 'easymotion/vim-easymotion'
  use 'phaazon/hop.nvim'

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
  -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- File Browser
  -- TODO: Set up.

  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  use 'mfussenegger/nvim-jdtls'

  -- Highlighting, editing, etc. using incremental parsing.
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'L3MON4D3/LuaSnip' -- Snippets plugin. TODO: broken.

  -- Autocompletion plugin
  -- TODO: It's new! set it up!
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua' -- Includes Neovim API!
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'

  -- Global Menu and Fuzzy Finder.
  use { 'nvim-telescope/telescope.nvim', requires = {
    { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', 
    requires = { 'nvim-telescope/telescope.nvim' }, 
    run = 'make'
  }
  use 'AckslD/nvim-neoclip.lua' -- TODO: Setup
  -- Automatically `cd` to project root. Integrates with Telescope.
  -- Use this to quickly return to old projects (as opposed to searching *in*
  -- a project, which we do with the regular telescope builtins.
  -- TODO: Why aren't we listing previous projects anymore? 
  use "ahmedkhalf/project.nvim"

  -- Allow plugins to use the `.` key (if they support it).
  use 'tpope/vim-repeat'
end)

-- Load colorscheme *before* other plugins are set up.
vim.g.seoul256_srgb = 1
vim.api.nvim_command('colorscheme seoul256')

-- TODO: Things work when we do it here, but _not_ when we do it later in the
-- file. What gives? 
-- Figure out how everything works...maybe we should just do it in the lua dir. 

vim.api.nvim_set_var('lightline#bufferline#unnamed', '[No Name]')
vim.api.nvim_exec([[
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
      \ 'component_type': { 'buffers': 'tabsel' } }
]], false)
