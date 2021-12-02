-- Vanilla Vim Options

-- TODO: Ask in the matrix room how to get highlights working. 
-- Nothing we do here seems to work. Been changing up the colors etc. 
-- We've installed fractal, a matrix client. use this to ask the developers in
-- the matrix room. 
vim.api.nvim_command('highlight HopNextKey  guifg=#00dfff gui=bold ctermfg=45 cterm=bold')
vim.api.nvim_command('highlight HopNextKey1 guifg=#00dfff gui=bold ctermfg=45 cterm=bold')
vim.api.nvim_command('highlight HopNextKey2 guifg=#2b8db3 ctermfg=33')
vim.api.nvim_command('highlight HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242')
vim.api.nvim_command('highlight link HopCursor Cursor')
vim.api.nvim_command('augroup HopInitHighlight')
vim.api.nvim_command('autocmd!')
vim.api.nvim_command("autocmd ColorScheme * lua require'hop.highlight'.insert_highlights()")
vim.api.nvim_command('augroup end')

vim.o.autochdir = true
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.confirm = true

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.o.gdefault = true
vim.o.hidden = true
vim.o.lazyredraw = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.joinspaces = false
vim.o.wrap = true
vim.o.linebreak = true
vim.o.modeline = true
vim.o.showmode = false
vim.o.mouse = 'a'
vim.o.scrollback = 8192
-- TODO: Was the below causing our weird highlight problems? 
vim.o.termguicolors = false
vim.o.undofile = true

-- Swap digits and special characters. We need to do this in `langmap` (as
-- opposed to regular bindings) because Vim isn't able to map all of its modes.
-- map them all (eg: operator-pending for some reason doesn't remap di
vim.o.langremap = false
vim.o.langmap = '1!,!1,2@,@2,3#,#3,$4,4$,5%,%5,6^,^6,7&,&7,8*,*8,9(,(9,0),)0'

-- Helper functions used in the keybinds above.
vim.api.nvim_command([[
  function! DeleteBufferAndUpdateLightline()
    exe 'bdelete'
    call lightline#update()
  endfunction
]])

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
  -- TODO: Is this causing the weird missing text in terminal mode? 
  -- use 'lukas-reineke/indent-blankline.nvim'

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
  use 'tpope/vim-commentary'
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
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'


  -- TODO: Enable Treesitter functionality. Has to be done explicitly.
  -- Highlighting, editing, etc. using incremental parsing.
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- use 'nvim-treesitter/nvim-treesitter'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin. TODO: broken.
  -- Autocompletion plugin
  use 'hrsh7th/nvim-cmp'

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










-- TODO: Set up a function that'll let us toggle on and off.
-- In the meantime, just use this to disable the virtual text.
require'toggle_lsp_diagnostics'.init({
  start_on = true,
  underline = true,
  virtual_text = false
})

-- Load colorscheme *before* other plugins are set up.
vim.g.seoul256_srgb = 1
vim.api.nvim_command('colorscheme seoul256')

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_filetype_exclude = { 'markdown', 'text', 'asciidoc' }

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
require('hop').setup()


require('project_nvim').setup({ manual_mode = true })
require('telescope').setup {}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('projects')

-- Git Plugin Setup

require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,
    ['n ]c'] = { expr = true,
      "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"
    },
    ['n [c'] = { expr = true,
      "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"
    },
    ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>tgb'] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',
    -- Text objects
    ['o ic'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ic'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  current_line_blame_opts = { virt_text_pos = 'eol', delay = 500 },
  diff_opts = { internal = true },
}


--[[
-- Language Specific Configuration
--]]

-- Set up smarter syntax highlighting using treesitter. 
require('nvim-treesitter.configs').setup({
  ensure_installed = "maintained", 
  sync_install = false, 
  ignore_install = { }, -- List of parsers
  highlight = {
    enable = true, 
    disable = { },  -- list of languages 
    additional_vim_regex_highlighting = false,
  },
})

-- Use Treesitter to implement the `=` indentation operator
require('nvim-treesitter.configs').setup({
  indent = { enable = true }
})

-- Define "incremental selection". When we already have a visual selection, 
-- we can use keybinds to expand or shrink the selection based on nearby
-- syntax. 
-- TODO: Verify if we actually need or use this. Might use it to replace
-- things...but probably not. Map something to `V`? 
require('nvim-treesitter.configs').setup({
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
} )

-- LSP Configurations are moved to the filetype-specific `after` configs.
-- EDIT: no they aren't. for some reason they don't work when we put them
-- TODO: Move them to the specific locations, find out what's up. 

require('lspconfig').ccls.setup({
  init_options = {
    cache = {
	directory = "/home/lala/.cache/ccls";
    };
    compilationDatabaseDirectory = "build";
    index = {
      threads = 1;
    };
    clang = {
      excludeArgs = { "-frounding-math"};
    };
  }
})

-- TODO: jdtls exits with error
--require('lspconfig').jdtls.setup{}
-- there.
-- require('lspconfig').pyright.setup({})
require('lspconfig').bashls.setup({})
-- require('lspconfig').texlab.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').gopls.setup({})
-- require('lspconfig').jedi_language_server.setup{}



--[[
BEGIN: THINGS I DON'T UNDERSTAND
--]]

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['luasnip#expand_or_jumpable']() == 1 then
    -- TODO: fix this condition, and this thing in the middle. It used to look
    -- like this:
    -- elseif vim.fn['vsnip#available'](1) == 1 then
    --  return t "<Plug>(vsnip-expand-or-jump)"
    -- TODO: adapt it to LuaSnip! The current code is a guess, and doesn't work right.
    return t "<Plug>(luasnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--[[
END (ish): THINGS I DON'T UNDERSTAND
--]]


