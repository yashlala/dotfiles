-- `init.lua`

-- TODO:
--
-- create vimrc (not nvim) for sshing. case sensitivity bad, bell is bad, etc.
-- set highlighting for just a "Q:" in vimwiki files so we can do topical
-- trees

-- Cache our compiled config modules.
pcall(require, 'impatient')

-- Set global variables and lua functions early in our config, so all modules
-- will see them.
vim.g.mapleader = ' '
require('yashlala.globals').setup()

-- If this is the first time we're running Neovim, install packer.nvim etc.
require('yashlala.fresh-install').setup()

-- Source basic options and keymaps first.
-- All more complicated things are in the `after/plugin` dir.
require('yashlala.options').setup()
require('yashlala.mappings').setup()

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

  -- Colorscheme. TODO: The latter two themes can be greatly customized.
  --                    Let's get a colorscheme that listens to Treesitter.
  use 'yashlala/seoul256.vim'
  use 'projekt0n/github-nvim-theme'
  use { 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim' }
  use 'kyazdani42/nvim-web-devicons'
  use 'tjdevries/colorbuddy.nvim'


 -- Automatically match file format/indentation.
 -- TODO: Rewrite this so defaults make sense.
  use 'tpope/vim-sleuth'
  -- Strip trailing whitespace on lines we've modified. May cause issues.
  use 'thirtythreeforty/lessspace.vim'

  -- Vim motions that don't require counts.
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
  -- Delete a buffer without affecting the window layout.
  use 'yashlala/vim-sayonara'

  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'mfussenegger/nvim-jdtls'

  -- Highlighting, editing, etc. using incremental parsing.
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Autocompletion plugin
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

  -- Better menu for LSP code actions
  use 'weilbith/nvim-code-action-menu'

  -- Diary + Wiki
  use 'vimwiki/vimwiki'
  use { 'nvim-orgmode/orgmode', after = 'nvim-treesitter' }

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
  use 'ahmedkhalf/project.nvim'
  -- Prettify built-in UIs.
  use { 'stevearc/dressing.nvim',
    config = function () require('dressing').setup() end
  }
  use 'AckslD/nvim-neoclip.lua' -- TODO: Setup

  -- Allow plugins to use the `.` key (if they support it).
  use 'tpope/vim-repeat'
end)

require('yashlala.lsp-comp').setup()
require('yashlala.autocmds').setup()

-- Load colorscheme *before* other plugins are set up.
vim.g.seoul256_srgb = 1
-- TODO: Set treesitter highlight groups in coloscheme. Mod it up. 
vim.api.nvim_command('colorscheme zenburned')
-- TODO: Highlight the signs column like we do in gitsigns.
vim.api.nvim_command('highlight WinSeparator guibg=None')

-- Disable legacy language providers (doesn't affect remote plugins)
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
