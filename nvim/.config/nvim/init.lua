-- `init.lua`
--
-- This serves primarily as a dispatcher 


-- Cache our compiled config modules. 
pcall(require, 'impatient')

-- Set this early on, so all modules will see it. 
vim.g.mapleader = ' '

-- If this is the first time we're running Neovim, install packer.nvim etc. 
require('lala.fresh-install')()


-- Vanilla Vim Options

-- Swap digits and special characters. We need to do this in `langmap` (as
-- opposed to regular bindings) because Vim isn't able to map all of its modes.
-- map them all (eg: operator-pending for some reason doesn't remap di
vim.o.langremap = false
vim.o.langmap = '1!,!1,2@,@2,3#,#3,$4,4$,5%,%5,6^,^6,7&,&7,8*,*8,9(,(9,0),)0'

-- Plugins

-- Install packer if needed.
local packer_install_path = (vim.fn.stdpath('data')
  .. '/site/pack/packer/start/packer.nvim')
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim '
  .. packer_install_path)
end
-- Re-compile packer after any edits to our config file.
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
    autocmd BufWritePost init.vim PackerCompile
  augroup end
]], true)

-- Load plugins.
local use = require('packer').use
require('packer').startup(function()
  -- Cache lua modules. Will eventually be merged into mainline. 
  use 'lewis6991/impatient.nvim'

  -- Package manager.
  use 'wbthomason/packer.nvim'
  -- Fancier statusline.
  use 'itchyny/lightline.vim'
  -- Buffer list for statusline.
  use 'mengelbrecht/lightline-bufferline'
  -- Indentation guides.
  -- Colorscheme.
  use 'junegunn/seoul256.vim'
  use 'overcache/NeoSolarized'
  use 'nisavid/vim-colors-solarized'
  use 'tjdevries/colorbuddy.nvim'

  -- Diary + Wiki
  use 'vimwiki/vimwiki'

 -- Automatically match file format/indentation.
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
  use 'itchyny/calendar.vim' -- TODO: Can't select diary date? 
  -- Git commands + Status page.
  use 'tpope/vim-fugitive'
  -- Git related info in signs column and popups.
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- TODO: Try neogit instead
  -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- File Browser
  -- TODO: Set up.

  -- Highlighting
  -- use { 'kyazdani42/nvim-tree.lua',
  --   requires = { 'kyazdani42/nvim-web-devicons' }
  -- }

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
  use { 'nvim-telescope/telescope-fzy-native.nvim', requires = {
    { 'nvim-telescope/telescope.nvim' } }
  }
  -- Automatically `cd` to project root. Integrates with Telescope.
  -- Use this to quickly return to old projects (as opposed to searching *in*
  -- a project, which we do with the regular telescope builtins.
  -- TODO: Why aren't we listing previous projects anymore? 
  use "ahmedkhalf/project.nvim"

  -- Allow plugins to use the `.` key (if they support it).
  use 'tpope/vim-repeat'
end)


--[[
Kinkier Configuration
--]]



-- Load colorscheme *before* other plugins are set up.
vim.g.seoul256_srgb = 1
vim.api.nvim_command('colorscheme seoul256')

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

vim.api.nvim_exec([[
let g:vimwiki_list = [{'path': '~/documents/vimwiki/', 'syntax': 'markdown', 
      \ 'auto_diary_index': 1, 'auto_generate_links': 1, 'ext': '.md'}]
]], false)

vim.g.go_doc_keywordprg_enabled = 0 -- disable K keybind.

vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1


require('project_nvim').setup({ manual_mode = true })
require('telescope').setup {}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('projects')


--[[
-- Language Specific Configuration
--]]

-- Source basic options and keymaps first. 
-- All more complicated things are in the `after/plugin` dir. 

require('lala.options')()
require('lala.keymaps')()