--[[
vim.api.nvim_exec(
  filetype plugin indent on
  syntax enable
, false)
--]]



--[[
Autocommands
--]]

-- return to last edit position when opening files
vim.api.nvim_exec([[
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
]], false)

vim.api.nvim_exec([[
autocmd BufNewFile,BufRead neomutt-* set filetype=mail
]], false)

-- Close netrw buffers (we can't do this by default, for some reason).
vim.api.nvim_exec("autocmd Filetype netrw setl bufhidden=delete", false)

-- Enter terminal mode as soon as we create a terminal buffer.
vim.api.nvim_exec("autocmd TermOpen * startinsert", false)

-- The bottom status line doesn't update very often, so the buffer listing can
-- become stale. Avoid this by throwing in a few autocommands (we have a
-- function later in this file that mitigates this problem as well)
vim.api.nvim_exec([[
autocmd BufEnter,BufLeave,BufWritePost,BufHidden,BufWinEnter,BufWinLeave,CmdlineEnter,InsertEnter *
  \ call lightline#update()
]], false)



--[[
-- Keymaps
--]]

-- "Straightforward" Keymaps (there are more in the plugin setup funcs)

-- Vanilla Remaps

do
  vim.g.mapleader = ' '

  local function mapwrap(mode, key, value, args)
    vim.api.nvim_set_keymap(mode, key, value, args)
  end
  local function map(mode, key, value)
    vim.api.nvim_set_keymap(mode, key, value, { noremap = false })
  end
  local function smap(mode, key, value)
    vim.api.nvim_set_keymap(mode, key, value,
      { noremap = false, silent = true })
  end
  local function noremap(mode, key, value)
    mapwrap(mode, key, value, { noremap = true })
  end
  local function snoremap(mode, key, value)
    mapwrap(mode, key, value, { noremap = true, silent = true })
  end

  snoremap('n', ' ', '<nop>')

  snoremap('', 'Y', 'y$')
  noremap('', ';', ':')
  snoremap('', ':', 'q:')
  noremap('', "'", '`')
  noremap('', '`', '~')
  noremap('', '-', '0')
  noremap('', ';', ':')
  snoremap('', ':', 'q:')
  -- TODO: Add this functionality to all other keys when on a terminal window. 
  -- I guess we'll have to pass in something to the script? 
  noremap('n', '<bar>', 'K')
  noremap('n', 'K', 'kJ')
  noremap('n', 'U', '<c-r>')
  noremap('n', '<c-r>', 'U')
  noremap('n', 'v', 'V')
  snoremap( 'n', 'S', [[<cmd>keepp s/\\s*\%#\\s*/\\r/e <bar> norm! ==<CR>]])
  snoremap('', '&', '<cmd>&&<cr>')
  noremap('', '_', '<c-y>')
  noremap('', '+', '<c-e>')
  snoremap('n', '<c-n>', '<cmd>bnext<cr>')
  snoremap('n', '<c-p>', '<cmd>bprev<cr>')
  noremap('n', 'gs', ':%s/')
  map('', 'ga', '<Plug>(EasyAlign)')
  -- Simple Leader Keybinds
  snoremap('', '<leader>p', '"0p')
  noremap('n', '<bar>', 'K')
  noremap('n', 'K', 'kJ')
  noremap('n', 'U', '<c-r>')
  noremap('n', '<c-r>', 'U')
  noremap('n', 'v', 'V')
  snoremap( 'n', 'S', [[<cmd>keepp s/\\s*\%#\\s*/\\r/e <bar> norm! ==<CR>]])
  snoremap('', '&', '<cmd>&&<cr>')
  noremap('', '_', '<c-y>')
  noremap('', '+', '<c-e>')
  snoremap('n', '<c-n>', '<cmd>bnext<cr>')
  snoremap('n', '<c-p>', '<cmd>bprev<cr>')
  noremap('n', 'gs', ':%s/')
  map('', 'ga', '<Plug>(EasyAlign)')
  -- Simple Leader Keybinds
  snoremap('', '<leader>p', '"0p')
  snoremap('', '<leader>P', '"0P')
  smap('n', '<leader>d', '<cmd>call DeleteBufferAndUpdateLightline()<cr>')
  smap('n', '<leader>gg', '<cmd>G<cr>')
  smap('n', '<leader>o', '<cmd>silent !uwin<cr>')
  -- Terminal Mode Keybindings
  noremap('t', '<c-\\>', '<c-\\><c-n>')
  noremap('n', '<c-\\>', '<nop>') -- prevent current mode confusion
  noremap('i', '<c-\\>', '<esc>') -- just keep mashing, we'll get to normal
  -- EasyMotion Keybindings
  noremap('', 'f', '<nop>')
  map('', 'f', '<Plug>(easymotion-f)')
  map('', 'F', '<Plug>(easymotion-F)')
  map('', 't', '<Plug>(easymotion-t)')
  map('', 'T', '<Plug>(easymotion-T)')
  map('', 's', '<Plug>(easymotion-lineanywhere)')
  map('', '<leader>j', '<Plug>(easymotion-j)')
  map('', '<leader>k', '<Plug>(easymotion-k)')
  -- Diary Keybinds
  map('n', '<leader>ww', '<Plug>VimwikiMakeDiaryNote')
  map('n', '<leader>wi', '<Plug>VimwikiDiaryIndex')
  map('n', '<leader>wt', '<Plug>VimwikiMakeTomorrowDiaryNote')
  map('n', '<leader>wy', '<Plug>VimwikiMakeYesterdayDiaryNote')
  map('n', '<leader>w<leader>w', '<Plug>VimwikiIndex')
  -- Quick Buffer Switching Keybindings
  map('n', '<leader>!', '<Plug>lightline#bufferline#go(1)')
  map('n', '<leader>@', '<Plug>lightline#bufferline#go(2)')
  map('n', '<leader>#', '<Plug>lightline#bufferline#go(3)')
  map('n', '<leader>$', '<Plug>lightline#bufferline#go(4)')
  map('n', '<leader>%', '<Plug>lightline#bufferline#go(5)')
  map('n', '<leader>^', '<Plug>lightline#bufferline#go(6)')
  map('n', '<leader>&', '<Plug>lightline#bufferline#go(7)')
  map('n', '<leader>*', '<Plug>lightline#bufferline#go(8)')
  map('n', '<leader>(', '<Plug>lightline#bufferline#go(9)')
  -- Telescope Keybinds
  snoremap('n', ',',
      "<cmd>lua require('telescope.builtin').buffers({})<cr>")
  snoremap('n', '<leader>ff',
      "<cmd>lua require('telescope.builtin').find_files({})<cr>")
  snoremap('n', '<leader>fg',
      "<cmd>lua require('telescope.builtin').grep_string({})<cr>")
  snoremap('n', '<leader>fp',
      "<cmd>lua require('telescope.builtin').git_files({})<cr>")
  snoremap('n', '<leader>fo',
      "<cmd>lua require('telescope.builtin').oldfiles({})<cr>")
  snoremap('n', '<leader>fP', "<cmd>Telescope projects<cr>")
  -- LSP Keybinds
  snoremap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>')
  snoremap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  snoremap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  snoremap('n', '<bar>', '<cmd>lua vim.lsp.buf.hover()<cr>')
  map('n', '<leader>tl', '<Plug>(toggle-lsp-diag-default)')
end
