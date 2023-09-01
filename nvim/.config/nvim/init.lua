-- `init.lua`

-- TODO:
--
-- set nvim-cmp so it'll replace the ends of words. and so it'll only complete
-- till the ambiguity instead of for the longest match (wtf?).
--
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

  -- Dim unfocused nvim windows.
  -- This uses window local highlights -- so it must run last (after existing
  -- highlights are defined).
  use 'levouh/tint.nvim'

 -- Automatically match file format/indentation.
 -- TODO: Rewrite this so defaults make sense.
  use 'tpope/vim-sleuth'
  -- Strip trailing whitespace on lines we've modified. May cause issues.
  use 'thirtythreeforty/lessspace.vim'

  -- Vim motions that don't require counts.
  -- TODO: switch to https://github.com/folke/flash.nvim
  use 'smoka7/hop.nvim'

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
  -- Marks with longer names
  use { 'yashlala/marker.nvim',
    config = function() require('marker').setup() end
  }

  -- Project-specific terminals
  use 'ThePrimeagen/harpoon'
  -- Use for a generic persistent terminal keybind.
  use 'akinsho/toggleterm.nvim'
  -- Delete a buffer without affecting the window layout.
  use 'yashlala/vim-sayonara'
  -- TODO: Make a telescope previewer for the marks in the current buffer.

  -- Collection of configurations for built-in LSP client
  use {
    -- Setup in this order for mason and nvim-lspconfig to play nice.
    -- See mason-lspconfig.nvim README.
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  }
  -- Pretty icons for LSP windows
  use 'onsails/lspkind-nvim'

  -- Edit remote files, even if LSP is only installed on this computer
  use { 'chipsenkbeil/distant.nvim', branch = 'v0.2' }

  -- Debugger integration
  use 'mfussenegger/nvim-dap'
  use { 'mfussenegger/nvim-dap-python', after = 'nvim-dap' }

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
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'


  -- NOTE: LuaSnip uses select-mode to highlight fields prior to replacing
  -- them. Eg ([X] := "X is highlighted, visually):
  --
  --    for (int [varNameHere]; ...)
  --
  -- Mappings defined with `v(nore)map` apply to visual _and_ select modes. So
  -- `vnoremap s <Plug>(SubversiveSubstitute)` will make it impossible to type
  -- variable names starting with "s". Always use `xmap` instead of `vmap`
  -- while we have LuaSnip installed.
  use { 'L3MON4D3/LuaSnip', after = { 'nvim-cmp', 'friendly-snippets' },
    tag = 'v1.*', run = 'make install_jsregexp' }
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets' -- Prepopulated list of snippets for LuaSnip

  -- Better menu for LSP code actions
  use 'weilbith/nvim-code-action-menu'
  -- Easier indentation guides
  use 'lukas-reineke/indent-blankline.nvim'

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
